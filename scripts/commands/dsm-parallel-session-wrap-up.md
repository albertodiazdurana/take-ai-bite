Wrap up a parallel DSM session. Commit work, merge to parent branch, and append summary to active checkpoint. $ARGUMENTS

## Prerequisites

- Must be on a `parallel/*` branch (check with `git branch --show-current`)
- If not on a parallel branch, stop: "Not on a parallel branch. Use `/dsm-wrap-up` or `/dsm-light-wrap-up` instead."

## Steps (run autonomously, no pauses)

1. **Identify session context:**
   - Current branch name: `git branch --show-current`
   - Extract descriptor from branch name (e.g., `parallel/assess-publicis` -> `assess-publicis`)
   - Read `.claude/parallel-session-baseline.txt` to get: parent branch, worktree path, BL number, BL file path, declared scope
   - If baseline file is missing, fall back to finding the most recent `session-*` branch and scanning `dsm-docs/plans/` for a BL matching the descriptor

2. **Scope verification:** Before merging, verify no files were modified outside the declared scope:
   - Run `git diff --name-only {parent-branch}..HEAD` (parent branch from baseline)
   - Compare against the declared scope in the baseline
   - **BL-lifecycle files are always in scope:** README files in `dsm-docs/plans/`, `plan/backlog/improvements/`, `plan/backlog/developments/`, and `plan/roadmap.md` are expected changes when completing a BL. Do not flag these as scope violations.
   - If files outside scope (excluding BL-lifecycle files) were modified, warn the user and ask for confirmation before proceeding

3. **Complete BL done/ lifecycle:** The parallel session completes the full BL lifecycle, not an intermediate "pending review" status.
   a. Update the BL file:
      - Set **Status:** to "Implemented"
      - Set **Date Implemented:** to today's date
      - List all generated artifacts under **Generated Artifacts**
      - Add a **Summary** section with 3-5 bullet points of what was produced
   b. Move BL file to done/:
      - Determine the correct done/ directory based on the BL's current location:
        - `dsm-docs/plans/` → `dsm-docs/plans/done/`
        - `plan/backlog/improvements/` → `plan/backlog/done/`
        - `plan/backlog/developments/` → `plan/backlog/done/`
      - `git mv {bl-file} {done-directory}/{bl-filename}`
   c. Update folder READMEs: remove the BL entry from the README in its source directory and from `dsm-docs/plans/README.md` (if listed there)
   d. Update roadmap: strike through the BL entry in `plan/roadmap.md` with `~~text~~` and add `Done (S{N})` in the Notes column
   e. Update GitHub Project: if `gh` is available, find the BL's project item and set status to "Done". If `gh` is unavailable or the item is not found, skip silently.

4. **Commit on branch:**
   ```bash
   git add {all files in declared scope}
   git add {BL done/ file, READMEs, roadmap}
   git commit -m "Parallel session: {descriptor} - mark BL-{NNN} complete"
   ```
   If there are also new files in isolated subfolders (not on main), include those in the commit.

5. **Merge to parent session branch via the main repo:**
   Read `Parent branch:` and `Worktree:` from `.claude/parallel-session-baseline.txt`.
   Determine the main repo path:
   ```bash
   WORKTREE_DIR=$(grep "^Worktree:" .claude/parallel-session-baseline.txt | sed 's/^Worktree: *//')
   MAIN_REPO=$(git -C "$WORKTREE_DIR" worktree list | head -1 | awk '{print $1}')
   ```
   If no `Worktree:` field exists (legacy parallel session), `MAIN_REPO` is the
   current directory. Merge from the main repo:
   ```bash
   cd "$MAIN_REPO"
   git checkout {parent-branch}
   git merge parallel/{descriptor} --no-edit
   ```
   - If merge succeeds: continue to step 6
   - If merge fails due to branch protection: use PR fallback:
     ```bash
     git merge --abort
     git push -u origin parallel/{descriptor}
     gh pr create --title "Parallel session: {descriptor}" --body "Merge parallel session artifacts." --base {parent-branch} --head parallel/{descriptor}
     gh pr merge --merge --delete-branch
     git checkout {parent-branch} && git pull
     ```
     If `gh` unavailable or PR fails: warn "Merge requires manual action. Branch `parallel/{descriptor}` pushed to remote." and stop.
   - If merge fails (conflict): abort the merge (`git merge --abort`) and report: "Merge conflict detected. Resolve in the main session with: `cd {MAIN_REPO} && git merge parallel/{descriptor}`". Then stop.

6. **Push parent session branch:**
   ```bash
   git push -u origin {parent-branch}
   ```

7. **Append to checkpoint (if exists):**
   Check for an active checkpoint in the main repo:
   `ls {MAIN_REPO}/dsm-docs/checkpoints/*.md 2>/dev/null | grep -v done | head -1`
   If found, append to it:
   ```markdown

   ## Parallel Session: {descriptor}
   **Merged:** {date}
   **BL:** BACKLOG-{NNN} → done/
   **Summary:**
   - {bullet 1}
   - {bullet 2}
   - {bullet 3}
   ```
   If no active checkpoint exists, create a minimal one:
   ```
   {MAIN_REPO}/dsm-docs/checkpoints/checkpoint-session-N-parallel-{descriptor}.md
   ```
   with the same content, so the next main session picks it up.

8. **Cleanup worktree and branch:**
   ```bash
   cd "$MAIN_REPO"
   git worktree remove "$WORKTREE_DIR" 2>/dev/null
   git branch -d parallel/{descriptor}
   ```
   VS Code automatically detects that the folder was removed and drops it
   from the multi-root workspace. No manual workspace cleanup is needed.

   If `git worktree remove` fails (modified files), warn: "Worktree at
   {WORKTREE_DIR} has uncommitted changes. Remove manually after review."
   If no `Worktree:` field exists (legacy session), just delete the branch
   and remove `.claude/parallel-session-baseline.txt`.

9. **Report:**
   ```
   PARALLEL SESSION COMPLETE
   Branch: parallel/{descriptor} (merged and deleted)
   Worktree: {WORKTREE_DIR} (removed)
   BL: BACKLOG-{NNN} → done/
   Parent branch: {parent-branch}
   Summary: {2-3 line summary}
   ```

## Notes

- No co-author lines in commits
- No MEMORY.md updates (main session handles this)
- No session transcript entries
- No reasoning lessons extraction
- No feedback push
- If $ARGUMENTS is provided, use it as the session description in the commit message
- Follow .claude/CLAUDE.md conventions for this project
