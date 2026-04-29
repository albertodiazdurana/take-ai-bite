Resume a DSM session. Read context and report current state. $ARGUMENTS

## Git Pre-Step: Ensure Git Initialized

Before caching GIT_AVAILABLE, check if git is initialized:

1. Run: `git rev-parse --is-inside-work-tree 2>/dev/null`
2. If **not** a git repo:
   a. Run: `git init`
   b. Run: `git branch -m main`
   c. Ask: "Remote repository? (GitHub URL or 'none' for local-only)"
   d. If URL provided: `git remote add origin {url}`
   e. Create initial commit: `git add .` then `git commit -m "Initialize DSM project"`
   f. Report: "Git initialized. All DSM projects require a local git repository."
3. Continue to Git Awareness below.

## Git Awareness

At the start, run `git rev-parse --is-inside-work-tree 2>/dev/null`. Cache the result as `GIT_AVAILABLE` (true/false). If false (no git repo, e.g., private projects per the private-project protocol), the following adjustments apply throughout:

- **Checkpoint moves (Step 3, 3.5):** Use `mv` instead of `git mv`
- **Git status (Step 4):** Skip; report "No git repository"
- **Session baseline (Step 5):** Write only the timestamp line; skip `git rev-parse HEAD`, `git status --porcelain`, and checksums
- **Recent history (Step 7):** Skip; report "No git repository"
- All filesystem-only steps (MEMORY.md, transcript, inbox) run unchanged.
- **Session branch setup (Step 0):** Skip; no branch operations without git

## Step 0.5: Scaffold Completeness Check

Before project type detection or branch setup, verify that the project has the
canonical DSM scaffold. The scaffold is project-type-agnostic; it must exist
before any session-start protocol can run correctly.

1. Count how many of the 9 canonical `dsm-docs/` subdirectories exist:
   `blog`, `checkpoints`, `decisions`, `feedback-to-dsm`, `guides`, `handoffs`,
   `plans`, `research`, `inbox`
2. Also check for `_inbox/` at project root
2a. Also check for `.claude/reasoning-lessons.md`
3. **If fewer than 5 of 9 `dsm-docs/` subdirectories exist, or `_inbox/` is missing, or `.claude/reasoning-lessons.md` is missing:**
   - Warn: "Project scaffold incomplete ({N}/9 dsm-docs/ folders found).
     Forcing /dsm-align in Step 1.8 regardless of version match."
   - Set a flag `FORCE_ALIGN=true`. Continue to Step 0 (do NOT invoke `/dsm-align` here).
   - In Step 1.8, if `FORCE_ALIGN=true`, skip the version check and run `/dsm-align` unconditionally.
4. **If scaffold is complete (5+ folders, `_inbox/` exists, and `.claude/reasoning-lessons.md` exists):** Continue to Step 0.

## Step 0.8: Cloned-Mirror Kick-off Check

Per **DSM_0.2.A §25** (Cloned-Mirror Kick-off Protocol). Detects whether the
current repo is a freshly cloned DSM mirror that has not yet been kicked off,
and invokes the Kick-off sequence from §25.2 if so.

### 0.8a. Skip conditions (evaluate first)

Skip silently to Step 0 if **any** of these are true:

- `.claude/kickoff-done.txt` exists (Kick-off has already run on a prior session)
- This repo is DSM Central (detection: `scripts/take-ai-bite-sync.txt` exists
  at the repo root; Central is the source of mirrors, never a clone of one)
- The repo is a spoke (detection: `.claude/dsm-ecosystem.md` exists AND has
  a `dsm-central` row whose `Path` points to a DIFFERENT filesystem location
  than the current repo root)

### 0.8b. Detection signals

If none of the skip conditions match, evaluate Kick-off signals. Fire Kick-off
when **either** is true:

1. `.claude/dsm-ecosystem.md` does not exist in the repo root
2. `.claude/dsm-ecosystem.md` exists but its Paths table does not contain a
   row where `Name = dsm-central` and `Path = $(pwd)` (i.e., the clone has
   not self-registered as its own local hub)

If neither signal fires, skip to Step 0. This handles the edge case where
the user manually created `.claude/dsm-ecosystem.md` with correct self-
registration but no `kickoff-done.txt` marker.

### 0.8c. Execute Kick-off sequence

Invoke the 14-step sequence documented in **DSM_0.2.A §25.2**. Step 0.8 is
the invocation point, not the specification. Key steps summarized:

1. Auto-derive runtime values (no user prompt): `{REPO_ROOT}` from `pwd`,
   `{project_name}` from `basename $(pwd)`, `{ISO_DATE}` from `date -I`.
2. Verify working directory resolves to the repo root; if invoked from a
   subdirectory, use `git rev-parse --show-toplevel` instead.
3. Copy the five `.claude/*.template` files to runtime paths
   (`.claude/CLAUDE.md`, `.claude/settings.json`, `.claude/dsm-ecosystem.md`,
   `.claude/reasoning-lessons.md`, `.claude/skills-registry.md`). Substitute
   `{REPO_ROOT}`, `{project_name}`, `{ISO_DATE}`, and `{N}` using the Edit
   tool (not shell `sed`; avoids regex-quoting issues with paths).
4. Self-register the clone as `dsm-central` by writing a row with
   `Name: dsm-central`, `Path: {REPO_ROOT}`, `Description: Local DSM hub
   (this clone)`, `Mirror: -` in the new `.claude/dsm-ecosystem.md`.
5. Create `.claude/memory/MEMORY.md` as an empty stub with just a title
   line and an explanatory comment.
6. Run `scripts/sync-commands.sh --deploy` to install command runtime
   copies. If the script is missing (indicates incomplete T1a mirror sync),
   warn and continue rather than failing Kick-off.
7. `chmod +x .claude/hooks/transcript-reminder.sh
   .claude/hooks/validate-transcript-edit.sh` (idempotent; Edit/Write
   tools can strip the executable bit between runs).
8. Inspect `.git/info/exclude` for the blanket `.claude/` rule per §25.5.
   Do NOT edit this file. Report the finding to the user as informational.
9. Delegate `_inbox/` and `dsm-docs/` folder scaffolding to Step 1.8
   (which runs `/dsm-align` unconditionally and handles the canonical
   folder list in `/dsm-align` Step 3). Step 0.8 does not need to scaffold
   folders itself.
10. Write `.claude/kickoff-done.txt` with date, author, project_name, and
    repo_root, so subsequent `/dsm-go` sessions skip Kick-off per §0.8a.

### 0.8d. On Kick-off completion

Report to the user:

> "Cloned-Mirror Kick-off complete. This clone is now self-registered as
> `dsm-central` in `.claude/dsm-ecosystem.md`. `/dsm-align` (Step 1.8) will
> now populate the CLAUDE.md alignment section from the DSM_0.2 §17.1
> template. Proceeding with session setup."

Continue to Step 0 (Session Branch Setup).

### 0.8e. On Kick-off failure

If any Kick-off step fails (missing template file, user cancels the input
prompt, permission error on chmod, etc.):

- Report the specific step that failed and the reason
- Do NOT write `.claude/kickoff-done.txt` (preserves re-runnability on the
  next session)
- Halt `/dsm-go` for user intervention; do not proceed to Step 0 with an
  incomplete Kick-off

### 0.8f. Idempotency

Step 0.8 is idempotent for safe re-run: if Kick-off was partially completed
in a prior session (some templates copied, marker not written), re-running
Kick-off skips any sub-step whose effect is already present (per §25.2's
per-step "already done, skip without error" rule). This is how `/dsm-go`
can recover from an interrupted first session.

**Origin:** Cloned-Mirror Kick-off phase T5 (Session 191). Wires `/dsm-go` into
DSM_0.2.A §25.

## Step 0: Session Branch Setup

**Requires:** GIT_AVAILABLE = true. If false, skip this step entirely.

This step implements the Three-Level Branching Strategy (DSM_0.2) by ensuring
every session operates on a Level 2 session branch, never directly on main.

**Note (DSM_0.2 §20.8):** Session branch creation at Step 0 covers the
session-start case. For the **post-merge case** (when an in-session
`gh pr merge --delete-branch` lands the working copy on main), see DSM_0.2
§20.8 (Post-Merge Branch Recreation Rule). The chain pattern
`gh pr merge ... && git checkout -b session-{N}/{YYYY-MM-DD}-{purpose}`
prevents the silent commit-to-main failure mode.

### 0a. Determine session number

Determine the new session number using **three sources** and taking the higher value:

1. **Archive count:** Count files in `.claude/transcripts/*.md`. If the directory
   does not exist, archive count is 0.
   ```bash
   ARCHIVE_COUNT=$(ls .claude/transcripts/*.md 2>/dev/null | wc -l)
   ```
2. **MEMORY.md:** Extract the session number from the "Latest Session" line in
   MEMORY.md (from auto memory context). If MEMORY.md does not exist or has no
   session number, memory session number is 0.
3. **Remote session branches:** Count pre-existing `origin/session-*` branches.
   On fresh mirror clones with pre-existing test-session remotes (e.g., from a
   pre-Kick-off PR), this is the only non-zero signal. Merged branches still
   block the branch name, so count all matches regardless of merge state.
   ```bash
   REMOTE_SESSION_COUNT=$(git branch -r --list 'origin/session-*' 2>/dev/null | wc -l)
   ```

**Formula:** `N = max(ARCHIVE_COUNT, MEMORY_SESSION_NUMBER, REMOTE_SESSION_COUNT) + 1`

This handles three cases: projects with many archived transcripts but stale
MEMORY.md (spokes with incomplete wrap-ups), projects with few/no archives
but high session numbers (DSM Central, long-running projects), and fresh
mirror clones that inherit pre-existing remote session branches from
pre-Kick-off test work (e.g., TAB's T7 case inheriting `origin/session-1`
from the mirror-bootstrap PR).

### 0b. Check for open branches from previous sessions

Run `git branch --list 'session-*'` and `git branch --list 'bl-*'` and
`git branch --list 'sprint-*'` to check for open task or session branches.

Also check for remote branches not yet checked out:
`git branch -r --list 'origin/session-*' --list 'origin/bl-*'`

### 0c. Branch decision

**If an open Level 3 branch exists (bl-*, sprint-*):**
- Inform the user: "There is an open task branch `{branch-name}` from a
  previous session. The logical next step is to finalize this work before
  starting new work."
- Check it out: `git checkout {branch-name}`
- Proceed to Step 1

**If an open `session-N/*` branch exists AND MEMORY marks session N as wrapped (closed-session leftover):**

Detect using four signals — all four must be true:
1. An open `session-N/*` local branch exists
2. The branch name parses a session number N
3. MEMORY's "Latest Session" line reports session N
4. MEMORY text for session N contains wrap-up markers: "wrap-up", "wrapped",
   "full wrap-up", "merged to main", or "released"

If all four are true:
- Treat as **close-out reconciliation**, not resumption
- Do NOT check out the leftover branch; stay on main (or whichever branch
  Step 0 is running from)
- The session number arithmetic in Step 0a already produces N+1 correctly
  once the leftover branch is not resumed — proceed with that N+1
- Run Steps 5.5 (archive transcript) and 6 (transcript reset) normally;
  the leftover branch's state does not block these steps
- Create new `session-{N+1}/{YYYY-MM-DD}` branch off main (standard path)
- After Step 8 report, surface the leftover branch to the user:
  "Leftover branch `{branch}` has commits from post-wrap work in session N.
   Merge into main, continue work on it this session, or discard? (m/c/d)"

If fewer than four signals match, fall through to the standard resumption path below.

**Note:** This case is the inverse complement of Step 5.8 (Incomplete wrap-up
recovery). Step 5.8 fires when the branch session number is HIGHER than MEMORY's
latest session (branch is ahead of MEMORY). This new case fires when branch and
MEMORY agree on N but MEMORY says N is already wrapped (MEMORY is ahead of branch
state). Together they cover the full matrix of MEMORY-vs-branch disagreement.

**Origin:** S199. S198 §22 violation (Steps 5.5/6 skipped) was
caused by this missing case.

**If an open Level 2 session branch exists (session-*):**
- Inform the user: "Resuming open session branch `{branch-name}` from a
  previous session."
- Check it out: `git checkout {branch-name}`
- Proceed to Step 1

**If already on a session branch (current branch matches session-*):**
- Inform the user: "Already on session branch `{branch-name}`."
- Proceed to Step 1

**If on main/master with no open branches:**
- Create new session branch: `git checkout -b session-{N}/{YYYY-MM-DD}`
  where N is from Step 0a and YYYY-MM-DD is today's date
- Report: "Created session branch `session-{N}/{YYYY-MM-DD}`."
- Proceed to Step 1

**Priority order:** Level 3 branches take precedence over Level 2 branches.
The closed-session leftover case takes precedence over the generic Level 2
resumption case. If multiple branches exist at the same level, present the
list and ask the user which one to resume.

### 0d. Stale branch cleanup

After branch setup, clean up stale refs from prior sessions:

1. **Prune stale remote tracking refs:** Run `git fetch --prune` silently.
   This removes local tracking refs for branches already deleted on the remote.
2. **Check for stale local branches:** Run
   `git branch --merged main | grep -v '^\*\|main\|session-'` to find local
   branches that are fully merged into main and are not the current session branch.
   This catches orphaned worktree branches (`worktree-agent-*`) and old task
   branches that were merged but not deleted.
3. **If stale branches found:** Report: "Found N stale local branches merged
   into main: [list]. Delete them? (y/n)". On approval, delete with
   `git branch -d {branch}` for each. On rejection, skip silently.
4. **If no stale branches:** Skip silently.

### 0e. Ensure hooks are executable

Run unconditionally on every `/dsm-go`, before any other step:

```bash
chmod +x .claude/hooks/*.sh 2>/dev/null || true
```

This is one command. If `.claude/hooks/` is absent or empty, it is a no-op. This step is the session guarantee that hooks are always executable, independent of whether `/dsm-align` runs. It replaces the previous dependency on `/dsm-align` Step 10b as the only source of `chmod +x`. The S180 failure mode (hooks present but not executable, align not run) is closed here.

## Steps

1. **Read MEMORY.md:** Find and load this project's MEMORY.md from the auto memory directory to restore session context. **If MEMORY.md does not exist or fails to load**, continue to Step 2 but note that the agent is operating without prior session context, which increases the risk of applying generic rules to a project with specific overrides.
1.5. **Read reasoning lessons:** If `.claude/reasoning-lessons-compact.md` exists, prefer it (per DSM_0.2.A §8.1). Read the compact mirror IN FULL and report any category particularly relevant to the current project. The compact mirror is size-bounded (target ~70 entry lines, hard cap 8 KB) and drops guidelines + provenance, so reading it in full is the design intent.
   **Staleness check:** the compact mirror has a `**Source mtime at regeneration:**` field in its header. If the live `.claude/reasoning-lessons.md` mtime is newer than that field's value, the compact mirror is stale. In that case, regenerate inline by re-running the trim per DSM_0.2.A §8.1 (drop first ~20 guideline lines + inline provenance prefix; preserve category headings + body verbatim; refresh the freshness header) BEFORE reading. The inline regeneration follows the same rule used by `/dsm-wrap-up` Step 0.
   **Fallback:** if `.claude/reasoning-lessons-compact.md` does not exist (e.g., the project has not run a `/dsm-wrap-up` since the §8.1 protocol amendment), but `.claude/reasoning-lessons.md` does exist: fall back to reading the first 10 lines of the live file (header + category names) and warn "Compact reasoning-lessons mirror missing; running /dsm-wrap-up regenerates it." If neither file exists, skip this step silently.
1.8. **Run /dsm-align if DSM version changed (§1.8 conditional-align rule):** Check whether the DSM version has changed since last alignment before invoking `/dsm-align`.

   **Version check procedure:**
   1. Read `.claude/last-align.txt` → extract `dsm-version: vX.Y.Z`. If the file does not exist, treat as version mismatch (force align).
   2. Resolve DSM Central path: read `dsm-central` from `.claude/dsm-ecosystem.md`, or fall back to the path in the `@` reference of `.claude/CLAUDE.md`. If Central cannot be resolved, fall back to running `/dsm-align` (safe degradation).
   3. Read `{dsm-central}/CHANGELOG.md` → extract the latest `## [vX.Y.Z]` heading (first match).
   4. **If versions match:** skip `/dsm-align`. Report: "Skip /dsm-align: last-align version (vX.Y.Z) matches current DSM version. Hook chmod covered by Step 0e."
   5. **If versions differ:** run `/dsm-align`. Report: "Running /dsm-align: DSM updated from vA.B.C to vX.Y.Z." After `/dsm-align` completes, re-read `.claude/last-align.txt` to confirm the marker is current.

   **Why conditional:** The previous unconditional run (S180 §22 hardening) was necessary because `/dsm-align` was the sole source of `chmod +x` on hooks. Step 0e now owns that guarantee unconditionally. The remaining reasons to run `/dsm-align` — scaffold drift, CLAUDE.md alignment block drift, broken `@` reference — are all caused by DSM version updates that change templates or protocols. A version match means no template changed since last alignment; running `/dsm-align` in that case only reads files without making changes. The context cost (~30-40% on Sonnet) is not justified by the safety value when the version is unchanged.

   **Failure modes covered by Step 0e (not /dsm-align):**
   - Hook scripts lose executable bit between sessions (Edit/Write tool strips it) → Step 0e chmod runs unconditionally.

   **Failure modes still covered by /dsm-align (on version change):**
   - CLAUDE.md alignment block drifted from template → detected and fixed.
   - Scaffold folders missing → created.
   - `@` reference stale or broken → fixed.
   - Hook scripts absent (not just non-executable) → copied from Central.

   **`/dsm-light-go` exception:** `/dsm-light-go` is the explicit lightweight escape hatch for context-pressure continuation sessions. It does NOT run this version check or invoke `/dsm-align`; this asymmetry is intentional.
2. **DSM_0.2 session-start checks (act, not just report):** Read the `@`-referenced DSM_0.2 file in `.claude/CLAUDE.md` for current protocols, then **perform** each session-start action **in the order listed** (each sub-step may depend on results from prior sub-steps):
   - **2a. Project type detection (MUST complete first; gates 2b):** Identify and state the project type. Read the project CLAUDE.md to determine governance boundaries. For External Contribution projects, note that governance artifacts route to DSM Central, not the repo root.
   - **2a.5. Ecosystem Path Registry:** Read `.claude/dsm-ecosystem.md` (created by `/dsm-align` in Step 1.8). Parse the Paths table and cache each Name -> Path mapping for the session. For each entry, verify the path exists on the filesystem:
     - If the path exists: note as validated
     - If the path does not exist: warn "Ecosystem path '{name}' points to '{path}' which does not exist. Cross-repo operations using this path will be skipped."
   - **2a.6. Default-branch verification:** If `GIT_AVAILABLE` is true AND `git remote get-url origin` returns a URL containing `github.com`, resolve the configured remote default branch with `gh repo view --json defaultBranchRef --jq .defaultBranchRef.name`. Compare against the local main line: read the project-specific section of `.claude/CLAUDE.md` for an optional `**Main branch:**` declaration; default to `main` if absent. If the remote default differs from the local main line, **halt with a critical warning** that names both values and the fix command (`gh repo edit --default-branch {local}`). This is a hard gate: no session work proceeds until the user fixes the configuration OR types `defer` to bypass for this session only. Cache the resolved value for the session (one `gh` call per session). **Skip silently if:** remote `origin` does not point at GitHub (no `github.com` substring), OR `gh` CLI is not installed (warn once: "install gh to enable default-branch verification" and continue). Origin: Default-branch verification protocol. Failure mode this catches: dsm-jupyter-book S4 lost ~45 minutes to an HTTP 404 cascade because the repo's default branch was a stale session branch, not `main`.
   - **2a.8. CLAUDE.md section completeness (Module A §23):** Check whether CLAUDE.md contains all 4 required sections (DSM_0.2 Alignment, participation pattern, project type, project specific). If all present, pass silently. If sections are missing, report which ones and suggest completing them before implementation. This is a hard gate: no implementation work until all 4 sections exist. Existing complete projects pass silently.
   - **2b. Inbox check (behavior depends on project type from 2a):** If this is an External Contribution, do NOT create `_inbox/` in the external repo (see DSM_0.2 External Contribution exception). **Inbox location and resolution by project type:**

     **DSM hub (DSM Central) / DSM spoke:**
     - Target: `_inbox/` at repo root
     - Check: `ls _inbox/` (exclude `README.md` and `done/` from results)
     - If `ls` shows no entries besides `README.md`, confirm with a second method (`ls -la`) before concluding the inbox is empty (Glob with literal paths silently fails for `_inbox/` directories)

     **External contribution governance:**
     - Resolution:
       1. Read `contributions-docs` from the ecosystem registry cached in Step 2a.5
       2. Derive project name: `basename "$(pwd)"`
       3. Target: `{contributions-docs}/{project-name}/_inbox/`
     - Check: `ls {target}/` (exclude `README.md` and `done/` from results). Example: `ls ~/dsm-external-contribution-storage/IronCalc/_inbox/`
     - The governance inbox is the **only** inbox to check for EC projects. Do NOT also scan `_inbox/` at the external repo root; per the External Contribution protocol it should not exist there, and scanning would waste a call and risk the wrong-path failure mode
     - **Skip condition:** if `contributions-docs` is missing from the ecosystem registry, or the resolved `{target}/` path does not exist on the filesystem, warn "EC governance inbox resolution failed (contributions-docs registry entry missing OR {target} does not exist). Skipping EC inbox check, run `/dsm-align` to scaffold." and continue the session without halting

     **Processing (all project types, inbox lazy-load):** List filenames only at session start. Report: "Inbox: N pending entries: [filename list]. Read and process entries at user request." Do NOT read file contents during session start. The agent reads a specific entry only when the user explicitly requests inbox processing (e.g., "process the inbox" or "read the [name] entry"). This defers context cost to when the user actually acts on an entry. Exception: if a filename contains "urgent" or "critical", surface it as a note in the report.
   - **2d. Subscription file:** Read `~/.claude/claude-subscription.md` if it exists. Cache the plan type and configuration profiles for the session. If the file does not exist, note: "No subscription file found. To enable session configuration recommendations, provide your Claude plan details." Continue without recommendations until the file is created.
   - Any other session-start protocols added to DSM_0.2 in the future
3. **Handoff lifecycle:** Check `dsm-docs/handoffs/` for consumed handoffs. Any handoff file (not in `done/`) that predates this session has been consumed and should be moved:
   - Move the file to `dsm-docs/handoffs/done/`
   - Add `**Date Completed:** YYYY-MM-DD` and `**Outcome Reference:** Consumed at session N start` to the file header
   - Report each moved file in the session report
3.5. **Checkpoint check:** List `dsm-docs/checkpoints/` (excluding `done/`). If a checkpoint exists from the most recent session (matching the session number or date in MEMORY.md), read it in full; it contains consolidated state that supplements MEMORY.md (pending work details, branch state, decision context). Extract pending items and next steps from the checkpoint; these become **suggested work items** in the session report (Step 8). If no recent checkpoint exists, skip silently.
   **After reading, move the checkpoint to `done/`:**
   1. `sed -i '1i **Consumed at:** Session N start (YYYY-MM-DD)\n' dsm-docs/checkpoints/{filename}`
   2. `git mv dsm-docs/checkpoints/{filename} dsm-docs/checkpoints/done/{filename}`
   3. Report: "Checkpoint {filename} moved to done/"
   If multiple checkpoints exist in `dsm-docs/checkpoints/` (excluding `done/`), read the most recent for context, then move **all** of them to `done/` with the same annotation.
3.6. **Sprint boundary gate:** If MEMORY.md or the checkpoint references a recently completed sprint (e.g., "Sprint N complete"), verify that boundary artifacts exist before suggesting new sprint work:
   - Checkpoint for the completed sprint in `dsm-docs/checkpoints/done/` (or just consumed in 3.5)
   - Blog journal entry in `dsm-docs/blog/journal.md` with a matching date
   - Feedback files updated (per-session file in `dsm-docs/feedback-to-dsm/` or entry in `technical.md`)
   If any are missing, flag them: "Sprint N boundary incomplete: missing [items]. Complete these before starting Sprint N+1, or defer with confirmation."

   **Sprint plan structural hard gate (per §3a sprint-plan audit):** When MEMORY.md or the
   checkpoint references sprint N closure, locate the Sprint N plan in
   `dsm-docs/plans/` (or `dsm-docs/plans/done/` if already moved , check
   both). Candidate selection: `.md` files whose first-line heading
   matches `^#\s+Sprint\s+N\b` where N is the referenced sprint number. If
   found, check for the presence of a `## Sprint Boundary Checklist`
   section header in the plan file. If the section is MISSING, halt with:

   > "Sprint N plan (`{path}`) is missing the Sprint Boundary Checklist
   > section (DSM_2.0.C §1 Template 8). Closure cannot proceed until the
   > section is added or a deferral is confirmed. Options:
   >   1. Add the missing section to the plan (recommended).
   >   2. Confirm the checklist was executed out-of-band and proceed
   >      anyway (type 'defer' to bypass this gate for this session).
   >   3. Stop and resolve manually."

   This is a hard gate because the Sprint Boundary Checklist is the only
   surviving plan-level record of what "closed" means. Without it, closure
   is ambiguous and reproduces the GE S47 failure mode that spawned
   the sprint closure/verification protocol. The 'defer' escape hatch exists for real cases where the
   checklist was executed through other means; log deferrals in the
   session transcript so they surface during retrospectives.

   **Skip when:** First sprint in a project (no prior boundary to check),
   when no sprint identifier is found in MEMORY.md/checkpoint, or when
   the Sprint N plan file itself cannot be located (e.g., plan was never
   formalized in `dsm-docs/plans/`).
4. **Git status:** Run `git status` to check for uncommitted changes
5. **Save session baseline:** Save a snapshot of the current working tree state to `.claude/session-baseline.txt` so that `/dsm-wrap-up` can identify which changes belong to this session. Run:
   ```
   echo "# Session baseline - $(date -Iseconds)" > .claude/session-baseline.txt
   echo "# Session branch" >> .claude/session-baseline.txt
   git branch --show-current >> .claude/session-baseline.txt
   echo "# HEAD commit" >> .claude/session-baseline.txt
   git rev-parse HEAD >> .claude/session-baseline.txt
   echo "# Working tree" >> .claude/session-baseline.txt
   git status --porcelain >> .claude/session-baseline.txt
   echo "# Checksums" >> .claude/session-baseline.txt
   git status --porcelain | grep -v '^\?' | awk '{print $2}' | xargs -r md5sum >> .claude/session-baseline.txt
   git status --porcelain | grep '^\?' | awk '{print $2}' | xargs -r md5sum >> .claude/session-baseline.txt
   ```
   **External Contribution note:** For External Contribution projects, session artifacts (baseline, transcript) are written to `.claude/` inside the external repo. These files are hidden from git by Claude Code's `.git/info/exclude` rule (which adds `.claude/`), not by DSM or the project's `.gitignore`. This is an acceptable trade-off: the files are invisible to `git status` and cannot leak into upstream PRs, but the safety net depends on Claude Code's infrastructure. If working with a different AI tool that does not exclude `.claude/`, these files would be visible.
5.5. **Archive previous transcript:** If `.claude/session-transcript.md` exists and contains content beyond a blank header, archive it before overwriting. Extract the timestamp from the `**Started:**` line in the transcript header, then move the file:
   ```bash
   # Extract timestamp from transcript header (format: YYYY-MM-DDTHH:MM:SS+TZ)
   STARTED=$(grep '^\*\*Started:\*\*' .claude/session-transcript.md | sed 's/\*\*Started:\*\* //' | head -1)
   # Convert to filename-safe format (YYYY-MM-DDTHH:MM)
   TS=$(echo "$STARTED" | sed 's/\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}T[0-9]\{2\}:[0-9]\{2\}\).*/\1/')
   if [ -n "$TS" ] && [ "$TS" != "" ]; then
     mkdir -p .claude/transcripts
     cp .claude/session-transcript.md ".claude/transcripts/${TS}-ST.md"
   fi
   ```
   If the transcript has no `**Started:**` line (corrupted or empty), skip archiving. Report the archived filename in the session report.
5.7. **STAA reminder:** If a transcript was archived in Step 5.5, check whether the previous session's wrap-up included a STAA recommendation. If the archived transcript's final entries contain "STAA recommended: yes", remind the user: "Previous session recommended STAA analysis. Run `/dsm-staa` in a separate Claude Code conversation (do not wrap in `/dsm-go` or `/dsm-parallel-session-go`)." If no transcript was archived, or if the previous session recommended "STAA: no", skip this step silently.
5.8. **Incomplete wrap-up recovery:** Detect whether the previous session ended without a full wrap-up by comparing MEMORY.md's "Latest Session" number against the current branch session number (extracted from the branch name, e.g., `session-139/...` → 139). If the branch number > MEMORY number, the previous session had an incomplete wrap-up.
   **If detected:**
   1. Inform the user: "Session {N} ended without full wrap-up. Archived transcript available at `.claude/transcripts/{archived-filename}`."
   2. Offer content reconstruction: "Reconstruct MEMORY update and reasoning lessons from the archived transcript? (y/n)"
   3. **If accepted:**
      a. Read the archived transcript
      b. Parse for: BLs completed, key decisions, work summary (scan `**Output:**` blocks and thinking blocks)
      c. Supplement with `git log main..HEAD` to capture all commits from the incomplete session
      d. Update MEMORY.md "Latest Session" section with the reconstructed summary
      e. Extract reasoning lessons: scan thinking blocks for decision patterns, course corrections, efficiency observations. Append new entries to `.claude/reasoning-lessons.md` tagged as `[recovered]`
      f. Report what was reconstructed
   4. **Action suggestions (always shown, regardless of reconstruction choice):**
      a. Check if the previous session's branch should be merged to main. If all work is committed and no Level 3 branches remain open, suggest: "Session {N}'s branch is ready to merge to main. Merge now and create a new session branch? (y/n)". If the user accepts, merge to main, delete the old session branch, and create a new session branch (`session-{N+1}/YYYY-MM-DD`) for the current session before continuing to Step 6.
      b. Check `git status` and `git log main..HEAD` for uncommitted or unpushed work; suggest commit/push if needed
      c. Check if feedback files in `dsm-docs/feedback-to-dsm/` were created during the incomplete session but not pushed to spokes (compare file dates against last inbox push); suggest feedback push if pending
      d. Suggest contributor profile review if the reconstructed work involved new skill areas
      e. Present as a checklist: "Missing wrap-up actions from Session {N}: [ ] Merge session branch to main [ ] Push to remote [ ] Push feedback to spokes [ ] Review contributor profile"
   **If not detected (MEMORY is current):** Skip silently.
   **If no archived transcript exists:** Warn "Incomplete wrap-up detected but no archived transcript found. MEMORY update must be done manually." Still show action suggestions.
5.9. **Wrap-up type guidance:** Read `.claude/last-wrap-up.txt` if it exists. Extract the `type` field.
   - **If `type: light`:** The previous session ended with a light wrap-up, signaling continuation. Prompt the user: "Last session ended with a light wrap-up (continuation expected). Switch to `/dsm-light-go` for a faster resume? (y = switch to light-go, n = continue with full go)". If the user accepts, stop `/dsm-go` and invoke `/dsm-light-go` instead. If the user declines, continue with full `/dsm-go`.
   - **If `type: quick`:** Note in the session report: "Previous session used quick wrap-up (no feedback push). Check `dsm-docs/feedback-to-dsm/` for unpushed entries."
   - **If `type: full`:** No action needed. Continue normally.
   - **If the file does not exist:** No action (step 5.8 handles incomplete wrap-up detection).
6. **Reset session transcript:** Overwrite `.claude/session-transcript.md` with a fresh session header (the file persists across sessions; do not delete and recreate it).

   **No-skip rule (§7 unconditional activation):** This step is the canonical activation point for the Session Transcript Protocol. When `/dsm-go` is entered as a deferral from `/dsm-light-go` (the user accepted the safety gate's "switch to /dsm-go?" prompt), Step 6 MUST run before any user task action. Skipping Step 6 to jump straight into the user's task is the failure mode that caused portfolio S69 to run ~6 turns with zero transcript appends. The unconditional activation rule in DSM_0.2 §7 is the third independent enforcement layer, but Step 6 is the canonical reset + activation point and the agent must execute it on every entry to `/dsm-go`, including deferral entries.

   **Heredoc warning (§7 append technique):** The `cat > ... << EOF` form below uses an unquoted heredoc deliberately so `$(date -Iseconds)` expands. Do NOT change to `<< 'EOF'` (single-quoted); single-quoted heredocs suppress expansion and write the literal `$(date -Iseconds)` string into the transcript instead of the timestamp. Observed in portfolio S69.

   Write exactly this content, replacing N, timestamp, project name, agent, and model:
   ```bash
   cat > .claude/session-transcript.md << EOF
   # Session N Transcript
   **Started:** $(date -Iseconds)
   **Project:** [project name from MEMORY.md or directory name]
   **Agent:** [harness identifier, e.g., "Claude Code"]
   **Model:** [model identifier, e.g., "claude-opus-4-7"]
   EOF
   ```

   After the mandatory header, append optional platform-specific fields when retrievable (omit entirely when not — ritualism guard: do NOT write placeholder values like `Effort: unknown`):
   ```bash
   cat >> .claude/session-transcript.md << EOF
   **Effort:** [low | medium | high]
   **Thinking:** [on | off]
   **Fast mode:** [on | off]
   EOF
   ```

   Then append the closing separator:
   ```bash
   cat >> .claude/session-transcript.md << EOF

   ---
   EOF
   ```

   **Agent/Model self-reporting:** the agent introspects its identity from the runtime environment. If retrieval is uncertain, append `(self-reported)` to the value (e.g., `**Model:** claude-opus-4-7 (self-reported)`). Do NOT fail `/dsm-go` on missing metadata.

   This file is the persistent reasoning log per the Session Transcript Protocol in DSM_0.2. The user keeps it open in VS Code to monitor agent thinking in real time.

   **Behavioral activation (mandatory, immediate):** From this point forward,
   follow the Session Transcript Protocol (DSM_0.2): append thinking to
   `.claude/session-transcript.md` as the **first tool call** of every turn,
   before any other tool calls or file edits. Append output summary as the
   **last tool call** after completing work. Conversation text is for results,
   summaries, and questions only, never for reasoning. This is not a checklist
   item; it is a behavioral mode that remains active for the entire session.

   **This activation applies to /dsm-go's own remaining steps (7, 8, 9, 10).**
   Immediately after creating the transcript header, append a thinking entry
   summarizing the session-start checks completed so far (steps 0-6: session
   number determined, branch verified, inbox checked, version checked, transcript
   archived, baseline saved). Then continue with step 7. This ensures the
   transcript is never empty after /dsm-go completes.

7. **Recent history:** Run `git log --oneline -5` to show recent commits
8. **Report:** Summarize in this format:
   - Last session: [number, date, description from MEMORY.md]
   - Session branch: [branch name from Step 0, or "main (no git)" if GIT_AVAILABLE is false]
   - Uncommitted changes: [yes/no, brief list if any]
   - Baseline saved: [yes/path]
   - Suggested work items: [pending items from checkpoint (Step 3.5) and MEMORY.md, presented as actionable suggestions ordered by priority]
9. **Ask:** "What would you like to work on?" (If suggested work items exist, present them as starting options rather than asking open-ended.)
10. **Configuration recommendation:** After the user answers Step 9 (or immediately for continuation sessions where scope is known from memory/checkpoint), display a configuration recommendation based on the planned work and `~/.claude/claude-subscription.md`. Format:
    ```
    Recommended config: [Profile] ([Model], [Effort] effort, Thinking [ON/OFF], Fast [ON/OFF])
    Reason: [1 sentence based on planned work scope]
    ```
    If the subscription file does not exist, skip this step. If $ARGUMENTS is provided, include the recommendation in the session report (Step 8) since the scope is already known.

## Notes

- If $ARGUMENTS is provided, skip the "What would you like to work on?" question and start working on that topic directly
- Follow .claude/CLAUDE.md conventions for this project
- Follow the Session Transcript Protocol from DSM_0.2 (append reasoning to .claude/session-transcript.md as the first tool call, not conversation text)
