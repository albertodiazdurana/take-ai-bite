Mark a DSM backlog item as implemented and move it to done/.

## Usage

The user provides a backlog number (e.g., "042" or "BACKLOG-042").

## Steps

1. Find the backlog file by searching `plan/backlog/developments/` and `plan/backlog/improvements/` for the matching BACKLOG-XXX number
2. If not found, report the error and list available backlog items
3. Read the file and update:
   - Change `**Status:** Proposed` to `**Status:** Implemented`
   - Add `**Date Implemented:** YYYY-MM-DD` (today's date) after the Status line
4. Move the file to `plan/backlog/done/` using `mv` (not `git mv`, since it may be untracked)
5. Update the README in the source directory (`plan/backlog/{developments|improvements}/README.md`):
   - Remove the item's row from the **Active Items** table
   - Add a new row to the **Recently Completed** table (at the top, most recent first) with BL#, title, and today's date
   - If the Recently Completed table does not exist, create it after the Active Items section
6. Show the user what was done and remind them to commit when ready

## Important

- Use `mv` not `git mv` for untracked files
- Use `git mv` only if the file is already tracked by git (check with `git ls-files`)
- Do NOT commit automatically; let the user decide when
