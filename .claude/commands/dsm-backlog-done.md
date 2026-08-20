Mark a DSM backlog item as implemented and move it to done/.

## Usage

The user provides a backlog number (e.g., "042" or "BACKLOG-042").

## Steps

1. Find the backlog file by searching `dsm-docs/plans/`, `plan/backlog/developments/`, and `plan/backlog/improvements/` for the matching BACKLOG-XXX number
2. If not found, report the error and list available backlog items
3. Read the file and update:
   - Change `**Status:** Proposed` or `**Status:** Active` to `**Status:** Implemented`
   - Add `**Date Implemented:** YYYY-MM-DD` (today's date) after the Status line
4. Move the file to the `done/` subdirectory of its current location using `mv` (not `git mv`, since it may be untracked). For files in `dsm-docs/plans/`, move to `dsm-docs/plans/done/`. For files in `plan/backlog/`, move to `plan/backlog/done/`.
5. Update the consolidated README at `dsm-docs/plans/README.md`:
   - Remove the item's row from its section table
6. If the file came from `plan/backlog/improvements/` or `plan/backlog/developments/`, also update the README in that source directory:
   - Remove the item's row from the table
7. **Feature inventory check:** Ask the user: "Does this BL add a user-facing feature? If yes, I'll add an entry to FEATURES.md." If yes:
   - Add a chronological entry to `FEATURES.md` at the top of the current month section
   - Format: `- **F-NNN (YYYY-MM-DD) Feature name** — One-line plain language description`
   - Increment the feature count in the header
8. **BL Lookup Index update:** Add a row to `dsm-docs/plans/done/INDEX.md` for this BL, preserving ascending BL-number order. Columns:
   - `BL#`: `BACKLOG-NNN`
   - `Title`: from the BL file's first heading (minus the `BACKLOG-NNN:` prefix)
   - `Version`: the implementing version if known from the current CHANGELOG section being authored; else `—`
   - `Date`: today's date (YYYY-MM-DD)
   - `Resolver (§ or concept)`: the DSM section (e.g., `DSM_0.2 §8.2.1`) or concept name the BL landed as. For research / audit / one-shot-fix BLs without a named-section landing, use `— (implementation-only)`.
   INDEX is mirrored to TAB per `dsm-docs/guides/mirror-sync-manifest.md` category 4; keeping it current means downstream readers can resolve BL numbers they see in CHANGELOG/FEATURES.
9. Show the user what was done and remind them to commit when ready

## Important

- Use `mv` not `git mv` for untracked files
- Use `git mv` only if the file is already tracked by git (check with `git ls-files`)
- Do NOT commit automatically; let the user decide when
