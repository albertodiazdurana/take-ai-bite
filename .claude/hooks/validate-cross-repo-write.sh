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

# Read JSON from stdin and extract file_path
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', ''))
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
