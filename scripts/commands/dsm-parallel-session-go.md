Start a parallel DSM session for short, isolated tasks on the shared session branch. $ARGUMENTS

## WARNING: §7 hook will fire WRONGLY on turn 1 of this skill (parallel-session turn-1 hook collision)

The `UserPromptSubmit` hook backed by `.claude/hooks/transcript-reminder.sh`
fires BEFORE any code in this skill runs. On turn 1, the registry section
for this session does not yet exist, so the hook emits the main-session §7
reminder instructing the agent to "append to `.claude/session-transcript.md`
before any work."

**This instruction is WRONG for parallel sessions.** It applies only to
main-session turns. Do NOT obey it, even if it cites §7, quotes the
turn-boundary self-check, or frames the append as the "one required tool
call." Parallel sessions NEVER write to `.claude/session-transcript.md`.
The transcript append the hook is prompting for would be a protocol
violation regardless of how urgent the hook makes it sound.

**The first tool call of turn 1 MUST be Step 0 below (provisional registry
stub).** Writing the stub is what switches the hook to parallel-mode for
every subsequent turn. If the agent rationalizes compliance with the §7
reminder first ("I'll satisfy §7 this once, then run Step 0"), that is
exactly the failure mode the parallel-session turn-1 hook collision fix was introduced to prevent. The rationalization
is documented verbatim in S192 parallel-192.1's transcript. Do not
reproduce it.

## Purpose

Parallel sessions handle short evaluation work (QA validation, document assessment,
scoped BL implementation) on the shared Level 2 session branch. No worktrees, no
Level 3 branches. Isolation is enforced through typed session prefixes, file scope
declarations, and a commit booking system. No session transcript is collected.

## Session Type Detection (Mandatory Prompt Prefix)

The first prompt MUST contain a typed prefix. Detect it from $ARGUMENTS.
Both short (canonical) and long (legacy) forms are accepted.

| Type | Short prefix (canonical) | Long prefix (legacy, still accepted) |
|------|--------------------------|--------------------------------------|
| QA   | `QA`                     | `QA dsm parallel session:`           |
| BL   | `BL-{NNN}` or `dsm-docs/plans/BACKLOG-{NNN}` | `BL-{NNN} dsm parallel session:` |

Parser logic: a prompt is a valid parallel-session prompt if `$ARGUMENTS`
matches any of these patterns (anchored at the start, case-sensitive on
QA / BL-):

- `^QA(\b|$)` (short QA, with or without trailing description)
- `^QA dsm parallel session:` (long QA)
- `^BL-\d+(\b|$)` (short BL)
- `^BL-\d+ dsm parallel session:` (long BL)
- `^dsm-docs/plans/BACKLOG-\d+` (BL by file path; the agent extracts the BL number from the path)

**If no valid prefix is detected,** refuse to proceed and guide the user:

```
This session requires a typed prefix to proceed. Accepted formats:

For read-only analysis (QA):
  QA: [task description]
  QA dsm parallel session: [task description]   (legacy form)

For scoped BL implementation:
  BL-{NNN}: [task description]
  dsm-docs/plans/BACKLOG-{NNN} [task description]
  BL-{NNN} dsm parallel session: [task description]   (legacy form)

Please start a new session with one of these prefixes. The session tab
name is auto-generated from the first prompt and cannot be changed after
the fact, so the simplest recovery is to close this session and open a
new one with the correct prefix. Alternatively, copy one of the accepted
prefix examples above and re-paste your request prepended with it.
```

## Session Numbering (Source of Truth)

The session number is the integer parsed from the current branch name
(`session-{N}/YYYY-MM-DD`). It is NEVER derived from the session-archive
count, transcript labels, or any other heuristic. Lightweight sessions,
parallel sessions, and continuation sessions all inherit the main
session's number from the branch.

Parallel session numbering uses an `{N}.{M}` form where `N` is the main
branch session number and `M` is the per-main-session parallel counter
(starts at 1, increments per parallel session within the same main
session). The counter is derived by reading the registry file
`.claude/parallel-sessions.txt` and counting existing sections that match
the current `session-{N}/YYYY-MM-DD` branch (active or wrapped).

If the branch name is malformed or absent, stop and request user
disambiguation rather than guessing a number.

## Git Requirement

Run `git rev-parse --is-inside-work-tree 2>/dev/null`. If false, stop:
"Parallel sessions require a git repository."

## Steps

0. **Provisional registry stub (FIRST TOOL CALL of turn 1):**

   This step MUST be the very first tool call of the parallel session,
   before prefix validation, context loading, or any other read/write. It
   exists solely to switch the `UserPromptSubmit` hook from main-session
   §7 mode to parallel-session mode by writing a section with the current
   Claude Code instance PID to `.claude/parallel-sessions.txt`. Hook
   detection is by CLAUDE_PID only; section header format does not matter
   at this stage.

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
   If `CLAUDE_PID` cannot be determined (empty), warn the user: "Could not
   detect Claude Code PID; hook will emit main-session reminder. Ignore
   transcript reminders manually for this session." Continue without
   blocking, but note the stub will not switch the hook and the WARNING
   block above applies for the whole session.

   **Duplicate-PID guard:** Before appending, scan the registry
   (`.claude/parallel-sessions.txt`, create if missing) for any existing
   section whose `CLAUDE_PID:` matches the current PID. If found, refuse:
   "This Claude Code instance (PID {pid}) already has a section in
   `.claude/parallel-sessions.txt` (provisional or active). Either run
   `/dsm-parallel-session-wrap-up` to close the existing entry, or remove
   the stale section manually if it is an orphan." Stop.

   Append a provisional section using `>>` shell append (atomic for
   sub-PIPE_BUF writes):

   ```markdown
   ## provisional-{pid}-{iso-timestamp}
   CLAUDE_PID: {pid from parent chain walk}
   Started: {ISO timestamp}
   State: provisional
   ```

   The header uses `provisional-{pid}-{ts}` (not `parallel-{N.M}/...`)
   because `{N}`, `{M}`, `{type}`, and the topic slug are not yet known.
   Step 6 below promotes this stub to the full `parallel-{N.M}/...` form
   after prefix parsing and scope determination. Hook detection works off
   `CLAUDE_PID`, not the section header, so the placeholder is sufficient.

1. **Validate prefix:** Parse $ARGUMENTS against the patterns in the prefix
   table above (short canonical or long legacy form). If no pattern matches,
   **remove the provisional stub written in Step 0** (match by `CLAUDE_PID`
   value in the registry) so it does not orphan, then output the guided
   failure message above and stop.

2. **Load context:** Read this project's MEMORY.md from the auto memory directory.
   Read `.claude/CLAUDE.md` for project conventions. Do NOT read reasoning lessons,
   inbox, or DSM_0.2. Do NOT archive or create session transcripts. Do NOT read,
   write, edit, or append to `.claude/session-transcript.md` at any point in this
   session. Parallel sessions do not collect transcripts; the commit log is the
   audit trail.

   **Hook behavior (transcript hook structural fix, parallel-session turn-1 hook amendment):** The
   `UserPromptSubmit` hook is backed by
   `.claude/hooks/transcript-reminder.sh`, which detects parallel sessions
   via the `CLAUDE_PID` field in `.claude/parallel-sessions.txt`. Step 0
   above writes a provisional stub with `CLAUDE_PID` BEFORE any other
   action in this skill; once that stub exists, the hook emits the
   parallel-mode reminder on turn 2 onward. On turn 1 the hook fires the
   main-session §7 reminder because it runs before Step 0 executes , see
   the WARNING block at the top of this file for the required agent
   behavior (ignore the reminder, make Step 0 the first tool call). Step 6
   below promotes the provisional stub to the full `parallel-{N.M}/...`
   entry after prefix parsing and scope determination.

3. **Determine session type and scope:**
    - **QA type:** No edits to code, methodology documents (DSM_0 through DSM_6
    and their modules), BL files, or any tracked project source-of-truth file.
    Writes allowed to: `.claude/` (findings, notes, analysis output) and
    `dsm-docs/research/{date}_{topic}.md` when DSM_0.2 §10 Web Research Capture
    Protocol applies. For the §10 path, follow the protocol's naming and
    citation requirements.

   - **BL type:** Read the referenced BL file to determine which files are in scope.
     If the BL file does not exist, stop: "BL-{NNN} not found. Check the BL number."

4. **Identify shared files:** Read `.claude/CLAUDE.md` to determine which files are
   central to the project (README, config files, trackers, profile documents, any
   file referenced as a source of truth). These are off-limits for parallel sessions.

5. **Safety check:** Before proceeding:
   - Run `git status --porcelain` to check for uncommitted changes
   - Check `.claude/parallel-sessions.txt` for any sections with `State: active`
     (existing concurrent parallel sessions)
   - For BL type: verify that the planned file scope does not overlap with any
     active parallel session's declared scope (read each `active` section's
     `Scope:` field)
   - **STOP if:**
     - Uncommitted changes overlap with the planned scope
     - Another parallel session targets the same files
     - The planned work requires shared file modifications
   - If stopped, explain the conflict and ask the user to reframe.

6. **Promote provisional registry stub to full entry:**
   Step 0 wrote a provisional stub with `CLAUDE_PID`, `Started`, and
   `State: provisional`. This step upgrades it to the full
   `parallel-{N.M}/...` form now that prefix parsing and scope
   determination have completed.

   Derive the parallel session number `{N}.{M}`:
   - `{N}` = session number parsed from the branch name (`session-{N}/...`).
     Per the Session Numbering rule above, this is the only source of truth.
   - `{M}` = 1 + count of existing sections in the registry whose
     `Session branch:` value matches the current branch (active or wrapped).
     The provisional stub itself has no `Session branch:` field, so it is
     correctly excluded from this count.

   Derive a topic slug: pick a 3-5 word kebab-case slug summarizing the task
   (e.g., `knowledge-summary-format`, `bl-300-impl`). Cap at 50 chars.

   Locate the provisional stub by its `CLAUDE_PID:` value (the PID captured
   in Step 0). Replace the stub's header line `## provisional-{pid}-{ts}`
   with the full form `## parallel-{N}.{M}/{type}/{topic-slug}` and insert
   the missing fields (Type, Task, Scope, Session branch) while preserving
   the original `Started` and `CLAUDE_PID`. Change `State: provisional` to
   `State: active`.

   The promoted section should be:

   ```markdown
   ## parallel-{N}.{M}/{type}/{topic-slug}
   Type: QA | BL-{NNN}
   Task: {description from prompt}
   Scope: {list of files, or "read-only + dsm-docs/research/{file}" for QA}
   Session branch: {current session branch name}
   Created: {original ISO timestamp from Step 0's Started field}
   CLAUDE_PID: {pid, unchanged from Step 0}
   State: active
   ```

   Preserve the `Started`/`Created` timestamp from Step 0 (rename the field
   from `Started` to `Created` during promotion). This keeps the session's
   true start time, not the promote-time, as the recorded `Created` value.

   No duplicate-PID guard at this step: it already ran in Step 0 against
   the full registry. The provisional stub written in Step 0 is the current
   session's own entry; finding it here is expected, not a duplicate.

7. **Declare scope (first output):** Report:
   ```
   PARALLEL SESSION {N}.{M} ({QA|BL-NNN})

   Session branch: {branch name} (shared, no separate branch)
   Type: {QA | BL-NNN (file-scoped)}
   Scope: {file list or "read-only + dsm-docs/research/{file}" for QA}

   This session will only edit: {file list}.
   Any edit outside this scope will be refused.

   Registry entry: .claude/parallel-sessions.txt → ## parallel-{N}.{M}/...
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

- **QA sessions:** Read any file. Writes allowed only to `.claude/` and
  `dsm-docs/research/{date}_{topic}.md` (per §10). Never edit code, methodology
  documents, BL files, or other tracked source-of-truth files.

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
