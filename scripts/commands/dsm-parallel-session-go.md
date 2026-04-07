Start a parallel DSM session for short, isolated tasks on the shared session branch. $ARGUMENTS

## Purpose

Parallel sessions handle short evaluation work (QA validation, document assessment,
scoped BL implementation) on the shared Level 2 session branch. No worktrees, no
Level 3 branches. Isolation is enforced through typed session prefixes, file scope
declarations, and a commit booking system. No session transcript is collected.

## Session Type Detection (Mandatory Prompt Prefix)

The first prompt MUST contain a typed prefix. Detect it from $ARGUMENTS:

| Pattern | Type | Scope |
|---------|------|-------|
| Starts with `QA` | QA session | Read-only; writes to `.claude/` only |
| Starts with `BL-{NNN}` | BL session | File-scoped edits per BL definition |

**If no valid prefix is detected,** refuse to proceed and guide the user:

```
This session requires a typed prefix to proceed. Valid formats:

For read-only analysis (QA):
  QA dsm parallel session: [describe the validation task]

For scoped BL implementation:
  BL-271 dsm parallel session: [describe the implementation task]

Please start a new session with one of these prefixes.
```

**Wait for a correctly prefixed prompt before proceeding.** If the user started
without a prefix, the simplest recovery is to close this session and open a new
one with the correct prefix. The session tab name is auto-generated from the
first prompt and cannot be changed after the fact.

## Git Requirement

Run `git rev-parse --is-inside-work-tree 2>/dev/null`. If false, stop:
"Parallel sessions require a git repository."

## Steps

1. **Validate prefix:** Parse $ARGUMENTS for QA or BL-{NNN} prefix. If missing
   or malformed, output the guided failure message above and stop.

2. **Load context:** Read this project's MEMORY.md from the auto memory directory.
   Read `.claude/CLAUDE.md` for project conventions. Do NOT read reasoning lessons,
   inbox, or DSM_0.2. Do NOT archive or create session transcripts. Do NOT read,
   write, edit, or append to `.claude/session-transcript.md` at any point in this
   session. Parallel sessions do not collect transcripts; the commit log is the
   audit trail.

   **Hook behavior (BL-324 structural fix):** The `UserPromptSubmit` hook is
   backed by `.claude/hooks/transcript-reminder.sh`, which detects parallel
   sessions via the `CLAUDE_PID` field written to
   `.claude/parallel-session-baseline.txt` at Step 6 below. Once that baseline
   is written, the hook emits a parallel-mode reminder instead of the main
   §7 reminder. Until Step 6 writes the baseline (i.e., during Step 2 itself),
   the main reminder may still fire once; ignore it. After Step 6 the hook
   auto-switches.

3. **Determine session type and scope:**
   - **QA type:** Scope is read-only. Only `.claude/` writes are allowed (findings,
     notes, analysis output).
   - **BL type:** Read the referenced BL file to determine which files are in scope.
     If the BL file does not exist, stop: "BL-{NNN} not found. Check the BL number."

4. **Identify shared files:** Read `.claude/CLAUDE.md` to determine which files are
   central to the project (README, config files, trackers, profile documents, any
   file referenced as a source of truth). These are off-limits for parallel sessions.

5. **Safety check:** Before proceeding:
   - Run `git status --porcelain` to check for uncommitted changes
   - Check `.claude/parallel-session-baseline.txt` for active parallel sessions
   - For BL type: verify that the planned file scope does not overlap with any
     active parallel session's declared scope
   - **STOP if:**
     - Uncommitted changes overlap with the planned scope
     - Another parallel session targets the same files
     - The planned work requires shared file modifications
   - If stopped, explain the conflict and ask the user to reframe.

6. **Write parallel session baseline:**
   The main session assigns the session number (X.Y format). If $ARGUMENTS
   includes a session number, use it. Otherwise, default to the session branch
   number + ".1" (incrementing if baseline already exists).

   Capture the Claude Code instance PID by walking the parent process chain
   from the shell until a process named `claude` is found:
   ```bash
   CLAUDE_PID=""
   pid=$$
   for _ in $(seq 1 10); do
     read ppid comm < <(ps -o ppid=,comm= -p "$pid" 2>/dev/null)
     [ -z "$ppid" ] && break
     if [ "$comm" = "claude" ]; then CLAUDE_PID=$pid; break; fi
     pid=$ppid
     [ "$pid" = "1" ] && break
   done
   ```
   This PID is the detection key used by `.claude/hooks/transcript-reminder.sh`
   to emit the parallel-mode reminder instead of the main §7 reminder
   (BL-324). If `CLAUDE_PID` cannot be determined (empty), warn the user:
   "Could not detect Claude Code PID; hook will emit main-session reminder.
   Ignore transcript reminders manually for this session." Continue without
   blocking.

   ```
   # Parallel session X.Y baseline
   Type: QA | BL-{NNN}
   Task: {description from prompt}
   Scope: {list of files, or "read-only" for QA}
   Session branch: {current session branch name}
   Created: {timestamp}
   CLAUDE_PID: {pid from parent chain walk}
   ```

7. **Declare scope (first output):** Report:
   ```
   PARALLEL SESSION X.Y ({QA|BL-NNN})

   Session branch: {branch name} (shared, no separate branch)
   Type: {QA (read-only) | BL-NNN (file-scoped)}
   Scope: {file list or "read-only"}

   This session will only edit: {file list}.
   Any edit outside this scope will be refused.

   Commit booking: enabled (.claude/commit-lock)
   ```

8. **Begin work.** If $ARGUMENTS includes a task description beyond the prefix,
   start working on it directly. Otherwise, ask: "What specific task within this
   scope?"

## Commit Booking Protocol

Before every commit:
1. Check `.claude/commit-lock`
2. If absent or stale (>5 min): create with `{session-id}\n{ISO-timestamp}`
3. If present and fresh: wait 10s, retry (max 3), then warn user
4. Run `git branch --show-current` to verify correct branch
5. Run `git pull --rebase` to pick up other sessions' commits
6. `git add` only files in declared scope + `git commit`
7. Delete `.claude/commit-lock`

## Behavioral Rules (active for the entire parallel session)

- **QA sessions:** Read any file, write only to `.claude/` (findings, notes).
  Never edit tracked repository files.
- **BL sessions:** Edit only files in the declared scope. Generated artifacts
  go into canonical folders (`dsm-docs/research/`, `dsm-docs/plans/`, etc.).
- **Never modify shared or central files.** Determined from CLAUDE.md.
- **No session transcript entries.** Do not append to `.claude/session-transcript.md`.
- **No MEMORY.md updates.** Memory is read-only in parallel sessions.
- **No inbox processing.** Inbox is main-session-only.
- **BL lifecycle:** Do NOT move the BL to `done/`. Update the BL status to
  `Implemented by parallel session #X.Y`. The main session validates and closes.
- If work scope expands to require out-of-scope edits, STOP and warn:
  "This work requires files outside the declared scope. Complete it in the
  main session instead."
- Follow `.claude/CLAUDE.md` conventions (punctuation, text conventions, format).
- Use the commit booking protocol for every commit.
- **Never invoke main session lifecycle skills.** The following skills are
  prohibited in parallel sessions: `/dsm-wrap-up`, `/dsm-light-wrap-up`,
  `/dsm-quick-wrap-up`. These skills merge the session branch to main, push
  to remote, and update session state, all of which are main-session-only
  operations. If the user asks about wrapping up, clarify: "This is a parallel
  session. Use `/dsm-parallel-session-wrap-up` to end this session, or switch
  to the main session tab for full wrap-up."

## Notes

- No co-author lines in commits
- Parallel sessions are intentionally minimal: no transcript, no memory writes, no inbox
- The main session reviews all parallel session work before closing BLs
- If the user provides $ARGUMENTS with a valid prefix, skip questions and proceed directly
