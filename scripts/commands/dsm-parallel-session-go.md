Start a parallel DSM session for short, isolated evaluation tasks. Creates a git worktree with a unique branch for true isolation from the main session. $ARGUMENTS

## Purpose

Parallel sessions handle short evaluation work (research collection, document assessment, BL item generation, isolated artifact creation) in isolation from the main session. All generated artifacts go into a dedicated BL folder, never into shared or central files. No session transcript is collected.

**Worktree isolation:** Parallel sessions use git worktrees so the main session's branch is never changed. The parallel session works in a separate directory with its own branch. This prevents VS Code branch switching conflicts.

## Git Requirement

Run `git rev-parse --is-inside-work-tree 2>/dev/null`. If false, stop: "Parallel sessions require a git repository."

## Steps

1. **Load context:** Read this project's MEMORY.md from the auto memory directory. Read `.claude/CLAUDE.md` for project conventions. Do NOT read reasoning lessons, inbox, or DSM_0.2. Do NOT archive or create session transcripts.

2. **Announce parallel mode:** Report:
   ```
   PARALLEL SESSION
   This is an isolated session for short evaluation work.
   All output goes to a dedicated BL staging folder in a git worktree.
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

5. **Determine BL number:** Scan all backlog directories (`plan/backlog/improvements/`, `plan/backlog/developments/`, `plan/backlog/done/`, and any subdirectories) for the highest existing BL number. Also check `dsm-docs/plans/` for legacy BL files. The new BL number is highest + 1.

6. **Create worktree and branch:**
   Parallel sessions use git worktrees for true isolation. This prevents
   VS Code branch switching conflicts with the main session.
   ```bash
   WORKTREE_DIR="$HOME/.dsm-worktrees/{descriptor}"
   PARENT_BRANCH=$(git branch --show-current)
   git worktree add "$WORKTREE_DIR" -b parallel/{descriptor}
   ```
   If the worktree directory already exists, warn and stop: "Worktree
   already exists at $WORKTREE_DIR. Remove it first or choose a different
   descriptor."

   Then create the BL file **in the worktree directory**:
   ```bash
   mkdir -p "$WORKTREE_DIR/dsm-docs/plans/"
   ```
   Create `$WORKTREE_DIR/dsm-docs/plans/BACKLOG-{NNN}_{descriptor}.md` with:
   ```markdown
   # BACKLOG-{NNN}: {Task title}

   **Status:** In Progress
   **Priority:** Medium
   **Date Created:** {date}
   **Origin:** Parallel session on branch `parallel/{descriptor}`
   **Author:** Alberto Diaz Durana

   ## Task
   {Brief description of what the parallel session is doing}

   ## Generated Artifacts
   {Will be listed as files are created}
   ```

7. **Write parallel session baseline in the worktree:**
   ```bash
   mkdir -p "$WORKTREE_DIR/.claude"
   cat > "$WORKTREE_DIR/.claude/parallel-session-baseline.txt" << EOF
   # Parallel session baseline
   Task: {description}
   Scope: {list of folders/files to be modified}
   Parent branch: $PARENT_BRANCH
   Worktree: $WORKTREE_DIR
   BL number: {NNN}
   BL file: dsm-docs/plans/BACKLOG-{NNN}_{descriptor}.md
   Created: {timestamp}
   EOF
   ```

8. **Add worktree to VS Code workspace:**
   ```bash
   code --add "$WORKTREE_DIR"
   ```
   This adds the worktree as a folder in the current VS Code multi-root
   workspace. The user sees it appear in the sidebar immediately.

9. **Report and instruct user:**
   ```
   PARALLEL SESSION READY

   Worktree: {WORKTREE_DIR}
   Branch: parallel/{descriptor}
   BL file: dsm-docs/plans/BACKLOG-{NNN}_{descriptor}.md
   Parent branch: {parent branch name}
   Safety check: OK (no conflicts detected)

   Worktree added to VS Code workspace.
   Open Claude Code in the "{descriptor}" folder from the sidebar to start.

   The main session stays on {parent branch name}. No branch conflicts.
   ```
   **STOP here.** The user opens Claude Code scoped to the worktree folder
   in the VS Code sidebar. The parallel session agent starts fresh in that
   directory. Do NOT begin work in the current terminal.

## Behavioral Rules (active for the parallel session in the worktree)

- **Generated artifacts go into canonical folders** (`dsm-docs/research/`, `dsm-docs/plans/`, etc.) as appropriate for their type. The BL file in `dsm-docs/plans/` tracks all produced artifacts.
- **Never modify shared or central files.** These are determined per-project from CLAUDE.md (source-of-truth files, trackers, READMEs, config files, profile documents, any file serving as a project-wide reference).
- **Never modify files outside the declared scope** unless they are new files in an isolated subfolder that does not yet exist on main.
- **No session transcript entries.** Do not append to `.claude/session-transcript.md`.
- **No MEMORY.md updates.** Memory is read-only in parallel sessions.
- **No inbox processing.** Inbox is main-session-only.
- If at any point the work scope expands to require shared file edits, STOP and warn: "This work requires shared file changes. Complete it in the main session instead."
- Follow `.claude/CLAUDE.md` conventions for this project (punctuation, text conventions, format rules).

## Notes

- No co-author lines in commits
- Parallel sessions are intentionally minimal: no transcript, no memory writes, no inbox
- The BL file tracks all generated artifacts; the main session reviews after merge
- If the user provides $ARGUMENTS, skip the "What do you want to work on?" question and proceed directly
