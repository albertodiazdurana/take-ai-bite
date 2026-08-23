Mark a research file as done and move it to `dsm-docs/research/done/`.

## Usage

The user provides a filename or a partial topic match (e.g.,
`/dsm-research-done core-slimming` matches
`2026-04-14_core-slimming-impact.md`).

## Steps

1. Resolve the target file:
   - Search `dsm-docs/research/` for a file whose name matches the user's input (substring or exact).
   - If multiple matches: list them and ask the user to pick.
   - If no match: report the error and list `dsm-docs/research/` contents.
   - If the file is already in `dsm-docs/research/done/`: report and stop.
2. Read the file's first ~15 lines and update the header:
   - If `**Status:**` exists, change its value to `Done`.
   - If `**Status:**` does not exist, insert `**Status:** Done` after the existing date or author line.
   - If `**Date Completed:**` does not exist, insert `**Date Completed:** YYYY-MM-DD` (today's date) immediately after the Status line.
   - If `**Date Completed:**` exists with a placeholder ("(pending main-session review)" etc.), replace it with today's date.

   Use the Edit tool, anchoring on a unique existing line, to avoid disturbing surrounding content.
3. **CRITICAL — BL-370 pitfall:** the file move below uses `git mv`, which does NOT carry forward content edits made by the Edit tool in step 2. After the move (step 4), step 5 must explicitly `git add` the destination path to re-stage the content delta. The `validate-rename-staging.sh` PreToolUse hook will block the commit otherwise; this skill avoids the block by staging the content explicitly.
4. Move the file:
   - If the file is git-tracked (`git ls-files --error-unmatch` succeeds): `git mv dsm-docs/research/{filename} dsm-docs/research/done/{filename}`
   - Otherwise (untracked): `mv dsm-docs/research/{filename} dsm-docs/research/done/{filename}` followed by `git add dsm-docs/research/done/{filename}`
5. Re-stage the destination with content edits:
   - `git add dsm-docs/research/done/{filename}`
   - Verify: `git diff --cached --numstat dsm-docs/research/done/{filename}` should show non-zero insertions.
6. Update `dsm-docs/research/README.md`:
   - Find the row whose link points to the moved filename.
   - Remove that row from its sub-table.
   - If removing the row leaves a sub-table empty, leave the heading + empty table (or remove the empty heading at the user's discretion; default is to leave it).
7. Stage the README change: `git add dsm-docs/research/README.md`.
8. Show the user:
   - The path that was moved.
   - The README diff.
   - Suggested commit message: `Move {filename} to research/done/ (linked BL: BL-{N} or "no BL")`.
9. Do NOT auto-commit; the user decides when.

## Important

- Use `git mv` for tracked files, `mv` + `git add` for untracked.
- Step 5 (`git add` after `git mv`) is non-optional. Skipping it triggers the BL-370 hook block at commit time.
- This skill modifies only `dsm-docs/research/{filename}` (moved + content) and `dsm-docs/research/README.md`. No mirror sync, no FEATURES.md update.
- Pairs with `/dsm-research-add`, which creates a new research file and registers it.
- Origin: BL-425 (closes the research/README maintenance gap surfaced in S205).
