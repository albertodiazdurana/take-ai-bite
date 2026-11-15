#!/bin/bash
# Hook: Enforce session transcript append-only rule (DSM_0.2 §7)
# Fires on PreToolUse for Edit calls to *session-transcript.md, and (BL-552)
# for Bash calls that redirect into it. The two paths validate different
# things because different things are knowable: the Edit path sees old_string
# and new_string and checks all four rules below; the Bash path sees only a
# command string and checks the two that survive that (delimiter present, and
# the unquoted-heredoc backtick hazard). The Bash branch states its own
# coverage limits at its head rather than here.
# Four validations on the Edit path (0-3 block; 4 warns):
# 1. old_string must be anchored to the last non-empty line of the file
# 2. new_string must start with old_string (append-only, no replacement)
# 3. Appended content must contain a <------------Start {timestamp}------------>
#    delimiter (ensures every entry is timestamped)

set -e

# Read JSON from stdin and extract fields
INPUT=$(cat)

# --- Bash branch (BL-552) -------------------------------------------------
# DSM_0.2 §7 sanctions TWO append paths and, until this branch, only one was
# inspected. This hook was registered on the Edit matcher alone, so a Bash
# heredoc append reached the transcript ungated , and the heredoc is not an
# exotic path: §7 names it the REQUIRED fallback whenever the Edit path is
# closed, which BL-500 documents as the case where the last non-empty line
# recurs earlier in the file and the anchor rule and Edit's uniqueness rule
# become jointly unsatisfiable.
#
# So the sanctioned fallback was, by construction, the unvalidated one, and
# the hook routed its own catch into its own blind spot: in S258 check 1/4
# correctly BLOCKED a two-line Edit anchor, the recovery went through an
# unquoted heredoc, and three backtick-quoted spans were executed as shell
# commands instead of being written. The surviving prose still read as fluent
# English with the spans simply missing. Recorded by four consecutive analysis
# runs (S252, S253, S254, S258) before it was filed.
#
# WARN, never block; detection is a floor, not a proof. Both choices are
# INHERITED from validate-cross-repo-write.sh's BL-484 branch rather than
# re-decided: shell is not statically analysable, a parser that blocks on a
# guess produces false blocks on ordinary commands, and a gate the operator
# learns to dismiss is worse than no gate, because a reflex-dismissed gate
# still reads as protection. Exit 1 is the documented non-blocking channel.
#
# WHO SEES THE WARNING (measured S259, 2026-09-09). A non-zero hook exit is
# recorded in the session JSONL as a hook_non_blocking_error attachment carrying
# the full stderr, which reaches the transcript and the UI. It is NOT surfaced
# into the tool result the AGENT reads. So this branch warns the human and the
# record, not the writer, and it is a detector for review rather than a live
# correction. Same correction applied to validate-cross-repo-write.sh, whose
# BL-484 comment carried the imprecise wording this inherited.
#
# NOT COVERED, stated so this branch does not over-claim relative to what it
# actually inspects:
#   * Check 1's ANCHOR has no Bash analogue. A heredoc append carries no
#     old_string, so there is nothing to anchor and nothing to compare.
#   * Check 2's APPEND-ONLY becomes the truncating `>` redirect, which is
#     deliberately NOT flagged: /dsm-go Step 6 legitimately resets the
#     transcript with `cat > ... << EOF` at every boot, so flagging it would
#     fire on ordinary work in every session, which is the over-firing
#     failure DSM_0.2 §8.9.2 names. Accepted as a coverage limit.
#   * Check 4's timestamp drift stays Edit-only rather than being duplicated
#     here; two copies of the same arithmetic drift apart, which is the
#     BL-490 restated-literal family.
#   * Variable-constructed paths, eval, and computed heredoc targets evade
#     the redirect match by design.
TOOL_NAME=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    print(json.load(sys.stdin).get('tool_name', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

if [ "$TOOL_NAME" = "Bash" ]; then
  # No '&&' at statement head anywhere below: under 'set -e' a false test in
  # an AND-list aborts the hook, turning a warning into a silent veto
  # (DSM_0.2 §19.2's family). The existing check 4 carries the same warning.
  BASH_FINDINGS=$(echo "$INPUT" | python3 -c '
import sys, json, re
try:
    cmd = json.load(sys.stdin).get("tool_input", {}).get("command", "") or ""
except Exception:
    sys.exit(0)

# Only commands that redirect into the session transcript are inspected.
# Everything else produces no output at all (the over-firing control).
if not re.search(r">>?\s*[^\s|;&]*\.claude/session-transcript\.md", cmd):
    sys.exit(0)

out = []
# \x27 and \x22 are the quote characters, written as escapes because this
# program is delivered inside a single-quoted shell string.
for m in re.finditer(r"<<-?\s*([\x27\x22]?)([A-Za-z_][A-Za-z0-9_]*)\1", cmd):
    quote, delim = m.group(1), m.group(2)
    rest = cmd[m.end():]
    end = re.search(r"^[ \t]*" + re.escape(delim) + r"[ \t]*$", rest, re.M)
    body = rest[:end.start()] if end else rest
    if "<------------Start " not in body:
        out.append("B1|no timestamped delimiter in the appended block")
    if quote == "" and "\x60" in body:
        out.append("B2|unquoted heredoc whose body contains a backtick")
print("\n".join(out))
' 2>/dev/null || true)

  if [ -n "$BASH_FINDINGS" ]; then
    cat >&2 <<WARNEOF
WARNING: Session transcript Bash append (DSM_0.2 §7, BL-552).

$BASH_FINDINGS

This is a WARNING, not a block. The command has gone through.

B1 , every appended entry must carry a delimiter:
  <------------Start Plan / HH:MM------------>

B2 , an UNQUOTED heredoc performs command substitution on backticks as well as
on \$(...). A backtick-quoted term in ordinary prose is EXECUTED and replaced by
its output, and the surviving text still reads as fluent English with the span
missing. DSM_0.2 §7 names only the \$(...) direction; BACKLOG-500 is the
protocol-text half of this gap.
FIX: single-quote the heredoc (<< 'EOF') when the body contains backticks, or
prefer the Edit append path, which this hook validates in full.
WARNEOF
    exit 1
  fi
  exit 0
fi

eval "$(echo "$INPUT" | python3 -c "
import sys, json, shlex
data = json.load(sys.stdin)
ti = data.get('tool_input', {})
print(f'FILE_PATH={shlex.quote(ti.get(\"file_path\", \"\"))}')
print(f'OLD_STRING={shlex.quote(ti.get(\"old_string\", \"\"))}')
print(f'NEW_STRING={shlex.quote(ti.get(\"new_string\", \"\"))}')
print(f'REPLACE_ALL={shlex.quote(\"true\" if ti.get(\"replace_all\", False) else \"\")}')
")"

# Only validate session-transcript.md edits
if [[ ! "$FILE_PATH" =~ \.claude/session-transcript\.md$ ]]; then
  exit 0
fi

# If file doesn't exist yet, allow (initial creation via Write)
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# --- Check 0: replace_all is categorically forbidden on the transcript ---
# (DSM_0.2 §7; BL-449). The append-anchor rule assumes a unique last-line
# anchor; replace_all duplicates new content at EVERY match, exploding the file
# (S17: 95 MB / 1.5M lines; S22: Output block duplicated).
# This check runs before the anchor/append/delimiter checks because replace_all
# is wrong regardless of their state.
if [[ "$REPLACE_ALL" == "true" ]]; then
  cat >&2 <<EOF
BLOCKED: Session transcript violation — replace_all forbidden (DSM_0.2 §7, check 0/4).

Edit with replace_all: true is never allowed on .claude/session-transcript.md.
The append-anchor rule assumes a unique last-line anchor; replace_all duplicates
your new content at every match and explodes the file (S17: 95 MB).

FIX: Use a normal append Edit (replace_all absent/false): read the last 3 lines,
anchor old_string on the last non-empty line, set new_string = old_string + new
content. To recover from a botched transcript Edit, append a [RETROACTIVE] note
via a Bash heredoc — never a replace_all cleanup.
EOF
  exit 2
fi

# Get last non-empty line from the file
LAST_LINE=$(grep -v '^[[:space:]]*$' "$FILE_PATH" | tail -1)
if [[ -z "$LAST_LINE" ]]; then
  exit 0
fi

# Extract first line of old_string for matching
FIRST_OLD_LINE=$(echo "$OLD_STRING" | head -1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
if [[ -z "$FIRST_OLD_LINE" ]]; then
  exit 0
fi

# --- Check 1: old_string anchored to last non-empty line ---
if ! echo "$LAST_LINE" | grep -qF -- "$FIRST_OLD_LINE"; then
  cat >&2 <<EOF
BLOCKED: Session transcript violation — wrong anchor (DSM_0.2 §7, check 1/4).

old_string is not anchored to the last non-empty line of the file.

Last non-empty line:
  $LAST_LINE

Your old_string started with:
  $FIRST_OLD_LINE

FIX: Read the last 3 lines of .claude/session-transcript.md, use the last
non-empty line as old_string, and append new content after it.
EOF
  exit 2
fi

# --- Check 2: new_string starts with old_string (append-only) ---
if [[ "$NEW_STRING" != "$OLD_STRING"* ]]; then
  cat >&2 <<EOF
BLOCKED: Session transcript violation — content replaced (DSM_0.2 §7, check 2/4).

new_string must START WITH old_string verbatim. You are replacing content
instead of appending after it.

FIX: new_string = old_string + new content. Preserve old_string at the start.
EOF
  exit 2
fi

# --- Check 3: appended content contains a timestamped delimiter ---
# Extract the appended part (new_string minus old_string prefix)
APPENDED="${NEW_STRING#"$OLD_STRING"}"

# Check for <------------Start {anything}------------>
if ! echo "$APPENDED" | grep -q '<------------Start '; then
  cat >&2 <<EOF
BLOCKED: Session transcript violation — missing delimiter (DSM_0.2 §7, check 3/4).

Every appended entry must contain a timestamped delimiter:
  <------------Start {timestamp}------------>

Your appended content does not contain this delimiter.

FIX: Start your appended block with:
  <------------Start Plan / HH:MM------------>
or for output blocks:
  <------------Start Output / HH:MM------------>
EOF
  exit 2
fi

# --- Check 4: delimiter timestamp against the wall clock (WARNS, never blocks) ---
# (DSM_0.2 §7; BL-517). Checks 0-3 validate the SHAPE of an append; this one
# validates the VALUE of the timestamp it carries. Three recorded incidents of
# HH:MM drift (S234 ~13h, S248 ~8h27m, S249 a non-monotone 132-minute swing in
# both directions) went undetected because no check ever read the number.
#
# Exit 1 (not 2) is the non-blocking channel: stderr surfaces to the user
# without vetoing the call. The same convention validate-cross-repo-write.sh
# documents, and chosen here for the same reason. The harm from a drifted
# stamp is a mislabelled log entry, not a corrupted file, and blocking an
# append over it would wedge the very protocol the hook exists to keep running.
#
# [RETROACTIVE] delimiters are deliberately NOT exempt: §7 requires them to
# carry the CURRENT time, so they must satisfy this check like any other.
#
# Tolerance is 5 minutes, not the 10 the BL proposed. That figure rested on
# "both observed failures were off by hours"; S249's drift was sub-hour and a
# 10-minute bound would have passed most of it. Warning rather than blocking
# is what makes tightening cheap: a false positive costs one line of stderr.
DELIM_TS=$(printf '%s' "$APPENDED" | grep -oE '<-+Start [^>]*[0-9]{2}:[0-9]{2}-+>' | head -1 | grep -oE '[0-9]{2}:[0-9]{2}' | head -1 || true)

if [ -n "$DELIM_TS" ]; then
  NOW_TS=$(date +%H:%M)
  # 10# forces base 10: "08" and "09" are invalid octal and would abort here.
  D_MIN=$(( 10#${DELIM_TS%%:*} * 60 + 10#${DELIM_TS##*:} ))
  N_MIN=$(( 10#${NOW_TS%%:*} * 60 + 10#${NOW_TS##*:} ))
  DRIFT=$(( D_MIN - N_MIN ))
  if [ "$DRIFT" -lt 0 ]; then
    DRIFT=$(( 0 - DRIFT ))
  fi
  # Take the smaller of the direct and wrap-around distance, so a block
  # composed at 23:59 and written at 00:01 reads as 2 minutes, not 1438.
  WRAP=$(( 1440 - DRIFT ))
  if [ "$WRAP" -lt "$DRIFT" ]; then
    DRIFT=$WRAP
  fi
  # No `&&` chaining anywhere above: under `set -e`, a false test at the head
  # of an AND-list aborts the hook, which would turn a warning into a silent
  # veto (DSM_0.2 §19.2's family).
  if [ "$DRIFT" -gt 5 ]; then
    cat >&2 <<WARNEOF
WARNING: Session transcript delimiter timestamp drift (DSM_0.2 §7, check 4/4).

  delimiter says : $DELIM_TS
  wall clock is  : $NOW_TS
  drift          : $DRIFT minutes

This is a WARNING, not a block. The append has gone through.

A delimiter's HH:MM is the time the block BEGINS, read from the clock at that
moment, never carried forward from an earlier block or estimated. A drifted
stamp makes the transcript unusable as a timeline: three recorded sessions had
an action logged BEFORE the turn that authorised it.

FIX: read the clock (\`date +%H:%M\`) when you open the block. If this append is
a [RETROACTIVE] entry, it must still carry the CURRENT time, not the time you
are reconstructing.
WARNEOF
    exit 1
  fi
fi

# All checks passed
exit 0
