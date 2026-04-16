#!/bin/bash
# Hook: Catch git-mv + unstaged content change before commit (BL-370)
# Fires on PreToolUse for Bash calls. Filters to commands starting with
# `git commit` (or variants). For each staged rename (R-typed entry in
# `git diff --cached --name-status`), checks whether the new path has
# unstaged content changes. If yes, blocks the commit with a clear
# bypass message.
#
# Origin: three sightings in DSM Central (S184 BL-349, S190 IronCalc
# inbox move, S191 /dsm-light-go checkpoint annotation). MEMORY
# captured the lesson; this hook enforces it.
#
# Exit codes:
#   0 — allow (no renames, or no unstaged content at renamed paths)
#   2 — block (staged rename has unstaged content at new path)

set -e

# Read JSON from stdin and extract the Bash command
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
print(data.get('tool_input', {}).get('command', ''))
" 2>/dev/null || echo "")

# Only validate git commit calls. Accept 'git commit', 'git -C ... commit',
# and commands where 'git commit' appears after cd/&&/; but not inside a
# heredoc body or as literal text in an echo. Cheap heuristic: match on
# leading word-boundary `git commit` or after typical separators.
if ! echo "$COMMAND" | grep -qE '(^|&&|[;]|\s)git\s+(-C\s+\S+\s+)?commit\b'; then
  exit 0
fi

# If we're not inside a git repo, nothing to check.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exit 0
fi

# Collect staged renames (R-typed rows in diff --cached --name-status).
# Format per row: "R<score>\t<old_path>\t<new_path>". We need <new_path>.
RENAMES=$(git diff --cached --name-status --diff-filter=R 2>/dev/null | awk -F'\t' '{print $3}')

if [[ -z "$RENAMES" ]]; then
  # No staged renames; nothing for this hook to check.
  exit 0
fi

# For each renamed new_path, check if the working tree has unstaged content
# differing from the staged version. `git diff --exit-code -- <path>`
# returns 0 if clean, 1 if the working tree differs from the index.
OFFENDERS=()
while IFS= read -r new_path; do
  [[ -z "$new_path" ]] && continue
  if ! git diff --exit-code --quiet -- "$new_path" 2>/dev/null; then
    OFFENDERS+=("$new_path")
  fi
done <<< "$RENAMES"

if [[ ${#OFFENDERS[@]} -eq 0 ]]; then
  exit 0
fi

cat >&2 <<EOF
[BL-370 hook] Blocked: staged rename has unstaged content changes.

The following renamed path(s) differ between the working tree and the index.
If you run the commit now, the rename will land but the content changes
will not, producing a misleading split history.

Offending path(s):
EOF

for p in "${OFFENDERS[@]}"; do
  echo "  - $p" >&2
done

cat >&2 <<EOF

To resolve:
  1. Stage the content: git add ${OFFENDERS[*]}
     Then retry the commit.
  2. Or deliberately commit rename-only now, content later:
     git commit --no-verify  (bypasses this hook; use sparingly)

Background: git mv does not restage content changes made before the rename.
The lesson has been captured in MEMORY.md and now enforced by this hook.
See BL-370 for the full incident history.
EOF

exit 2
