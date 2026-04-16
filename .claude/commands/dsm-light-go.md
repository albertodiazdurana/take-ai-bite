Resume a DSM session in lightweight mode. Minimal context loading for continuation sessions where the task is already known. $ARGUMENTS

## Safety Gate

Before proceeding, check `.claude/last-wrap-up.txt` for the previous session's wrap-up type.

**If `type: light`:** proceed normally (expected continuation).

**If `type: full` or `type: quick`:** Warn: "Last session ended with a [full/quick] wrap-up. `/dsm-light-go` skips inbox, version, and branch checks that matter for a fresh start. Switch to `/dsm-go`? (y = switch to full go, n = continue with light-go). **The full /dsm-go flow will run from Step 0, including Step 6 (transcript reset and Session Transcript Protocol activation), before any user task action.**" If the user accepts, stop and invoke `/dsm-go` instead. If the user declines, proceed with `/dsm-light-go`. If `type: quick`, also note: "Previous session skipped feedback push. Check `dsm-docs/feedback-to-dsm/` for unpushed entries."

**If the file does not exist (no wrap-up marker):** Warn: "No wrap-up marker found from previous session. There may be uncommitted changes or unpushed work. Switch to `/dsm-go` for full recovery? (y = switch to full go, n = continue with light-go). **The full /dsm-go flow will run from Step 0, including Step 6 (transcript reset and Session Transcript Protocol activation), before any user task action.**" If the user accepts, stop and invoke `/dsm-go` instead.

**Switch-flow guarantee (BL-331):** When the user accepts a switch from `/dsm-light-go` to `/dsm-go`, the agent MUST run the full `/dsm-go` flow from Step 0. The Session Transcript Protocol behavioral activation lives in `/dsm-go` Step 6 and must execute before any user task action. Skipping Step 6 (jumping straight into the user's actual task) is the failure mode that caused portfolio S69 to run ~6 turns with zero transcript appends. The unconditional activation rule in DSM_0.2 §7 is the third independent enforcement layer; it activates regardless of whether Step 6 ran, but Step 6 is still the canonical place where transcript reset happens.

**Legacy fallback:** If `.claude/last-wrap-up.txt` does not exist but `.claude/session-baseline.txt` contains `mode: light`, treat as `type: light` and proceed normally. This handles sessions that ran before the wrap-up type marker was introduced.

## Branch Cadence Gate (Origin: BACKLOG-326)

Light resume is for **same-day continuation only**. If the open session branch was created on a prior calendar day, refuse to resume and direct the user to full `/dsm-go`.

**Check (after Safety Gate, before Scaffold Pre-Check):**

1. Run `git branch --show-current` and parse the date segment from the branch name if it matches `session-N/YYYY-MM-DD`. For task branches (`bl-*`, `sprint-*`, `parallel/*`), skip this check and continue to Scaffold Pre-Check (task branches may span days).
2. Compare against today's date (`date +%Y-%m-%d`).
3. **If dates match:** Continue to Scaffold Pre-Check normally.
4. **If the branch date is earlier than today:** STOP and prompt interactively (BL-331 sub-item d):
   > "Session branch `{branch-name}` was created on {branch-date}, today is {today}. `/dsm-light-go` is for same-day continuation only. This branch should have been closed yesterday with full `/dsm-wrap-up`. Run `/dsm-wrap-up` now to close the stale branch cleanly? (y/n)"
   - **y:** Stop `/dsm-light-go` and invoke `/dsm-wrap-up` directly. After the wrap-up completes, the user can start a fresh session with `/dsm-go`. No further user typing is required between the gate and the wrap-up.
   - **n:** Stop and let the user decide. Present the alternative: "Run `/dsm-go` instead to force a fresh session-start flow with full checks, or invoke `/dsm-wrap-up` manually when ready." Do not proceed with the lightweight flow.

   This y/n pattern matches the Safety Gate ("Switch to /dsm-go? (y/n)") and `/dsm-go` Step 0d (stale-branch cleanup). The cadence gate is a hard stop, but the recovery action is mechanical (run wrap-up); forcing the user to type the command adds no value and breaks the flow.
5. Do not proceed with lightweight flow. The user's next invocation must be `/dsm-wrap-up` (auto-invoked on `y`) or `/dsm-go` (manual on `n`).

**Fallback when branch name has no parseable date:** Parse the ISO timestamp from `.claude/session-baseline.txt` (`# Session baseline - {timestamp}`) and compare its date to today. If neither source yields a usable date, warn "Cannot determine session branch age, proceeding as same-day" and continue.

**Why a hard gate:** The efficientnet project ran 7 consecutive lightweight cycles on one session branch without any full wrap-up because nothing enforced the cadence. A soft warning would not have caught it. See BACKLOG-326 for the full failure mode.

## Scaffold Pre-Check

Before proceeding with the lightweight flow, verify the project has a minimal
DSM scaffold. Count canonical `dsm-docs/` subdirectories (`blog`, `checkpoints`,
`decisions`, `feedback-to-dsm`, `guides`, `handoffs`, `plans`, `research`, `inbox`).

**If fewer than 5 of 9 exist:**
- Warn: "Project scaffold incomplete ({N}/9 dsm-docs/ folders). Lightweight
  start cannot operate on an unscaffolded project. Options: (a) run `/dsm-align`
  to scaffold, then retry `/dsm-light-go`, or (b) fall back to full `/dsm-go`."
- Stop and wait for user decision.

**If 5+ exist:** Continue to Git Awareness.

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per BL-162):

- **Checkpoint moves (Step 2):** Use `mv` instead of `git mv`
- **Git status (Step 3):** Skip; report "No git repository"
- **Session baseline (Step 4):** Write only the timestamp line and `mode: light`; skip git fields
- **Branch verification (Step 1.5):** Skip; no branch operations without git

## Session Numbering (Source of Truth)

The session number is the integer parsed from the current branch name
(`session-{N}/YYYY-MM-DD`). It is NEVER derived from the session-archive
count, transcript labels, MEMORY's "Latest Session" entry, or any other
heuristic.

Lightweight sessions CONTINUE an existing main session and INHERIT its
number from the branch. They do NOT increment the number. If the current
branch is `session-190/2026-04-14`, the lightweight continuation is
S190 — never S191.

Distinguish from `/dsm-go`: a fresh `/dsm-go` start derives a NEW session
number for a NEW branch; this rule applies only there. `/dsm-light-go`
and `/dsm-parallel-session-go` always inherit, never derive.

If the branch name is malformed or absent (no parseable integer), stop
and request user disambiguation rather than guessing a number.

## Steps (only if safety gate passes)

1. **MEMORY.md:** Already loaded via auto memory context. Do NOT re-read; use the version in context.
1.5. **Verify session branch:** Lightweight sessions continue an existing session; they do not create new branches.
   - Run `git branch --show-current` to get the current branch name
   - **If on a session branch (matches `session-*`):** Proceed normally. Report: "Continuing on session branch `{branch-name}`."
   - **If on a task branch (matches `bl-*`, `sprint-*`, `parallel/*`):** Proceed normally. Report: "Continuing on task branch `{branch-name}`."
   - **If on main/master:** Warn: "Currently on main, but lightweight sessions should continue an existing session branch. Either: (a) switch to the open session branch, or (b) fall back to full `/dsm-go` to create a new one." Check for open session branches (`git branch --list 'session-*'`) and offer to switch. If no session branch exists, fall back to `/dsm-go`.
1.6. **Stale branch cleanup:** After branch verification, clean up stale refs:
   1. Run `git fetch --prune` silently to remove stale remote tracking refs.
   2. Run `git branch --merged main | grep -v '^\*\|main\|session-'` to find
      stale local branches merged into main.
   3. If found, report: "Found N stale local branches merged into main: [list].
      Delete them? (y/n)". Delete on approval, skip on rejection.
   4. If none found, skip silently.
2. **Read latest checkpoint:** Run `ls -t dsm-docs/checkpoints/*.md 2>/dev/null | head -1` to find the most recent checkpoint. Read it in full. This provides the task context.
   **After reading, move the checkpoint to `done/`:**
   1. `sed -i '1i **Consumed at:** Session N start (YYYY-MM-DD)\n' dsm-docs/checkpoints/{filename}`
   2. `git mv dsm-docs/checkpoints/{filename} dsm-docs/checkpoints/done/{filename}`
   3. Report: "Checkpoint {filename} moved to done/"
   If multiple checkpoints exist in `dsm-docs/checkpoints/` (excluding `done/`), read the most recent for context, then move **all** of them to `done/` with the same annotation. If no checkpoint exists, skip silently.
3. **Git status:** Run `git status` to check for uncommitted changes.
4. **Save session baseline:** Save a new baseline snapshot (same as full `/dsm-go` step 6), then append `mode: light` to preserve the chain for the next lightweight wrap-up.
5. **Transcript boundary marker:** Append a session boundary marker to the existing `.claude/session-transcript.md` (do NOT archive or overwrite). The session number `{N}` MUST be the integer parsed from the current branch name per the Session Numbering rule above (e.g., branch `session-190/2026-04-14` → N=190). Do NOT increment, do NOT use archive count:
   ```markdown

   ---

   ## Session {N} (lightweight continuation)
   **Started:** [timestamp]
   **Previous session artifacts:**
   - Checkpoint: [filename from step 2]
   - MEMORY.md updated: [yes/no from checkpoint]

   **Context loaded:**
   - MEMORY.md (latest)
   - Checkpoint: [filename]

   ---
   ```
6. **Report:** Brief summary:
   - Current session: S{N} (from branch, per Session Numbering rule)
   - Last completed session: [from MEMORY.md "Latest Session" entry — distinct
     from current session number; this is the most recent FULL wrap-up]
   - Session branch: [branch name from Step 1.5, or "main (no git)" if GIT_AVAILABLE is false]
   - Task context: [from checkpoint, what remains]
   - Deferred items: [list from checkpoint]
   - Uncommitted changes: [from git status]
7. **Configuration recommendation:** If `~/.claude/claude-subscription.md` exists and the session scope is known (from checkpoint or $ARGUMENTS), include a configuration recommendation in the report. Format:
    ```
    Recommended config: [Profile] ([Model], [Effort] effort, Thinking [ON/OFF], Fast [ON/OFF])
    Reason: [1 sentence based on planned work scope]
    ```
    If the subscription file does not exist or scope is not yet known, skip this step.
8. **Continue:** If $ARGUMENTS is provided, start on that topic directly. Otherwise, summarize the last session's activity (from checkpoint) and suggest the next step based on pending work. Frame it so the user can respond with Y/N or "proceed" rather than an open-ended question. Example: "Last session completed X. Next up: Y. Proceed?"
9. **Behavioral activation (mandatory, not deferred):** From this point forward, follow the Session Transcript Protocol (DSM_0.2): append thinking to `.claude/session-transcript.md` as the **first tool call** of every turn, before any other tool calls or file edits. Append output summary as the **last tool call** after completing work. Conversation text is for results, summaries, and questions only, never for reasoning. This is not a checklist item; it is a behavioral mode that remains active for the entire session. **Lightweight mode reduces context loading, not reasoning documentation.** The thinking-before-acting step is the primary error prevention mechanism; skipping it in lightweight mode has caused cascading failures in spoke projects.

## Notes

- Do NOT read reasoning lessons (deferred)
- Do NOT check inbox (deferred)
- Do NOT check DSM version (deferred)
- Do NOT validate ecosystem paths (deferred)
- Do NOT check handoff lifecycle (deferred)
- Do NOT archive or reset the transcript (it persists from previous session)
- Follow .claude/CLAUDE.md conventions for this project
