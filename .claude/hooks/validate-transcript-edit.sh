#!/bin/bash
# Hook: Enforce session transcript append-only rule (DSM_0.2 §7)
# Fires on PreToolUse for Edit calls to *session-transcript.md
# Three validations:
# 1. old_string must be anchored to the last non-empty line of the file
# 2. new_string must start with old_string (append-only, no replacement)
# 3. Appended content must contain a <------------Start {timestamp}------------>
#    delimiter (ensures every entry is timestamped)

set -e

# Read JSON from stdin and extract fields
INPUT=$(cat)
eval "$(echo "$INPUT" | python3 -c "
import sys, json, shlex
data = json.load(sys.stdin)
ti = data.get('tool_input', {})
print(f'FILE_PATH={shlex.quote(ti.get(\"file_path\", \"\"))}')
print(f'OLD_STRING={shlex.quote(ti.get(\"old_string\", \"\"))}')
print(f'NEW_STRING={shlex.quote(ti.get(\"new_string\", \"\"))}')
")"

# Only validate session-transcript.md edits
if [[ ! "$FILE_PATH" =~ \.claude/session-transcript\.md$ ]]; then
  exit 0
fi

# If file doesn't exist yet, allow (initial creation via Write)
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
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
BLOCKED: Session transcript violation — wrong anchor (DSM_0.2 §7, check 1/3).

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
BLOCKED: Session transcript violation — content replaced (DSM_0.2 §7, check 2/3).

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
BLOCKED: Session transcript violation — missing delimiter (DSM_0.2 §7, check 3/3).

Every appended entry must contain a timestamped delimiter:
  <------------Start {timestamp}------------>

Your appended content does not contain this delimiter.

FIX: Start your appended block with:
  <------------Start Thinking / HH:MM------------>
or for output blocks:
  <------------Start Output / HH:MM------------>
EOF
  exit 2
fi

# All checks passed
exit 0
