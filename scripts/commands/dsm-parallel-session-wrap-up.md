Wrap up a parallel DSM session. Commit work, merge to main, and append summary to active checkpoint. $ARGUMENTS

## Prerequisites

- Must be on a `parallel/*` branch (check with `git branch --show-current`)
- If not on a parallel branch, stop: "Not on a parallel branch. Use `/dsm-wrap-up` or `/dsm-light-wrap-up` instead."

## Steps (run autonomously, no pauses)

1. **Identify session context:**
   - Current branch name: `git branch --show-current`
   - Extract descriptor from branch name (e.g., `parallel/assess-publicis` -> `assess-publicis`)
   - Find the BL folder: `dsm-docs/plans/BL-*-{descriptor}/`

2. **Update BL README:** Update the `dsm-docs/plans/BL-{NNN}-{descriptor}/README.md`:
   - Set **Status:** to "Complete (pending main session review)"
   - List all generated artifacts under **Generated Artifacts**
   - Add a **Summary** section with 3-5 bullet points of what was produced

3. **Commit on branch:**
   ```bash
   git add dsm-docs/plans/BL-{NNN}-{descriptor}/
   git commit -m "Parallel session: {descriptor} - {brief description}"
   ```
   If there are also new files in isolated subfolders (not on main), include those in the commit.

4. **Merge to main:**
   ```bash
   git checkout main
   git merge parallel/{descriptor} --no-edit
   ```
   - If merge succeeds: continue to step 5
   - If merge fails (conflict): abort the merge (`git merge --abort`), switch back to the parallel branch, and report: "Merge conflict detected. The branch `parallel/{descriptor}` is preserved. Resolve in the main session with: `git merge parallel/{descriptor}`". Then stop.

5. **Push:**
   ```bash
   git push
   ```

6. **Append to checkpoint (if exists):**
   Check for an active checkpoint: `ls dsm-docs/checkpoints/*.md 2>/dev/null | grep -v done | head -1`
   If found, append to it:
   ```markdown

   ## Parallel Session: {descriptor}
   **Merged:** {date}
   **BL folder:** dsm-docs/plans/BL-{NNN}-{descriptor}/
   **Summary:**
   - {bullet 1}
   - {bullet 2}
   - {bullet 3}
   **Action required:** Review BL folder contents and distribute to proper locations.
   ```
   If no active checkpoint exists, create a minimal one:
   ```
   dsm-docs/checkpoints/checkpoint-session-N-parallel-{descriptor}.md
   ```
   with the same content, so the next main session picks it up.

7. **Delete branch:**
   ```bash
   git branch -d parallel/{descriptor}
   ```

8. **Report:**
   ```
   PARALLEL SESSION COMPLETE
   Branch: parallel/{descriptor} (merged and deleted)
   BL folder: dsm-docs/plans/BL-{NNN}-{descriptor}/
   Summary: {2-3 line summary}
   Next: Main session should review BL folder and distribute artifacts.
   ```

## Notes

- No co-author lines in commits
- No MEMORY.md updates (main session handles this)
- No session transcript entries
- No reasoning lessons extraction
- No feedback push
- If $ARGUMENTS is provided, use it as the session description in the commit message
- Follow .claude/CLAUDE.md conventions for this project
