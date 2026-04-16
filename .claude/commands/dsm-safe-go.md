Minimal troubleshooting boot for DSM projects. Zero dependencies on other skills. Read-only, no side effects. Use when /dsm-go, /dsm-light-go, or /dsm-align is broken and you need to get back into context to fix a problem. $ARGUMENTS

## Critical constraints

- **ZERO skill invocations.** Do NOT invoke /dsm-go, /dsm-light-go, /dsm-align, /dsm-wrap-up, or any other DSM skill. This skill exists precisely for when those skills are broken.
- **Read-only.** Do NOT create files, create branches, modify files, or run any command with side effects. The only exception is the best-effort transcript append in Step 5.
- **No session tracking.** Do not assign a session number, archive transcripts, create baselines, or set up session branches.
- **No gates.** Do not check scaffold completeness, version alignment, inbox, or run any validation. Those are /dsm-go responsibilities.

## Steps

1. **Git orientation (read-only):**
   - Run `git branch --show-current` to identify the current branch
   - Run `git status --porcelain` to see uncommitted changes
   - Run `git log --oneline -3` to see recent commits
   - Report all three results. Do not create branches or switch branches.

2. **Project identity:**
   - Read `.claude/CLAUDE.md` (first 5 lines only) to find the `@` reference
   - Extract the path to `DSM_0.2_Custom_Instructions_v1.1.md` from the `@` line
   - If the `@` line exists: report "Project is part of the DSM ecosystem. DSM_0.2 located at: {path}"
   - If the `@` line is missing or broken: report "WARNING: No valid @ reference found. DSM_0.2 protocols may not be loaded."
   - Do NOT fix the `@` reference. Report only.

3. **Context recovery:**
   - Read MEMORY.md from the auto memory directory. If it exists, extract:
     - Latest Session line (session number, date, description)
     - Pending work items
     - Current focus areas
   - If MEMORY.md does not exist or fails to load: report "No MEMORY.md found. Operating without prior session context."

4. **Ecosystem awareness:**
   - Read `.claude/dsm-ecosystem.md` if it exists. Extract the Paths table.
   - For each entry, check if the path exists on the filesystem (using `test -d`)
   - Report which ecosystem paths are valid and which are missing
   - If the file does not exist: report "No ecosystem registry found."

5. **Transcript best-effort:**
   - If `.claude/session-transcript.md` exists:
     - Attempt to append a single thinking block summarizing the safe-go results
     - If the append fails for any reason (permission, hook error, file locked), skip silently and continue
   - If the file does not exist: skip silently
   - Do NOT create the file if it is missing

6. **Report:** Summarize in this format:
   ```
   /dsm-safe-go report:
   - Project: [directory name]
   - DSM ecosystem: [yes (@ path) | WARNING: no valid @ reference]
   - Branch: [current branch]
   - Uncommitted changes: [yes/no, count]
   - Recent commits: [3 one-liners]
   - Last session: [number, date, description from MEMORY, or "unknown"]
   - Ecosystem paths: [N valid / M total, or "no registry"]
   - Transcript: [appended | skipped (reason) | file missing]
   ```

7. **Ask:** "What needs fixing?"
   If $ARGUMENTS is provided, skip the question and address the topic directly.

## Notes

- This skill is the "safe mode" boot for DSM projects
- It provides enough context to diagnose and fix problems without depending on the infrastructure that might be broken
- After fixing the problem, the user should run `/dsm-go` for a full session start
- The boot hierarchy is: `/dsm-safe-go` (minimal, troubleshooting) < `/dsm-light-go` (lightweight, continuation) < `/dsm-go` (full, standard)
