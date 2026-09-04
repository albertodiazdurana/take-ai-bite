#!/bin/bash
# Hook: Enforce cross-repo write confirmation (BL-391)
# Fires on PreToolUse for Write / Edit calls. Extracts file_path from
# tool input, canonicalizes, compares against the current git repo
# root. Writes to paths inside the repo are allowed unconditionally.
# Writes to paths outside the repo require prior confirmation in
# .claude/cross-repo-writes-session.txt (one entry per confirmed
# target per session, cleared at /dsm-go session start).
#
# DSM_0.2.C §2 Destructive Action Protocol enforcement layer for the
# cross-repo write bullet. Reference model: BL-318 (transcript hook
# pair). This is the validate-half of the pattern; the require-half
# (UserPromptSubmit) is not needed because the trigger is tool-call-
# driven, not turn-driven.
#
# Exit codes:
#   0 — allow (inside repo, previously confirmed, or no git context)
#   2 — block (cross-repo write to unconfirmed target)
#
# Origin: BL-320 audit Rank 1, filed S195 as BL-391, implemented S206.

set -e

# Read JSON from stdin and extract the target path.
# Defensive multi-key extraction (BL-440): different file-modifying tools
# and Claude Code harness versions carry the target path under different
# tool_input keys (Write/Edit use file_path; some edit variants use
# target_file or path; NotebookEdit uses notebook_path). Reading only
# file_path silently allowed any tool that named the field differently
# (cross-repo write gate bypass). Try each known key, first non-empty wins.
INPUT=$(cat)

# --- Bash branch (BL-484) -------------------------------------------------
# DSM_0.2.C states the cross-repo rule tool-agnostically, but until BL-484
# this hook was registered on Write and Edit only, so every Bash file
# operation (cp, mv, >, >>, tee, rsync, install) reached any path ungated.
# A spoke lost 181 reasoning-lessons entries to an `awk >` redirect and
# recovered from git by timing rather than by any control.
#
# Shell is not statically analysable, so this branch WARNS rather than
# blocks. Two reasons, both deliberate:
#   1. A parser that blocks on a guess produces false blocks on ordinary
#      commands, and a gate the user learns to dismiss is worse than no
#      gate, because a reflex-accepted gate still reads as protection.
#   2. Detection here is a floor, not a proof. Variable-constructed paths,
#      eval, and computed here-doc targets evade it by design.
# Coverage limits are stated in DSM_0.2.C so the prose does not over-claim
# relative to the mechanism.
#
# Exit 1 (not 2) is the non-blocking channel: stderr surfaces to the user
# without vetoing the call.
TOOL_NAME=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    print(json.load(sys.stdin).get('tool_name', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

if [ "$TOOL_NAME" = "Bash" ]; then
  if ! REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null); then
    exit 0
  fi
  REPO_ROOT="${REPO_ROOT%/}"

  CONFIRM_FILE="$REPO_ROOT/.claude/cross-repo-writes-session.txt"

  HITS=$(echo "$INPUT" | REPO_ROOT="$REPO_ROOT" CONFIRM_FILE="$CONFIRM_FILE" python3 -c "
import sys, json, os, re

repo = os.environ['REPO_ROOT'].rstrip('/')
confirm_file = os.environ['CONFIRM_FILE']
home = os.path.expanduser('~')

try:
    cmd = json.load(sys.stdin).get('tool_input', {}).get('command', '') or ''
except Exception:
    sys.exit(0)

# Write-shaped constructs only. Read-only commands (cat, ls, grep) never
# match unless they carry a redirect, which is itself the write.
targets = []

# Redirections: > path and >> path. Excludes >&2, >&1 and numbered fds.
for m in re.finditer(r'>>?\s*([^\s;|&<>()]+)', cmd):
    targets.append(m.group(1))

# Destination-last commands. Takes the final non-flag token as the target.
for m in re.finditer(r'\b(?:cp|mv|rsync|install)\b((?:\s+(?:-[^\s]+|[^\s;|&<>()]+))+)', cmd):
    args = [a for a in m.group(1).split() if not a.startswith('-')]
    if len(args) >= 2:
        targets.append(args[-1])

# tee writes every path argument.
for m in re.finditer(r'\btee\b((?:\s+(?:-[^\s]+|[^\s;|&<>()]+))+)', cmd):
    for a in m.group(1).split():
        if not a.startswith('-'):
            targets.append(a)

confirmed = []
if os.path.isfile(confirm_file):
    with open(confirm_file) as fh:
        for line in fh:
            line = line.strip()
            if line and not line.startswith('#'):
                confirmed.append(line.rstrip('/'))

def allowlisted(p):
    # Harness scratchpad and ordinary scratch space are outside the repo by
    # design and are written constantly. Warning on them is the noise that
    # trains bypass. /tmp is not a repo, so it is not a cross-repo target.
    if p.startswith('/dev/'):
        return True
    if p.startswith('/tmp/') or p == '/tmp':
        return True
    return False

# --- cd base resolution (BL-532) -----------------------------------------
# os.getcwd() is the HOOK process's directory, which is the repo root. It is
# NOT the directory the inspected command establishes for itself. Before this
# block, a command shaped
#     cd <outside-repo> && cat > note.md
# resolved note.md to <repo-root>/note.md, matched the in-repo test below, and
# was skipped in silence: the write landed outside the repo with no warning.
#
# Resolution base is the LAST literal cd in the command, which is the one
# nearest the write. A cd whose target is variable-constructed or command-
# substituted cannot be resolved statically and leaves the base unchanged,
# preserving the pre-existing skip rather than erroring.
#
# NOT COVERED. Stated explicitly because the §22 root cause of BL-484 was
# prose over-claiming what the mechanism delivers:
#   - The Bash tool's working directory PERSISTS between calls. A cd issued in
#     an EARLIER call moves the base for a later relative write and is
#     invisible to this hook, which sees one command at a time.
#   - pushd/popd, cd inside a subshell or shell function, and cd whose target
#     is command-substituted.
#   - Any write whose target the extraction regexes above do not match.
# This block narrows the hole; it does not close it.
cd_base = None
for m in re.finditer(r'(?:^|[;&|])\s*cd\s+([^\s;|&<>()]+)', cmd):
    raw = m.group(1).strip().strip('\"\\'')
    if not raw or '\$' in raw or '\`' in raw:
        continue
    if raw.startswith('~'):
        raw = home + raw[1:]
    if not os.path.isabs(raw):
        raw = os.path.join(os.getcwd(), raw)
    cd_base = os.path.normpath(raw)

base = cd_base if cd_base else os.getcwd()

hits = []
seen = set()
skipped_unresolved = False
for t in targets:
    t = t.strip().strip('\"\\'')
    if not t or t.startswith('&'):
        continue
    if t.startswith('~'):
        t = home + t[1:]
    if '\$' in t:            # variable-constructed; cannot resolve statically
        skipped_unresolved = True
        continue
    if not os.path.isabs(t):
        t = os.path.join(base, t)
    t = os.path.normpath(t)
    if allowlisted(t):
        continue
    if t == repo or t.startswith(repo + '/'):
        continue
    if any(t == c or t.startswith(c + '/') for c in confirmed):
        continue
    if t not in seen:
        seen.add(t)
        hits.append(t)

# Backstop (BL-532). The block above resolves a relative write against a
# literal cd. It cannot resolve a write target that is itself variable-
# constructed, so 'cd /outside && cat > VAR.md' would fall through in silence
# even though the cd is known and known to be outside the repo. Warn on the
# directory instead of the file.
#
# Three conditions, each one an over-firing guard (DSM_0.2 §8.9.2):
#   - cd_base is set, so a variable cd still degrades to silence;
#   - a write target was actually skipped as unresolvable, so an ordinary
#     'cd /elsewhere && ls' with no write stays silent, and so does a command
#     whose targets all resolved cleanly;
#   - cd_base is outside the repo, not allowlisted, and not already confirmed.
if cd_base and skipped_unresolved:
    outside = not (cd_base == repo or cd_base.startswith(repo + '/'))
    if outside and not allowlisted(cd_base):
        if not any(cd_base == c or cd_base.startswith(c + '/') for c in confirmed):
            if cd_base not in seen:
                seen.add(cd_base)
                hits.append(cd_base + '/  (cd target; write filename not statically resolvable)')

for h in hits:
    print(h)
" 2>/dev/null || echo "")

  if [ -n "$HITS" ]; then
    {
      echo "Cross-repo Bash write warning (DSM_0.2.C §2, BL-484)."
      echo
      echo "This Bash command appears to write outside the repo:"
      echo "$HITS" | sed 's/^/  /'
      echo
      echo "Repo root: $REPO_ROOT"
      echo
      echo "This is a WARNING, not a block: shell write targets cannot be"
      echo "determined reliably, so this check is a floor rather than a proof."
      echo "If the write is intended, confirm the target to silence future"
      echo "warnings for it:"
      echo "  echo '<target-or-parent-dir>' >> $CONFIRM_FILE"
    } >&2
    exit 1
  fi
  exit 0
fi
# --- end Bash branch ------------------------------------------------------

FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    ti = json.load(sys.stdin).get('tool_input', {})
    for key in ('file_path', 'path', 'target_file', 'notebook_path'):
        val = ti.get(key)
        if val:
            print(val)
            break
    else:
        print('')
except Exception:
    print('')
" 2>/dev/null || echo "")

# No file_path -> nothing to validate
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# If we're not inside a git repo, degrade gracefully (allow)
if ! REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null); then
  exit 0
fi

# Canonicalize file_path: expand ~, resolve relative-to-cwd, follow symlinks
# via realpath. If the path doesn't exist yet (Write creating new file),
# canonicalize the parent directory and append the basename.
case "$FILE_PATH" in
  "~"*) FILE_PATH="${FILE_PATH/#\~/$HOME}" ;;
esac

if [ -e "$FILE_PATH" ]; then
  CANON_PATH=$(realpath "$FILE_PATH" 2>/dev/null) || CANON_PATH="$FILE_PATH"
else
  PARENT=$(dirname "$FILE_PATH")
  BASE=$(basename "$FILE_PATH")
  if [ -d "$PARENT" ]; then
    CANON_PARENT=$(realpath "$PARENT" 2>/dev/null) || CANON_PARENT="$PARENT"
    CANON_PATH="$CANON_PARENT/$BASE"
  else
    # Parent does not exist either; treat as absolute-ish path. If
    # relative, prefix with PWD.
    case "$FILE_PATH" in
      /*) CANON_PATH="$FILE_PATH" ;;
      *) CANON_PATH="$PWD/$FILE_PATH" ;;
    esac
  fi
fi

# Strip trailing slash for normalization
CANON_PATH="${CANON_PATH%/}"
REPO_ROOT="${REPO_ROOT%/}"

# Inside the repo? allow
case "$CANON_PATH" in
  "$REPO_ROOT"/*|"$REPO_ROOT") exit 0 ;;
esac

# Cross-repo write. Check session confirmation file.
CONFIRM_FILE="$REPO_ROOT/.claude/cross-repo-writes-session.txt"
if [ -f "$CONFIRM_FILE" ]; then
  # Each line is a confirmed prefix (canonicalized at confirm time).
  # Match if CANON_PATH starts with any confirmed prefix.
  while IFS= read -r CONFIRMED || [ -n "$CONFIRMED" ]; do
    # Skip empty lines and comments
    case "$CONFIRMED" in
      ""|"#"*) continue ;;
    esac
    CONFIRMED="${CONFIRMED%/}"
    case "$CANON_PATH" in
      "$CONFIRMED"/*|"$CONFIRMED") exit 0 ;;
    esac
  done < "$CONFIRM_FILE"
fi

# Block: cross-repo write to unconfirmed target
cat >&2 << EOF
Cross-repo write blocked (DSM_0.2.C §2, BL-391).

Target: $CANON_PATH
Repo root: $REPO_ROOT

This write targets a path outside the current repo and has not been
confirmed in this session. Per the Destructive Action Protocol, the
first cross-repo write to a new target requires explicit user
confirmation.

To confirm and proceed:
  echo '$CANON_PATH' >> $CONFIRM_FILE
  # then retry the Write/Edit

Or confirm a parent directory to allow all writes within it:
  echo '<parent-dir>' >> $CONFIRM_FILE

The session file is cleared at /dsm-go session start.
EOF

exit 2
