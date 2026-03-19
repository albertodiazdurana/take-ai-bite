Start a parallel DSM session for short, isolated evaluation tasks. Creates a unique branch and BL staging folder. $ARGUMENTS

## Purpose

Parallel sessions handle short evaluation work (research collection, document assessment, BL item generation, isolated artifact creation) in isolation from the main session. All generated artifacts go into a dedicated BL folder, never into shared or central files. No session transcript is collected.

## Git Requirement

Run `git rev-parse --is-inside-work-tree 2>/dev/null`. If false, stop: "Parallel sessions require a git repository."

## Steps

1. **Load context:** Read this project's MEMORY.md from the auto memory directory. Read `.claude/CLAUDE.md` for project conventions. Do NOT read reasoning lessons, inbox, or DSM_0.2. Do NOT archive or create session transcripts.

2. **Announce parallel mode:** Report:
   ```
   PARALLEL SESSION
   This is an isolated session for short evaluation work.
   All output goes to a dedicated BL staging folder on a unique branch.
   Central and shared files are off-limits.
   No session transcript is collected.

   What do you want to work on?
   ```
   If $ARGUMENTS is provided, use it as the task description and skip asking.

3. **Determine branch name:** From the user's answer (or $ARGUMENTS), derive a short kebab-case descriptor (e.g., "assess-publicis-sapient", "research-spark-gap", "review-api-docs"). The branch will be named `parallel/{descriptor}`.

4. **Safety check:** Before creating the branch:
   - Run `git status --porcelain` on the current branch to see uncommitted changes
   - Run `git branch --list 'parallel/*'` to check for active parallel branches
   - Identify which folders/files the planned work would touch
   - **Identify shared files:** Read `.claude/CLAUDE.md` to determine which files are central to the project (e.g., README, config files, trackers, profile documents, any file referenced as a source of truth or shared artifact). These are off-limits for parallel sessions.
   - **STOP if any of these are true:**
     - The planned work would modify files identified as shared/central
     - Another parallel branch exists that targets the same folder or topic
     - Uncommitted changes on the current branch overlap with the planned work scope
   - If stopped, explain the conflict and ask the user to reframe the work scope to avoid overlap. Do NOT proceed until the conflict is resolved.

5. **Determine BL number:** Read `dsm-docs/plans/README.md` (or equivalent backlog tracker) to find the highest existing BL number. The new BL number is highest + 1.

6. **Create branch and BL folder:**
   ```bash
   git checkout -b parallel/{descriptor}
   mkdir -p dsm-docs/plans/BL-{NNN}-{descriptor}/
   ```
   Create a brief `dsm-docs/plans/BL-{NNN}-{descriptor}/README.md` with:
   ```markdown
   # BL-{NNN}: {Task title}

   **Created:** {date}
   **Source:** Parallel session on branch `parallel/{descriptor}`
   **Status:** In progress (parallel session)

   ## Task
   {Brief description of what the parallel session is doing}

   ## Generated Artifacts
   {Will be listed as files are created}
   ```

7. **Report and begin:**
   ```
   Branch: parallel/{descriptor}
   BL folder: dsm-docs/plans/BL-{NNN}-{descriptor}/
   Safety check: OK (no conflicts detected)

   Starting work.
   ```
   Then begin the task. All generated files go into the BL folder.

## Behavioral Rules (active for entire session)

- **All generated artifacts go into `dsm-docs/plans/BL-{NNN}-{descriptor}/`**. No exceptions.
- **Never modify shared or central files.** These are determined per-project from CLAUDE.md (source-of-truth files, trackers, READMEs, config files, profile documents, any file serving as a project-wide reference).
- **Never modify files outside the BL folder** unless they are new files in an isolated subfolder that does not yet exist on main.
- **No session transcript entries.** Do not append to `.claude/session-transcript.md`.
- **No MEMORY.md updates.** Memory is read-only in parallel sessions.
- **No inbox processing.** Inbox is main-session-only.
- If at any point the work scope expands to require shared file edits, STOP and warn: "This work requires shared file changes. Complete it in the main session instead."
- Follow `.claude/CLAUDE.md` conventions for this project (punctuation, text conventions, format rules).

## Notes

- No co-author lines in commits
- Parallel sessions are intentionally minimal: no transcript, no memory writes, no inbox
- The BL folder is the single output location; the main session handles distribution
- If the user provides $ARGUMENTS, skip the "What do you want to work on?" question and proceed directly
