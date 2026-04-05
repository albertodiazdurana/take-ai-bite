# DSM_0.2 Module A: Session Lifecycle

**Parent:** DSM_0.2_Custom_Instructions_v1.1.md
**Loaded:** On demand, when the agent needs a protocol from this module
**Reference:** Module Dispatch Table in DSM_0.2 core

This module contains session lifecycle protocols: inbox communication,
notifications, feedback tracking, sprint cadence, session management,
and cross-session learning. It also hosts session-start protocols (§17-20)
and context management protocols (§21-22) moved from the core to reduce
always-loaded context. The agent reads this file via the Read tool when a
protocol listed in the dispatch table is needed.

---

## Contents

1. [Session-End Inbox Push](#1-session-end-inbox-push)
2. [README and Feature Timeline Change Notification](#2-readme-and-feature-timeline-change-notification)
3. [External Contribution Milestone Notification](#3-external-contribution-milestone-notification)
4. [DSM Feedback Tracking](#4-dsm-feedback-tracking)
5. [Technical Progress Reporting](#5-technical-progress-reporting)
6. [Lightweight Session Lifecycle](#6-lightweight-session-lifecycle)
7. [Parallel Session Protocol](#7-parallel-session-protocol)
8. [Reasoning Lessons Protocol](#8-reasoning-lessons-protocol)
9. [Continuous Learning Protocol](#9-continuous-learning-protocol)
10. [Artifact Lifecycle Management](#10-artifact-lifecycle-management)
11. [Sprint Cadence and Feedback Boundaries](#11-sprint-cadence-and-feedback-boundaries)
12. [Session Delivery Budget](#12-session-delivery-budget)
13. [Mechanical vs Decision Edits](#13-mechanical-vs-decision-edits)
14. [Session Configuration Recommendation](#14-session-configuration-recommendation)
15. [Responsible Collaboration Timer](#15-responsible-collaboration-timer)
16. [GitHub Issue Intake Protocol](#16-github-issue-intake-protocol)
17. [Project Type Detection](#17-project-type-detection)
18. [Session-Start Version Check](#18-session-start-version-check)
19. [Session-Start Inbox Check](#19-session-start-inbox-check)
20. [Session-Start GitHub Issue Check](#20-session-start-github-issue-check)
21. [Context Budget Protocol](#21-context-budget-protocol)
22. [Two-Pass Reading Strategy for Long Structured Files](#22-two-pass-reading-strategy-for-long-structured-files)
23. [CLAUDE.md Section Completeness Gate for New Projects](#23-claudemd-section-completeness-gate-for-new-projects)
24. [Sprint Plan Cross-Reference Before Completion](#24-sprint-plan-cross-reference-before-completion)

---

## 1. Session-End Inbox Push

At session end (or at sprint boundaries), review `dsm-docs/feedback-to-dsm/` for per-session
feedback files that are ripe enough to send to DSM Central. A file is ripe when
its content is actionable:

**Ripe criteria:**
- Backlog proposals: has Problem, Proposed Solution, and Evidence sections
- Methodology feedback: concrete gap identified with score and context
- Cross-project observation: pattern or issue that affects multiple projects

**Pushing process:**
1. For each ripe per-session file, write a notification to DSM Central's inbox:
   `{dsm-central-path}/_inbox/{date}_{this-project-name}_{content}.md`
   (e.g., `2026-03-17_dsm-graph-explorer_feedback-entries-46-47.md`)
2. **Path validation:** Before writing, verify the resolved target path is DSM
   Central's inbox, not the project's own governance inbox. If the resolved path
   contains the current project name as a subdirectory (e.g.,
   `contributions-docs/{project}/_inbox/`), the path is wrong; resolve
   `dsm-central` from the Ecosystem Path Registry or the `@` reference.
3. Files that are not yet ripe stay in `dsm-docs/feedback-to-dsm/` for further drafting
4. After DSM Central processes the feedback, the source file moves to
   `dsm-docs/feedback-to-dsm/done/`

The DSM Central repo path is the parent directory of the
`DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@` import in this
project's CLAUDE.md.

**Immediate push:** When a feedback file is written directly in final form
(structured, actionable, meets ripe criteria), write it to both the local
per-session file and DSM Central's inbox simultaneously:

- Methodology observations: `dsm-docs/feedback-to-dsm/YYYY-MM-DD_sN_methodology.md` + inbox
- Backlog proposals: `dsm-docs/feedback-to-dsm/YYYY-MM-DD_sN_backlogs.md` + inbox

Reserve the session-end review for rough notes that need structuring before
they are ripe.

**External Contribution exception:** For External Contribution projects, the
agent works in the fork, which does not have `dsm-docs/feedback-to-dsm/`. Feedback files
live in the governance folder: `{contributions-docs-path}/{project}/dsm-docs/feedback-to-dsm/`.
All references to `dsm-docs/feedback-to-dsm/` in this section resolve to that governance
path, not the fork's root. The pushing process, immediate push, and ripe criteria
apply identically; only the file location changes.

**Roles (feedback file vs inbox entry):** The per-session feedback file is the
**source of truth**: it contains the full evidence, verbatim quotes, and
structured analysis. The inbox entry is a **notification**: it summarizes what
was observed and points to the feedback file for the complete record. Never place
primary evidence in the inbox alone; the inbox is transient and entries are
deleted after processing.

**Anti-Patterns:**

**DO NOT:**
- Push files that lack structure (no problem statement, no direction); they cannot be triaged
- Push every observation; only push files that are ready for action
- Skip pushing at session end; ripe files that stay local lose timeliness
- Push to inbox without also writing to the local feedback file; both destinations are required per the Immediate push rule
- Overwrite an existing inbox file; the receiving project may not have processed earlier entries. Always **append** new entries to the existing file rather than replacing its contents

---

## 2. README and Feature Timeline Change Notification

When a project's `README.md` or `FEATURES.md` is updated (content changes, not
just formatting), send inbox entries to notify downstream consumers. The
`/dsm-wrap-up` skill automates this check at session end; this section defines
the notification targets and format.

**Notification targets by project type:**

| Project type | Notify portfolio? | Notify DSM Central? | Notify blog-poster? |
|-------------|:-:|:-:|:-:|
| DSM Central | Yes | N/A (is DSM Central) | On new F-entries |
| Spoke project | Yes | Yes | On new F-entries |
| External contribution | Yes | Yes | No |

**Portfolio target:** `{portfolio-path}/_inbox/{this-project-name}.md` (resolved from Ecosystem Path Registry; logical name: `portfolio`)

**DSM Central target:** `{dsm-central-path}/_inbox/{this-project-name}.md`

**Blog-poster target:** `{blog-poster-path}/_inbox/{this-project-name}.md` (resolved from Ecosystem Path Registry; logical name: `blog-poster`)

**Blog-poster notification trigger:** Only when `FEATURES.md` receives new F-entries (not on README changes, formatting, or non-feature updates). The entry tells blog-poster to: (1) update the feature blog with the new capability, and (2) write and post a dedicated blog about the new feature.

**Blog-poster entry format:**
```
### [YYYY-MM-DD] New feature in {project name}: {feature short title}

**Type:** Action Item
**Priority:** Medium
**Source:** {project name}

FEATURES.md was updated with new user-facing capabilities. Actions:
1. Update the feature blog to include the new F-entries
2. Write and post a dedicated blog about the new feature(s)

**New F-entries:**
[List each new F-entry exactly as it appears in FEATURES.md]

**Context:**
[One-sentence description of what the feature does and why it matters]

**Source file:** `~/{project-path}/FEATURES.md`
```

**Entry format for README/FEATURES notifications (portfolio and DSM Central targets):**
```
### [YYYY-MM-DD] README updated in {project name}

**Type:** Action Item
**Priority:** Medium
**Source:** {project name}

README.md was updated. Update the following files to reflect the changes:
- `{portfolio-path}/README.md`
- `{portfolio-path}/landing-page.md`

**What changed:**
[Include the specific text that was added, modified, or removed. The receiver
should be able to act on this entry without reading the full README. For version
bumps, include the old and new version numbers and the "Recent Changes" line.
For structural changes, include the new or removed section headings.]

**Source file:** `~/{project-path}/README.md`
```

**Change detail requirement:** The "What changed" field must be specific enough
that the receiving project can update its files without reading the source
README. Vague summaries like "README updated with latest changes" are not
actionable; include the actual text or a before/after comparison.

**Append rule:** README notifications use the same file-per-project pattern as
inbox pushes. If the target file already exists with unprocessed entries, append
the new entry rather than overwriting (see Session-End Inbox Push anti-patterns).

**Relevance filter (sender-side):** Not every README change warrants a notification.
The sender evaluates the diff before sending:

*Send notification when:*
- Project description, scope, or audience changes
- New projects added or removed from a registry/listing
- External-facing metrics change (line counts, project count, coverage numbers)
- Structural changes (README sections added or removed)
- License, author, or contact information changes

*Skip notification when:*
- Version bumps in "Recent Changes" for internal-only protocol additions
- Internal protocol additions that do not change the external project description
- Date-only updates
- Formatting or typo fixes

When in doubt, send the notification; the cost of an unnecessary evaluation is
lower than the cost of a missed update.

**Applies to:** DSM Central and all spoke projects. The portfolio aggregates
project descriptions; README changes in any project may affect the portfolio's
accuracy. DSM Central tracks spoke README changes for cross-project awareness.

---

## 3. External Contribution Milestone Notification

External contribution projects do not own their upstream README, so README Change
Notifications never fire. Yet the portfolio needs to know about external contribution
activity: new projects onboarded, PRs merged upstream, contribution phase transitions.
This section fills that gap using the same inbox infrastructure.

**Trigger:** At session wrap-up, if the session involved external contribution work
with a notable milestone, send a notification. Notable milestones:
- Project onboarded (DSM governance established, first session complete)
- PR merged upstream
- Contribution phase transition (Phase 1 to Phase 2, etc., per DSM_3 Section 6.6.7)
- Significant PR opened (first contribution, large feature)

**Skip notification when:**
- Session was research-only with no upstream-visible output
- Work was purely governance-internal (feedback files, methodology observations)
- PR was opened but not yet reviewed (notify at merge, not at open, unless it's
  the project's first PR)

**Notification targets:**

| Target | File | Purpose |
|--------|------|---------|
| Portfolio | `{portfolio-path}/_inbox/{project-name}.md` | Update project listings |
| DSM Central | `{dsm-central-path}/_inbox/{project-name}.md` | Cross-project awareness |

**Entry format:**

```
### [YYYY-MM-DD] External contribution milestone: {project name}

**Type:** Notification
**Priority:** Medium
**Source:** {project name}

**Milestone:** {PR merged | Project onboarded | Phase transition}

**Details:**
[Specific description: PR title and URL, what was contributed, upstream
project context. The receiver should be able to update portfolio listings
without reading the full governance folder.]

**Upstream project:** {upstream repo URL}
**Governance:** `{contributions-docs-path}/{project}/`
```

**Append rule:** Same as README Change Notifications. If the target file already
exists with unprocessed entries, append rather than overwrite.

**Relationship to README Change Notification:** README notifications track changes
to DSM-owned project descriptions. Milestone notifications track external
contribution activity where DSM does not own the README. Together they ensure
the portfolio stays current across all project types.

**Applies to:** External contribution projects only. Spoke projects and DSM Central
use README Change Notifications for portfolio updates.

---

## 4. DSM Feedback Tracking

Methodology feedback and backlog proposals use **per-session files** with a
lifecycle. Each session creates its own feedback file(s); processed files move
to `done/`. This prevents accumulation of processed entries in long-lived
append-only files.

**File naming:** `dsm-docs/feedback-to-dsm/YYYY-MM-DD_sN_{type}.md` where type is
`backlogs` or `methodology`. Only create a file when there is feedback to
record; no empty files.

**Lifecycle:**

| Stage | What happens | Who |
|-------|-------------|-----|
| **Create** | Agent writes feedback to a session-scoped file during the session | Agent (spoke) |
| **Notify** | At wrap-up, inbox notification to DSM Central references the file | Agent (spoke) |
| **Process** | DSM Central reads the file, creates BL items or updates scores | Agent (hub) |
| **Done** | Processed file moves to `dsm-docs/feedback-to-dsm/done/` | Agent (hub or spoke) |

**When to capture feedback:**
1. Note which DSM section was referenced (e.g., "Section 2.2", "Appendix B.2")
2. If guidance was particularly helpful or lacking, note for feedback
3. Log gaps or unclear areas encountered
4. Reference: DSM_1.0 Section 6.4 (Checkpoint Protocol)

**Dual-write requirement:** When the agent identifies methodology-relevant
feedback during a session (whether from its own reasoning or from user input),
it must write to `dsm-docs/feedback-to-dsm/` using the per-session file template below,
not only to auto-memory. Auto-memory and `dsm-docs/feedback-to-dsm/` serve different
purposes: auto-memory provides session-local context for the agent;
`dsm-docs/feedback-to-dsm/` feeds the DSM Central governance pipeline via inbox push.
Saving to one but not the other leaves the feedback invisible to either the
agent (if only in `dsm-docs/feedback-to-dsm/`) or the hub (if only in auto-memory).
Both writes are required. (Observed gap: feedback saved to auto-memory but not to `dsm-docs/feedback-to-dsm/`, skipping the Central pipeline.)

**Filing completeness:** Writing a feedback file to `dsm-docs/feedback-to-dsm/` is only
half the action. The file must also be pushed to DSM Central's inbox per the
**Immediate push** rule in Session-End Inbox Push. Filing without notifying is
incomplete; the feedback exists locally but is invisible to the hub. This applies
whether the file is written at session end or mid-session.

**Feedback directory requirements:**

Every project that produces feedback must have:
- `dsm-docs/feedback-to-dsm/README.md` (describes the feedback protocol and file types)
- `dsm-docs/feedback-to-dsm/done/` subdirectory for processed files
- `dsm-docs/feedback-to-dsm/technical.md` (append-only, sprint-boundary cadence; see
  Technical Progress Reporting below)

**Per-session file templates:**

Backlog proposal file (`YYYY-MM-DD_sN_backlogs.md`):

```markdown
# DSM Feedback: Backlog Proposals
**Project:** [project name]
**Session:** [N]
**Date:** [YYYY-MM-DD]

### [Proposal title]
- **DSM Section:** [which section this proposes to change]
- **Problem:** [what gap or issue was encountered]
- **Proposed Solution:** [concrete change proposed]
- **Evidence:** [what happened that motivated this, with session/sprint context]
```

Methodology feedback file (`YYYY-MM-DD_sN_methodology.md`):

```markdown
# DSM Feedback: Methodology Observations
**Project:** [project name]
**Session:** [N]
**Date:** [YYYY-MM-DD]

### Entry: [DSM section name]
- **Date:** [YYYY-MM-DD] | **Sprint:** [N] | **Type:** Success | Gap | Recurrence
- **Context:** [what was being done when the observation occurred]
- **Finding:** [what worked well or what gap was identified]
- **Scores:** Clarity [1-5], Applicability [1-5], Completeness [1-5], Efficiency [1-5] (Avg: [X.XX])
- **Recommendation:** [what should change, if anything]
```

Multiple entries per file are acceptable when they occur in the same session.

**Processing confirmation ("Done" handshake):**

When DSM Central processes a spoke's feedback file:
1. Central creates BL items or integrates observations as needed
2. Central sends an inbox notification to the spoke confirming processing:
   `{spoke-path}/_inbox/{date}_dsm-central_feedback-processed.md`
3. The spoke moves its local feedback file to `dsm-docs/feedback-to-dsm/done/` after
   receiving the confirmation

The spoke never moves files to `done/` without confirmation from Central.
This keeps cross-repo writes limited to inbox entries only.

**Migration from legacy monolithic files:**

Projects with existing append-only feedback files (`methodology.md`,
`backlogs.md`) must migrate before adopting per-session files:

1. **Audit:** DSM Central reads the monolithic files and identifies which
   entries have been processed (mapped to existing BLs) vs unprocessed
2. **Extract:** Unprocessed entries are converted to DSM Central BLs or
   per-session files for processing
3. **Archive:** Move the monolithic files to `dsm-docs/feedback-to-dsm/done/` with a
   `legacy-` prefix (e.g., `legacy-backlogs.md`, `legacy-methodology.md`)
4. **Start fresh:** New sessions create per-session files only

Do not delete the legacy files; they contain historical scoring data and
evidence that may be referenced by existing BLs.

**Anti-Patterns:**

**DO NOT:**
- Mix project-local fixes (template tweaks, workflow adjustments) with DSM methodology proposals in spoke feedback files
- Defer logging a gap or observation; capture it when encountered or it will be forgotten
- File feedback locally without sending an inbox notification to DSM Central; the inbox is what triggers Central to read and act on the feedback
- Use append-only files for backlogs or methodology feedback; use per-session files with the lifecycle above
- Move feedback files to `done/` without confirmation from DSM Central; unconfirmed moves lose unprocessed entries

---

## 5. Technical Progress Reporting

Technical progress reports capture **what was built, how, and why** at sprint
boundaries. They are distinct from methodology feedback (which evaluates DSM
effectiveness) and from handoffs (which ensure session continuity). Technical
reports create a structured record of the actual engineering work across the
ecosystem.

**File:** `dsm-docs/feedback-to-dsm/technical.md` (append-only, dated entries)

This is the third file type in the `dsm-docs/feedback-to-dsm/` directory, alongside
per-session backlog and methodology files. Unlike those per-session files,
`technical.md` is append-only: entries form a chronological engineering record
that retains reference value after pushing. See DSM Feedback Tracking above
for the per-session lifecycle.

**Trigger:** Sprint boundary. The Sprint Boundary Checklist includes "technical
progress report updated" as a standard item.

**Entry template:**

```markdown
### [YYYY-MM-DD] Sprint N: {brief title}

**Phase/Sprint:** {sprint or phase identifier}
**Scope:** {1-sentence summary of what this sprint delivered}

**What was built:**
- {Component/artifact}: {what it does}

**How (techniques and tools):**
| Technique/Tool | Purpose | Notes |
|---------------|---------|-------|
| {e.g., XGBoost} | {e.g., Demand forecasting} | {e.g., 11% RMSE improvement} |

**Data scale:** {row count, feature count, relevant scale indicators}

**Key decisions:** {DEC-NNN references or brief summary}

**Outcomes/metrics:** {quantitative results}

**Profile-relevant:** {new skills exercised, proficiency changes, or "None"}
```

**Routing:** The wrap-up command scans `dsm-docs/feedback-to-dsm/technical.md` for entries
without a `**Pushed:**` date. For each unpushed entry, it appends an inbox
notification to DSM Central and marks the source with `**Pushed:** YYYY-MM-DD`.

**Inbox entry format:**

```markdown
### [YYYY-MM-DD] Technical progress from {project-name}

**Type:** Technical Progress Report
**Priority:** Low
**Source:** {project-name}

Sprint N: {brief title}

**What was built:** {summary}
**Key techniques:** {technique list}
**Scale:** {data scale}
**Outcomes:** {metrics summary}

**Full report:** `~/{project-path}/dsm-docs/feedback-to-dsm/technical.md`
```

**Why Priority: Low?** Technical progress reports are informational, not action
items. They accumulate until a portfolio update cycle or the Context Library
(BL-139) processes them.

**Relationship to other feedback channels:**

| File | Answers | Lifecycle | Consumer | Example |
|------|---------|-----------|----------|---------|
| `YYYY-MM-DD_sN_backlogs.md` | "What should DSM add?" | Per-session -> done/ | DSM Central backlog | "Add a caching protocol" |
| `YYYY-MM-DD_sN_methodology.md` | "How well did DSM work?" | Per-session -> done/ | DSM Central methodology | "Section 2.2 scored 4/5" |
| `technical.md` | "What was built, how, why?" | Append-only + Pushed marker | DSM Central + Portfolio | "Built XGBoost pipeline, 4.8M rows" |

**Anti-Patterns:**

**DO NOT:**
- Mix methodology feedback with technical reports; effectiveness scores go in
  methodology.md, not here
- Include full code listings; reference file paths, not source code
- Report trivial progress (config changes, formatting fixes); report sprint-level
  increments that represent substantive engineering work
- Skip the Profile-relevant field; it triggers the contributor profile update check
  at wrap-up

---

## 6. Lightweight Session Lifecycle

When a session's task is already known (continuation from a previous session) and
context budget is tight, the lightweight lifecycle reduces start and end overhead
by deferring non-essential checks.

**Commands:** `/dsm-light-go` (start) and `/dsm-light-wrap-up` (end).

**Branch behavior:** Lightweight sessions continue on the existing session
branch (Level 2) from the previous session. `/dsm-light-go` does not create a
new session branch; it resumes the current one. If a Level 3 branch was pushed
at the end of the previous session, `/dsm-light-go` checks out that branch
per the Session-Start Branch Resumption Protocol (DSM_0.2 core).

**Lifecycle chain:** The lightweight mode is a closed chain anchored by full
sessions at both ends:

```
full /dsm-go -> work -> /dsm-light-wrap-up -> /dsm-light-go -> work -> ... -> full /dsm-wrap-up
```

**Safety gate:** `/dsm-light-go` checks `.claude/session-baseline.txt` for
`mode: light`. If the marker is absent, it checks for a lightweight checkpoint
from the expected previous session as a fallback (proceeds with a warning). If
neither marker nor checkpoint exists, the agent falls back to full `/dsm-go`.

**What lightweight mode defers:**

| Deferred to next full session | Essential (always runs) |
|-------------------------------|------------------------|
| Inbox check | MEMORY.md read |
| Version check | Latest checkpoint read |
| Reasoning lessons read/extract | Git status |
| Ecosystem path validation | Baseline save |
| Feedback push | Commit + push |
| Bandwidth report | Transcript boundary marker |
| Contributor profile check | Checkpoint (minimal) |

**Thinking step mandate:** Lightweight mode reduces context loading, not reasoning
documentation. The Session Transcript Protocol (thinking-before-acting) is
mandatory in lightweight mode. Both cascading failure incidents observed in spoke
projects (redundant searches, wrong routing, secret leaks) occurred when the
thinking step was skipped under time pressure in light or wrap-up mode. Sessions
that maintained explicit thinking entries had the fewest errors.

**Transcript behavior:** In lightweight mode, the transcript is not archived or
reset. `/dsm-light-go` appends a boundary marker; reasoning accumulates across
the lightweight chain. When a full `/dsm-go` eventually runs, it archives the
accumulated multi-session transcript.

**Deferred items tracking:** The lightweight wrap-up checkpoint includes a
checklist of deferred items. The next full `/dsm-go` processes them as part of
its standard protocol.

Reference: BACKLOG-151

---

## 7. Parallel Session Protocol

Parallel sessions allow multiple concurrent AI sessions to work on independent
tasks within the same repository. All sessions share the Level 2 session branch
(no Level 3 branches, no worktrees). Isolation is enforced through typed session
prefixes, file scope declarations, and a commit booking system.

**Commands:** `/dsm-parallel-session-go` (start) and `/dsm-parallel-session-wrap-up` (end).

**When to use:** Short, isolated tasks: QA validation, document assessment,
scoped BL implementation. Parallel sessions produce artifacts that the main
session reviews and distributes.

**Free-text detection trigger:** When the agent receives a prompt matching
`QA dsm parallel session` or `BL-{NNN} dsm parallel session` (case-insensitive,
with or without colon and task description) but `/dsm-parallel-session-go` was
not explicitly invoked, the agent MUST invoke `/dsm-parallel-session-go` with
the full prompt as `$ARGUMENTS`. Do not process the prompt as a main session
task. This trigger prevents protocol violations (transcript writes, Level 3
branch creation, main-session behavioral patterns) that occur when parallel
session intent is not detected.

### 7.1. Session Types and Mandatory Prompt Prefix

Every parallel session requires a typed prefix in the first prompt. The prefix
serves two purposes: (1) it gates unscoped work, and (2) it generates a
descriptive session name in VS Code's chat history.

| Type | Prompt prefix | Scope | Writes |
|------|--------------|-------|--------|
| QA | `QA dsm parallel session` | Read-only analysis, validation | `.claude/` only (findings, notes) |
| BL | `BL-{NNN} dsm parallel session` | File-scoped edits per BL definition | Files declared in BL scope |

**Guided failure mode:** If `/dsm-parallel-session-go` does not detect a valid
prefix (QA or BL-{NNN}) in the prompt, the agent must:

1. Refuse to proceed with any work
2. Explain the two valid prefix formats with examples:
   ```
   This session requires a typed prefix to proceed. Valid formats:

   For read-only analysis (QA):
     QA dsm parallel session: [describe the validation task]

   For scoped BL implementation:
     dsm parallel session: [describe the implementation task]

   Please start a new session with one of these prefixes.
   ```
3. Wait for the user to provide a correctly prefixed prompt

**Recovery path:** If the user started without a prefix, the simplest recovery
is to close the session and open a new one with the correct prefix. The session
tab name is auto-generated from the first prompt and cannot be changed after
the fact.

### 7.2. Parallel Session Lifecycle

```
main session running -> user opens new Claude Code chat panel in VS Code
  -> types: "QA dsm parallel session: [task]" or "dsm parallel session: [task]"
  -> /dsm-parallel-session-go activates
  -> work (scoped to declared files)
  -> /dsm-parallel-session-wrap-up -> commit on shared session branch
main session picks up committed artifacts
```

All sessions share the same working directory and the same Level 2 session
branch. There are no Level 3 branches and no worktrees.

### 7.3. File Scope Declaration and Enforcement

**Main session responsibilities (before launching a parallel session):**
- Validate file disjointness: no two parallel sessions may edit the same file
- Assign parallel session number (X.Y format, see §7.6)
- Communicate the allowed file list to the parallel session via the prompt

**Parallel session responsibilities (at startup):**
- Read the BL file (for BL type) to confirm scope
- Declare file scope as the first output:
  ```
  This session will only edit: [file list].
  Any edit outside this scope will be refused.
  ```
- Refuse any edit request outside the declared scope
- QA sessions: no tracked file edits; only `.claude/` writes (findings, notes)

**Scope declaration file:** The parallel session writes
`.claude/parallel-session-baseline.txt` with:

```
# Parallel session X.Y baseline
Type: QA | BL-{NNN}
Task: [brief description]
Scope: [list of files to be modified, or "read-only" for QA]
Session branch: [current session branch name]
Created: [timestamp]
```

### 7.4. Commit Window Booking System

Multiple sessions sharing a branch need serialized commits. A lock file
prevents concurrent staging and committing.

**Lock file:** `.claude/commit-lock` (gitignored)

**Booking flow:**
1. Before committing, check `.claude/commit-lock`
2. If absent or stale (>5 minutes old): create lock with
   `{session-id}\n{ISO-timestamp}`
3. If present and fresh: wait 10 seconds, retry (max 3 retries), then warn user
4. Perform `git add` + `git commit` while holding the lock
5. Run `git pull --rebase` before committing if other sessions may have pushed
6. Delete lock file after commit completes

**Stale protection:** If lock timestamp is older than 5 minutes, treat as
orphaned (session crashed). Override with a warning message.

**Branch verification:** Run `git branch --show-current` immediately before
`git add`. If the result does not match the expected session branch, warn the
user and abort (VS Code can silently switch branches).

### 7.5. BL Lifecycle in Parallel Sessions

- Parallel session does **not** move BL to `done/`
- Parallel session updates BL status to: `Implemented by parallel session #X.Y`
- Main session validates the work and moves BL to `done/`
- This separation ensures the main session reviews parallel work before closing

### 7.6. Session Numbering Format

Format: `X.Y` where X is the main session number and Y is the parallel session
sequence number (assigned by the main session at launch time).

Example: Main session 156 launches two parallels:
- 156.1 (QA: validate cross-references)
- 156.2 (BL-271: structural compliance)

### 7.7. Parallel Session Isolation Rules

| Allowed (parallel session) | Prohibited (main session only) |
|---------------------------|-------------------------------|
| Read any repo file | Modify MEMORY.md |
| Edit files in declared scope (BL type) | Modify session transcript |
| Write to `.claude/` (findings, notes) | Process inbox entries |
| Commit on shared session branch (via booking) | Push feedback to DSM Central |
| Read MEMORY.md, CLAUDE.md | Edit files outside declared scope |
| Use `/dsm-parallel-session-wrap-up` | Run `/dsm-wrap-up`, `/dsm-light-wrap-up`, `/dsm-quick-wrap-up` |

### 7.8. BL Number Collision Prevention

Before creating any BL in a parallel session, the agent must:
1. Scan all backlog directories (`plan/backlog/improvements/`,
   `plan/backlog/developments/`, `plan/backlog/done/`, and subdirectories)
   for the highest existing BL number
2. Also check `dsm-docs/plans/` and `dsm-docs/plans/done/`
3. Assign max + 1

This check applies to all sessions but is critical for parallel sessions that
operate in isolation from the main session's numbering state.

### 7.9. What Parallel Sessions Skip

| Skipped | Reason |
|---------|--------|
| Session transcript | Avoids concurrent writes to shared file |
| MEMORY.md writes | Main session owns memory lifecycle |
| Inbox processing | Avoids duplicate processing |
| Reasoning lessons | Main session handles extraction |
| Feedback push | Main session handles DSM Central communication |
| Ecosystem path validation | Unnecessary for isolated tasks |

### 7.10. Parallel Session Anti-Patterns

**DO NOT:**
- Use parallel sessions for full sprint work; they are for short, isolated tasks
- Edit files outside the declared scope
- Process inbox entries or push feedback from a parallel session
- Run multiple parallel sessions targeting the same file
- Treat parallel session output as final; the main session must review
- Create BLs without checking the highest existing number across all directories
- Skip scope declaration or file disjointness verification
- Create Level 3 branches or worktrees for parallel sessions
- Skip the commit booking system when committing
- Invoke main session lifecycle skills (`/dsm-wrap-up`, `/dsm-light-wrap-up`,
  `/dsm-quick-wrap-up`) from a parallel session; these merge, push, and update
  session state, which would break the main session's in-progress work

Reference: BACKLOG-276 (supersedes BACKLOG-220, BACKLOG-243, BACKLOG-272),
BACKLOG-281 (lifecycle skill prohibition)

### 7.11. Parallel Session Guard for Wrap-Up Skills

**Applies to:** `/dsm-wrap-up`, `/dsm-light-wrap-up`, `/dsm-quick-wrap-up`

Before executing any wrap-up skill, check for `.claude/parallel-session-baseline.txt`.
If the file exists and the current context is a parallel session (no session
transcript header was written by this session), refuse execution:

> "Wrap-up skills cannot run from parallel sessions. Use
> `/dsm-parallel-session-wrap-up` to end this parallel session, or switch to
> the main session tab for full wrap-up."

This guard prevents a parallel session from merging the session branch to main,
pushing incomplete work, updating MEMORY.md, or running mirror sync while the
main session has in-progress work.

Reference: BACKLOG-281

---

## 8. Reasoning Lessons Protocol

Session transcripts contain valuable reasoning traces, decision heuristics, and
course corrections that are lost when the transcript is overwritten at the next
session start. This protocol extracts and curates those patterns into a persistent
file that the agent reads at session start, creating cross-session learning.

**File:** `.claude/reasoning-lessons.md` (gitignored, project-local)

**Opt-in:** The protocol activates when `.claude/reasoning-lessons.md` exists in
the project. If the file does not exist, all extraction and reading steps are
skipped silently. To opt in, create the file with a standard header:

```markdown
# Reasoning Lessons

**Reference:** DSM_0.2 Reasoning Lessons Protocol
**Pruning cadence:** Every 5 sessions (next: Session N)
**File size target:** ~50 entry lines (excluding headers and comments)
```

**Extraction modes:**

| Mode | Trigger | Cost | Output |
|------|---------|------|--------|
| `[auto]` | Session wrap-up (automatic) | ~2-5 min | Tactical, session-specific observations |
| `[STAA]` | User runs `/dsm-staa` (manual) | ~15-30 min | Cross-session patterns, generalizations |

`[auto]` captures the data; `[STAA]` performs the analysis. Neither replaces
the other. `[auto]` runs unconditionally at every wrap-up; `[STAA]` runs
selectively when the session warrants deeper analysis.

**Entry format:** `- [{tag}] S{N}: {lesson text}` where N is the session number.
Entries should follow the pattern "When [recognizable trigger], do [specific
action]" to remain actionable.

**STAA guidance:** Run STAA when a session involved complex multi-option decisions,
entered unfamiliar territory, produced a course correction that may recur, or when
auto extraction felt incomplete. Skip for routine sessions. The wrap-up step
outputs a STAA recommendation after each auto extraction.

**Maintenance:**

- **Pruning cadence:** Every 5 sessions, review the file
- **File size target:** ~50 entry lines (excluding headers and comments); if
  exceeded, trigger a prune pass regardless of cadence
- **Prune actions:**
  1. **Promote to memory:** entries reinforced across 3+ sessions graduate to
     MEMORY.md (as Key Patterns or Common Pitfalls) or CLAUDE.md (as protocol
     rules); remove the original after promotion
  2. **Promote to protocol:** entries that represent ecosystem-wide patterns
     (validated across 3+ sessions, applicable beyond the originating project)
     graduate to a formal DSM protocol section (DSM_0.2 module), a DSM 6.0
     principle, or a DSM Vocabulary entry. This is a higher level of promotion
     than memory; it codifies the pattern into the framework itself. Create a
     backlog item for the protocol addition, implement via feature branch, and
     remove the original lesson after the protocol is merged.
  3. **Archive:** session-specific entries for permanently resolved contexts;
     remove
  4. **Consolidate:** entries expressing the same insight from different sessions
     merge into one with session cross-references (e.g., `[+S55]`)

**Relationship to Session Transcript Protocol:** The transcript is the raw data
(ephemeral, overwritten each session, optionally archived to `.claude/transcripts/`).
Reasoning lessons are the curated extract (persistent, accumulating across sessions).
The transcript feeds the lessons; the lessons feed the agent's priming at session start.

### 8.1. Scope Classification

Every reasoning lesson entry carries a scope label that determines whether it
propagates beyond the originating project.

| Scope | Meaning | Redistribution |
|-------|---------|----------------|
| `ecosystem` | Applies to any DSM project | Redistributed to all spokes via DSM Central |
| `pattern` | Applies to projects with same participation pattern or type | Redistributed selectively |
| `project` | Specific to this project's domain | Stays local; reported for pattern detection |

**Entry format with scope:** `- [{tag}] S{N} [{scope}]: {lesson text}`

Example: `- [auto] S12 [ecosystem]: When placing DSM infrastructure, confirm project root before creating files.`

**Management rules:**
- Only `ecosystem` and `pattern` scope lessons get redistributed
- `project` scope lessons are reported in the push notification but not
  redistributed to other spokes
- A `project` lesson recurring independently in 3+ spokes escalates to
  `ecosystem` scope
- Deduplication: if a lesson already exists in DSM Central's aggregation file
  or in a DSM_0.2 protocol, acknowledge in the push notification but do not
  re-add

**When to classify:**
- `[auto]` extraction at wrap-up: the agent assigns a scope based on
  whether the lesson is domain-specific or generalizable
- `[STAA]` analysis: the STAA agent prompts for scope classification
  when writing each lesson (Step 6)

### 8.2. Cross-Project Propagation

Reasoning lessons generated in spoke projects must propagate to DSM Central.
Without propagation, valuable patterns stay siloed in individual projects.

**Mandatory push rule:** At session wrap-up, after extracting reasoning lessons,
the agent checks whether any new lessons were added during this session. If new
lessons exist, push a notification to DSM Central's inbox listing the new
entries with their scope classification.

**Push mechanism:** Uses the Session-End Inbox Push protocol. The notification
goes to `{dsm-central-path}/_inbox/{this-project-name}.md`.

**Inbox entry format:**

```markdown
### [YYYY-MM-DD] Reasoning lessons from {project name} (Session N)

**Type:** Notification
**Priority:** Medium
**Source:** {project name}

New reasoning lessons added via {[auto]/[STAA]} (Session N):

| # | Category | Scope | Lesson |
|---|----------|-------|--------|
| 1 | {category} | {scope} | {lesson text} |

Source file: {project}/.claude/reasoning-lessons.md
```

**Central aggregation file:** `dsm-docs/reasoning-lessons-ecosystem.md` collects
`ecosystem` and `pattern` scope lessons from all spokes, with attribution to
the originating project and session. The agent processes incoming lesson
notifications during DSM Central session-start inbox processing: ecosystem
lessons are added to the aggregation file; pattern lessons are added with a
scope note; project lessons are acknowledged but not added.

**Wrap-up variants:**
- `/dsm-wrap-up`: extract + classify + push (full cycle)
- `/dsm-quick-wrap-up`: extract + classify, defer push (no cross-repo writes)
- `/dsm-light-wrap-up`: defer everything (extraction, classification, push)

**DSM Central sessions:** When processing a lesson notification in the inbox,
the agent:
1. Reads the notification and checks each lesson against the aggregation file
   for duplicates
2. Adds non-duplicate `ecosystem` and `pattern` lessons to
   `dsm-docs/reasoning-lessons-ecosystem.md` with attribution
3. Moves the inbox entry to `_inbox/done/`

**Anti-Patterns:**

**DO NOT:**
- Skip pruning; the file grows monotonically and degrades both signal quality
  (noise) and context budget (size)
- Add generic observations ("be more careful"); entries must be actionable
  with a recognizable trigger and specific action
- Duplicate MEMORY.md content; reasoning lessons capture *how to decide*
  (heuristics, patterns), MEMORY.md captures *what to do* (procedures,
  conventions)
- Run STAA concurrently with a main session; they share `.claude/` files
  and will conflict

---

## 9. Continuous Learning Protocol

DSM evolves through internal experience (session observations, spoke feedback,
reasoning lessons) but does not systematically track external developments in AI
collaboration, AI methodology, or agentic AI patterns. This protocol
adds a lightweight per-session learning step that brings external knowledge into
the ecosystem.

**File:** `dsm-docs/research/learning-log.md` (git-tracked, append-only)

**Opt-in:** The protocol activates when `dsm-docs/research/learning-log.md` exists in
the project. If the file does not exist, all learning steps are skipped silently.
The file includes a topic queue in its header; the agent selects from this queue
when no session-specific topic is apparent.

**Per-session learning step:**

1. **Select:** At session start or end, identify one topic relevant to the session's
   work or to the project's evolution. If no obvious topic, pick from the topic queue
   in the learning log header.
2. **Research:** Brief web search (5-10 minutes equivalent). Find one authoritative
   source: paper, framework update, tool release, or standards revision.
3. **Digest:** Write a 5-10 line summary: what the source says, how it relates to the
   project or DSM, and whether it warrants a backlog item or protocol update.
4. **Store:** Append the digest to the learning log with date, citation (per DSM_0.1
   Citation Standards), and tags for relevant DSM sections.
5. **Act (optional):** If the finding is actionable, create a backlog item or annotate
   an existing one.

**Cadence:**

- **Aspiration:** Every session
- **Minimum:** Every 3 sessions (aligned with sprint boundaries)
- **Skip when:** Session is time-constrained, focused on mechanical work, or context
  budget is tight. Note the skip in the session transcript ("Learning step skipped:
  [reason]") so patterns of skipping become visible.

**Relationship to Reasoning Lessons:** Reasoning Lessons extract *internal* patterns
(how the agent decided, what went wrong, what worked). Continuous Learning brings
*external* input (what others have built, published, or standardized). Both feed
back into DSM through backlog items and protocol updates, but from opposite
directions. Together they form the learning loop: internal reflection + external
awareness.

**Anti-Patterns:**

**DO NOT:**
- Turn the learning step into a literature review; one focused source per session,
  not a survey
- Store raw search results; the log is a curated artifact with digested summaries
- Skip the "Act" evaluation; even if no backlog item results, the assessment of
  relevance is valuable
- Let the topic queue stagnate; add new topics as they emerge from sessions and
  remove topics that have been adequately covered

---

## 10. Artifact Lifecycle Management

DSM projects accumulate artifacts across sessions: transcripts, checkpoints,
backlog items, research files. Without lifecycle rules, directories grow
monotonically. This protocol defines when artifacts transition from active to
archived, and when they can be retired.

**Scope:** This protocol applies to all DSM projects via the `@` reference.
Project-specific artifacts (e.g., DSM Central's backlog done/) are managed in
the project CLAUDE.md, not here.

### 10.1. Transcript Retirement

Session transcripts archive at session start (/dsm-go Step 6.5) and accumulate
in `.claude/transcripts/`. STAA analysis is the intended next step, but it is
selective: not every transcript warrants full analysis. The auto-extraction at
wrap-up already captures tactical reasoning lessons.

**Retirement rule:** At session start, after archiving the previous transcript,
check `.claude/transcripts/` for files older than 10 sessions. For each:

1. If the transcript's wrap-up notes contain "STAA recommended: yes," skip
   retirement (preserve for future analysis)
2. Otherwise, move to `.claude/transcripts/done/` with no further action

The 10-session threshold balances retention (enough time to decide on STAA)
against accumulation (prevents unbounded growth). Projects with fewer sessions
may adjust this threshold in their project CLAUDE.md.

**Cadence:** Per-session, integrated into /dsm-go after Step 6.5.

### 10.2. Checkpoint Supersession

Checkpoints capture milestone state. Once a newer checkpoint covers the same
project scope, the older one is superseded.

**Supersession rule:** When creating a new checkpoint, check
`dsm-docs/checkpoints/` for older checkpoints that:

1. Cover the same project phase or milestone scope
2. Have had their "next steps" acted on (the work they anticipated is complete)

Move superseded checkpoints to `dsm-docs/checkpoints/done/`. Add
`**Superseded by:** {newer checkpoint filename}` to the moved file's header.

**Cadence:** Per-sprint, integrated into the Sprint Boundary Checklist.

### 10.3. Anti-Patterns

**DO NOT:**
- Delete artifacts instead of moving to done/; done/ preserves traceability
  for the Graph Explorer and historical reference
- Retire transcripts flagged for STAA; the flag indicates unrealized value
- Move checkpoints to done/ mechanically by age alone; the supersession
  criterion requires that a newer checkpoint covers the same scope
- Apply backlog done/ conventions from DSM Central to spoke projects; spoke
  backlogs are small enough to remain flat

---

## 11. Sprint Cadence and Feedback Boundaries

Prefer shorter sprints with feedback at each boundary over long monolithic sprints:

- Each sprint should deliver a testable, demonstrable increment
- **Sprint boundary checklist:** checkpoint document, feedback files updated, decision log updated, blog journal entry, README updated, technical progress report updated, superseded checkpoints moved to done/ (see Artifact Lifecycle Management), hub/portfolio notified (see below), alignment review, epoch plan check (see below), next steps summary (3-5 sentences connecting to next sprint)
- **Epoch plan check:** If this sprint completes an epoch (or is the last sprint
  before an epoch boundary), verify: (1) the epoch plan reflects actual outcomes,
  (2) remaining epoch goals are flagged as carried over or dropped, (3) the next
  epoch plan exists or is drafted. If no epoch structure exists in the project,
  skip this step silently.
- **Alignment review (before starting next sprint):** The agent presents a
  summary for user confirmation:
  1. What was completed vs what was planned
  2. Deviations from plan (scope changes, dropped items)
  3. Unplanned additions (work done beyond original scope)
  4. Epoch/phase progress summary
  5. Next sprint scope for confirmation
  The user confirms before the next sprint begins. This ensures the plan
  remains a collaboration artifact, not just documentation.
- **Hub/portfolio notification:** At sprint wrap-up in spoke projects, send a
  sprint completion notification to DSM Central and portfolio via `_inbox/`:
  ```
  ### [YYYY-MM-DD] Sprint completion: {project-name} Sprint N

  **Type:** Sprint Completion Notification
  **Priority:** Low
  **Source:** {project-name}

  **Sprint:** N — {sprint title}
  **Key deliverables:** {bullet list}
  **Next:** Sprint N+1 — {title}
  ```
  Targets: `{dsm-central-path}/_inbox/{project-name}.md` and
  `{portfolio-path}/_inbox/{project-name}.md`. This is a status signal, not a
  duplicate of the technical progress report.
- Split sprints when: original scope has >2 distinct deliverable types, would exceed 3 sessions without feedback, natural delivery boundaries exist
- **Ecosystem alignment request (epoch boundaries):** Before drafting an epoch
  plan, send an alignment request to DSM Central's `_inbox/` with: (1) current
  project state (epoch completed, metrics, capabilities), (2) candidate items for
  next epoch, (3) questions about DSM version changes, proposal adoption, or
  portfolio priorities. This is not a blocking gate; the spoke can begin planning
  immediately but should incorporate hub feedback before the first sprint completes.
  Skip for projects without epoch structure or for the first epoch.
  ```
  ### [YYYY-MM-DD] Ecosystem alignment request: {project-name} Epoch N+1

  **Type:** Alignment Request
  **Priority:** Medium
  **Source:** {project-name}

  **Completed:** Epoch N — {summary}
  **Proposed scope:** {bullet list of candidate items}
  **Questions:** {DSM changes, priority conflicts, resource considerations}
  ```
  Target: `{dsm-central-path}/_inbox/{project-name}.md`
- **Plan notification (after drafting):** After drafting any plan (epoch or
  sprint), send a notification to hub and portfolio `_inbox/` with: plan summary,
  scope table, and pointer to the full plan document. This completes the
  notification loop: alignment request (inbound) → plan draft → plan notification
  (outbound) → execution → sprint completion notification (outbound).
  ```
  ### [YYYY-MM-DD] Plan drafted: {project-name} Epoch N / Sprint N

  **Type:** Plan Notification
  **Priority:** Low
  **Source:** {project-name}

  **Scope:** {2-3 bullet summary with MoSCoW priorities}
  **Full plan:** `dsm-docs/plans/{plan-filename}`
  **Requested action:** Review and flag conflicts before execution starts
  ```
  Targets: `{dsm-central-path}/_inbox/{project-name}.md` and
  `{portfolio-path}/_inbox/{project-name}.md`. Trigger scales with project size:
  epoch plans always notify; sprint plans notify for medium+ projects; micro
  projects skip.

**Anti-Patterns:**

**DO NOT:**
- Create monolithic sprints that span more than 3 sessions without a feedback boundary
- Skip the sprint boundary checklist, even for "small" sprints
- Defer feedback file updates to "later"; update at the boundary or observations are lost

Reference: PM Guidelines Template 8 (Sprint Plan)

---

## 12. Session Delivery Budget

Each session has a finite review budget. When the agent produces more artifacts than the
human can meaningfully review, oversight degrades into passive approval (see DSM_6.0
Principle 1: Take a Bite).

**Guidelines:**
- Estimate the number of new or modified files before starting work
- If the estimate exceeds **5-7 files** or **~500 lines of new content**, split the work
  across sessions
- Count only files requiring human review; mechanical changes (version bumps, date updates)
  do not count against the budget
- When approaching the budget mid-session, pause and ask: continue or defer remaining items?

**Applies across scales:** This budget complements existing micro-level protocols (one cell
at a time in notebooks, one file at a time in app development) by adding a session-level
aggregate constraint. The micro protocols control granularity; the session budget controls
total volume.

**Anti-Patterns:**

**DO NOT:**
- Generate all planned artifacts in one session because "they're related"; related work can
  span sessions with a handoff
- Count the session budget only at the end; estimate at planning time and track as you go
- Treat the budget as a hard cap; it is a review-capacity heuristic, not a rule. Some sessions
  may justify more (mechanical refactors) or fewer (complex architecture) files

Reference: DSM_6.0 Principle 1 (Take a Bite), PM Guidelines Template 8 (Sprint Plan)

---

## 13. Mechanical vs Decision Edits

User approval via the permission window should be reserved for edits where the user's
judgment matters. Mechanical status updates are not decisions.

**Mechanical edits** (batch into fewer tool calls):
- Status markers: "Pushed:", "Status:", completion dates
- Version bumps, date updates, line count refreshes
- Repeated identical changes across multiple entries in one file

**Decision edits** (individual approval, one at a time):
- New content, structural changes, wording choices
- Deletions of substantive material
- Any change where the user might reasonably want to reject or modify

**Guidelines:**
- When updating the same field across multiple entries in a single file, combine
  all changes into one Edit tool call rather than triggering separate approvals
- If a wrap-up or maintenance task involves 5+ mechanical edits to one file,
  consider a single bulk edit over individual changes
- Never mix mechanical and decision edits in the same tool call; the user cannot
  partially approve

**Anti-Patterns:**

**DO NOT:**
- Trigger 10+ approval prompts for identical mechanical updates; this causes approval
  fatigue and degrades oversight quality
- Classify content changes as "mechanical" to avoid approval; when in doubt, treat
  as a decision edit

---

## 14. Session Configuration Recommendation

Claude Code exposes configurable parameters (Model, Effort, Thinking, Fast mode)
that affect reasoning depth, speed, and usage budget consumption. This protocol
ensures each session uses the right configuration for its planned work.

**Subscription file:** `~/.claude/claude-subscription.md` (user-level, global
across all projects). Contains the user's plan type, usage limit structure, and
configuration profiles. All DSM projects read this file; no ecosystem registry
resolution needed.

**First session (no subscription file):** If `~/.claude/claude-subscription.md`
does not exist, ask the user for their Claude plan type (Max, Pro, API) and
create the file. Do not proceed with recommendations until the file exists.

### 14.1. Configuration Profiles

| Profile | Model | Effort | Thinking | Fast | Use when |
|---------|-------|--------|----------|------|----------|
| **Deep** | Opus | Max | Enabled | Off | Complex judgment: scoring, architecture, neutrality audits, novel design |
| **Standard** | Opus | High | Off | Off | Mixed work: implementation + some judgment calls |
| **Efficient** | Opus | Medium | Off | Off | Routine: inbox processing, mechanical edits, status updates |
| **Light** | Opus | Low | Off | Off | Lightweight continuation sessions, context-loading only |

**Fast mode cost warning:** Fast mode is not included in subscription plans
(Pro/Max/Team/Enterprise). It bills directly to extra usage at $30/$150 per
MTok from the first token, bypassing plan rate limits entirely. Only recommend
fast mode when the user explicitly requests speed and accepts the extra usage
cost (e.g., tight deadlines, rapid debugging). Never include fast mode in
default profiles.

**Subagent guidance:** For research reading and codebase exploration, recommend
Sonnet subagents when the user's plan has a separate Sonnet pool (e.g., Max plan).

**Known issue:** Setting effort to "max" via `settings.json` may be silently
downgraded if the user interacts with the `/model` UI during a session
(claude-code#30726). For reliable configuration, use CLI flags or environment
variables instead of `settings.json` when max effort is critical.

### 14.2. When to Display

The recommendation requires knowing the session's scope:

| Scenario | Timing |
|----------|--------|
| User answers "What would you like to work on?" | Immediately after the answer, before starting work |
| Continuation session (scope known from memory/checkpoint) | As part of the session report, since the topic is already known |
| `/dsm-light-go` with known pending work | As part of the lightweight report |
| Mid-session task shift | When the new task type differs from the current profile |

### 14.3. Display Format

**Session start:**

```
Recommended config: [Profile] ([Model], [Effort] effort, Thinking [ON/OFF], Fast [ON/OFF])
Reason: [1 sentence based on planned work scope]
```

**Mid-session shift:**

```
Consider switching to [Profile]: [1 sentence explaining why the new task warrants different settings]
```

### 14.4. Anti-Patterns

**DO NOT:**
- Recommend a configuration before the session scope is known (exception:
  continuation sessions where scope is already determined)
- Skip the mid-session recommendation when task type shifts significantly
  (e.g., from inbox processing to architecture design)
- Hardcode subscription details in project files; always read from the
  user-level file

---

## 15. Responsible Collaboration Timer

DSM_6 Section 1.5 establishes that the agent is responsible for its own resource
consumption. This protocol extends that principle to the human side: long
collaboration sessions degrade human judgment, review rigor, and decision
quality. A responsible collaboration is aware of both participants' limits.

The timer is **advisory, not enforcing**. The user always has final say.

### 15.1. Timer Mechanics

**Start:** The timer begins when `/dsm-go` or `/dsm-light-go` writes the
session-baseline timestamp.

**Cumulative tracking across lightweight chains:** When `/dsm-light-go` starts a
continuation session, calculate cumulative active time from the previous
session-baseline timestamp. Lightweight session chains share a single cumulative
counter.

**Reset condition:** If the gap between the previous session's last activity and
the current session start exceeds 8 hours, reset the cumulative counter to zero.
The previous session's last activity is approximated by the timestamp of its
session-baseline file.

**Threshold and interval:**
- After **10 hours** of cumulative active time, generate a break reminder
- Repeat the reminder every **30 minutes** of continued work
- Track the last reminder time to avoid duplicate reminders within the interval

### 15.2. Reminder Format

Reminders appear in conversation text as a brief, non-blocking note. They do not
require acknowledgment and do not interrupt tool calls or workflow.

```
[Session timer: ~Xh cumulative active time. Consider taking a break.]
```

The reminder is a single line, visually distinct but unobtrusive. It does not
appear in the session transcript (the transcript is for reasoning, not
notifications).

### 15.3. Anti-Patterns

**DO NOT:**
- Block workflow or require acknowledgment before continuing
- Generate reminders more frequently than the configured interval
- Reset the cumulative counter on lightweight session boundaries (only reset
  after the configured gap)
- Treat the timer as a hard limit; the user decides when to stop
- Add the reminder to the session transcript; it belongs in conversation text
  only

---

## 16. GitHub Issue Intake Protocol

GitHub issues filed by external users, community members, or the project owner
have no defined path into the BL system without this protocol. This section
defines the inbound pipeline: how an incoming issue becomes a properly scoped
backlog item with DSM context.

The outbound pipeline (BL -> GitHub issue) is already established in the Change
Tracking Workflow and is not modified here.

### 16.1. Inbound Pipeline (Issue to BL)

When the session-start check (DSM_0.2 core) finds open issues with the
`external` label, process each one:

1. **Read:** Review the issue body and comments for context
2. **Triage:** Determine if the issue is relevant to current DSM scope and
   whether it overlaps with an existing BL
3. **Create BL:** If a new BL is needed, create a BL file with proper DSM
   context (problem, proposal, scope, test plan). Set the Origin field to
   reference the original issue: `Origin: GitHub issue #N by @username`
4. **Create tracking issue:** Create a new GitHub issue from the BL with a
   structured description (BL#, phase, cluster). The new issue references the
   original: "Originated from #N"
5. **Close original:** Close the incoming issue with an attribution comment:
   "Thank you @username. This has been processed into BL-XXX and is tracked
   in #M."
6. **Add to Project:** Add the new tracking issue to the GitHub Project with
   phase and cluster fields

If the issue is absorbed into an existing BL, close the original with a
reference to that BL instead of creating a new one.

### 16.2. Attribution

Issue authors are credited without granting repository access:

| Location | Attribution |
|----------|-------------|
| BL Origin field | `Origin: GitHub issue #N by @username` |
| Closing comment on original issue | Thank you + reference to BL and new issue |
| New tracking issue body | "Originally proposed by @username in #N" |

GitHub's @mention system notifies the author at each step, allowing them to
follow progress without collaborator access.

### 16.3. Label Setup

The `external` label must exist on each repo that uses this protocol. Create it
once per repo:

```
gh label create external --description "Incoming issue for intake triage" --color 0E8A16
```

The label serves as:
- **Triage filter:** `gh issue list --label external --state open` shows
  unprocessed intake
- **Status marker:** open + external = unprocessed; closed + external = processed
- **Traceability:** Label persists after closing, linking back to the intake origin

### 16.4. Anti-Patterns

**DO NOT:**
- Process external issues without creating a BL; the BL provides DSM context
  that raw issues lack
- Skip the attribution comment; issue authors should know their input was
  received and processed
- Remove the `external` label after processing; it preserves traceability
- Create the `external` label on repos that do not use this protocol; the
  session-start check skips repos without the label

---

## 17. Project Type Detection

> **Core reference:** DSM_0.2 §1. Moved here from core to reduce always-loaded context.

At session start, identify the project type by examining the directory structure:

| Indicator | Project Type | DSM Track |
|-----------|--------------|-----------|
| `notebooks/` only, no `src/` | Data Science | DSM 1.0 (Sections 2.1-2.5) |
| `src/`, `tests/`, `app.py` | Application | DSM 4.0 |
| Both `notebooks/` and `src/` | Hybrid | DSM 1.0 for analysis, DSM 4.0 for modules |
| `dsm-docs/`, markdown-only, no `notebooks/` or `src/` | Documentation | DSM 5.0 |
| `{contributions-docs-path}/{project}/` exists | External Contribution | DSM_3 Section 6.6 |

**State the identified type at session start:**
"This appears to be a [Notebook/Application/Hybrid/Documentation/External Contribution] project. I'll follow [DSM 1.0/DSM 4.0/both/DSM 5.0/Section 6.6] accordingly."

**External contribution sessions:** Open the project in the external repo's local
clone but reference governance artifacts in `{contributions-docs-path}/{project}/`
(resolved from the Ecosystem Path Registry). See DSM_3 Section 6.6 for the full
governance structure.

### 17.1. Participation Pattern Detection

The DSM track (above) is orthogonal to the participation pattern. After identifying
the track, also identify which participation pattern governs communication and
isolation rules:

| Indicator | Participation Pattern | Reference |
|-----------|----------------------|-----------|
| Git remote configured + DSM_3 Section 7 entry | Standard Spoke | DSM_3 Section 6.9 |
| `contributions-docs/{project}/` exists or CLAUDE.md declares "External Contribution" | External Contribution | DSM_3 Section 6.6 |
| CLAUDE.md declares "Private" or "DSM private project pattern" | Private Project | DSM_3 Section 6.8 |
| No indicator found | Assume Standard Spoke | DSM_3 Section 6.9 |

**State both dimensions at session start:**
"This is a [track] project ([DSM version]) using the [pattern] pattern."

Example: "This is a Documentation project (DSM 5.0) using the Private Project pattern."

**Pattern governs:** inbox behavior (bidirectional vs receive-only), feedback push
(automatic vs manual), README notifications (yes/no), and cross-repo write scope.
Apply the pattern's constraints for the session, even if CLAUDE.md does not
explicitly override every inherited DSM_0.2 protocol.

---

## 18. Session-Start Version Check

> **Core reference:** DSM_0.2 §2. Moved here from core to reduce always-loaded context.

At session start in spoke projects, compare the DSM version in the header above against the version recorded in the most recent handoff (`dsm-docs/handoffs/`). If the versions differ:
1. Note the update: "DSM updated from vX.Y.Z to vA.B.C since last session"
2. Check the DSM CHANGELOG for changes between those versions
3. Extract any `**Spoke action:**` annotations from new CHANGELOG entries
4. Surface spoke actions to the user, grouped by type
5. Execute spoke actions based on annotation type:
   - `Run /dsm-align`: Ask user to confirm, then execute `/dsm-align` to regenerate the alignment section. This is safe because `/dsm-align` only modifies content between the managed delimiters.
   - `Review [section]`: Surface as an action item for the user. Do not auto-execute; the user decides whether to review now or defer.
   - `Update [file]`: Surface as an action item. Do not auto-execute; the update may require judgment.
6. Apply any updated protocols for this session

If no previous handoff exists (first session), record the current DSM version for future reference.

### 18.1. Spoke Action Annotation Convention

CHANGELOG entries that require action from spoke projects include a
`**Spoke action:**` annotation inline:

```markdown
- §6 renamed, §7 format example updated, §17.1 templates updated
  **Spoke action:** Run `/dsm-align` to update reinforcement block
```

This convention makes the CHANGELOG the broadcast notification channel from
hub to all spokes. Because CHANGELOG is mirrored to distribution repos, it
works in any ecosystem (original DSM Central, TAB forks, or independent hubs).

**Common spoke actions:**

| Annotation | Meaning |
|-----------|---------|
| `Run /dsm-align` | Template change, regenerate alignment section |
| `Review [section]` | Protocol change, manual review needed |
| `Update [file]` | Specific file needs manual update |

Entries without a `**Spoke action:**` annotation require no spoke response.

---

## 19. Session-Start Inbox Check

> **Core reference:** DSM_0.2 §3. Moved here from core to reduce always-loaded context.

At session start, check `_inbox/` for pending entries from DSM Central. If entries
exist, surface them to the user before starting other work. When an entry
references a source file (Full evidence, Full report), read the referenced file
before evaluating the entry; the inbox is a notification, the source file
contains the full evidence needed for decision-making. Process each entry per
DSM_3 Section 6.4.3 (implement via BL workflow for substantive changes, defer, or reject; then move to `_inbox/done/`).

**WARNING:** After processing, **move** the entry to `_inbox/done/`. Do not mark entries as "Status: Processed" or add completion markers while keeping the entry in place. Processed entries in `done/` preserve communication history and traceability; entries left in the inbox root cause stale re-processing in future sessions (observed in spoke project sessions).

**External Contribution exception:** For External Contribution projects (identified
by project type detection or explicit CLAUDE.md declaration), do NOT create `_inbox/`
in the external repo. The external repo belongs to an upstream maintainer; only code
contributions belong there. If an inbox is needed, create it under
`{contributions-docs-path}/{project}/_inbox/`. Skip the migration
confirmation sub-protocol below.

If `_inbox/` does not exist, create it at project root with a `README.md` containing:

```markdown
# Project Inbox

Transit point for hub-spoke communication. Entries arrive, get processed, and
move to `done/`. Reference: DSM_3 Section 6.4.

**Entries are brief notifications, not full file copies.** Each entry summarizes
what was observed and points to the source file for the complete record. Do not
copy full feedback files, methodology documents, or backlog lists into the inbox.

## Entry Template

### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

When creating `_inbox/`, also create the `_inbox/done/` subdirectory for
processed entries.

**Migration:** If `dsm-docs/backlog/` exists (legacy convention), move contents
to `_inbox/` at project root, create the README.md, and remove the old directory.
The canonical inbox location is always `_inbox/` at project root; no other
path (e.g., `dsm-docs/inbox/`) should be used or created.

**Validation before confirmation:** Before sending the migration confirmation
below, verify that:
- The `_inbox/` was created inside the contributor's governance scope (not in
  an external repo)
- The location is consistent with the project CLAUDE.md's governance rules
- For External Contribution projects, the `_inbox/` must be in
  `{contributions-docs-path}/{project}/`, not in the external repo

If validation fails, delete the incorrectly placed `_inbox/` and alert the user.

**Migration confirmation:** After creating or migrating `_inbox/`, send a
confirmation entry to DSM Central's inbox. The DSM Central repo path is the parent
directory of the `DSM_0.2_Custom_Instructions_v1.1.md` file referenced by the `@`
import in this project's CLAUDE.md. Write the confirmation to
`{dsm-central-path}/_inbox/{this-project-name}.md` using the entry template:

```markdown
### [YYYY-MM-DD] Inbox migration confirmed

**Type:** Notification
**Priority:** Low
**Source:** [this project name]

Inbox system initialized. _inbox/ created at project root. README.md with
entry template installed. Ready to receive and send inbox entries per
DSM_3 Section 6.4.
```

---

## 20. Session-Start GitHub Issue Check

> **Core reference:** DSM_0.2 §4. Moved here from core to reduce always-loaded context.

At session start, run three checks to surface unprocessed GitHub issues. If `gh`
is not available, skip all checks silently.

### 20.1. External Issues (Priority Path)

```
gh issue list --label external --state open
```

External-labeled issues come from outside contributors and take priority.

### 20.2. New Issues Since Last Session

```
gh issue list --state open --search "created:>={YYYY-MM-DD}"
```

Replace `{YYYY-MM-DD}` with the date from MEMORY.md's "Latest Session" entry.
This catches user-created issues (ideas, feedback, research items) that lack
the `external` label.

### 20.3. Untriaged Open Issues (Classified)

```
gh issue list --state open
```

Classify the results into two groups, excluding issues already surfaced by 20.1/20.2:

**Research queue** (issues labeled `research`, or whose title starts with
"read repo", "read document", or references an external URL/file to evaluate):
- Present as a batched summary: "Research queue: N items pending"
- List titles with issue numbers, no individual triage needed
- These are knowledge intake tasks, not work items

**Improvement issues** (everything else, excluding issues whose title starts
with "BL-" and issues labeled `deferred`):
- These need individual triage per §20.4

### 20.4. Triage Actions

**For improvement issues,** read the body and comments, then triage:

- **New BL needed:** Follow the GitHub Issue Intake Protocol (Module A, Section 16)
- **Absorbed by existing BL:** Close the issue with a reference to the existing BL
- **Defer:** Apply the `deferred` label with a comment explaining why
- **Not actionable:** Close with explanation

**For research queue items,** no per-item triage at session start. Instead:

- If the session is research-focused, ask the user which items to tackle
- Each selected item becomes a Phase 0.5 research task (see Module D)
- After research is complete, follow §20.5 (Research Output and Action Routing)
- Items stay open in the queue until a session processes them

### 20.5. Research Output and Action Routing

When a research queue item is processed (in any session type, including
parallel sessions), the output must include both findings and an action
recommendation. Without action routing, research files accumulate in
`dsm-docs/research/` without connecting back to the backlog.

**Required output:**

1. Save findings to `dsm-docs/research/{YYYY-MM-DD}_{topic}.md`
2. Include an **Action Recommendation** section at the bottom of the file:
   - **New BL:** [description of proposed backlog item], follow the GitHub
     Issue Intake Protocol (Module A, Section 16) to create it
   - **Enriches BL-NNN:** [what the research adds], update the existing BL
     file with a reference to the research findings
   - **No action:** [why not applicable now], close the issue
3. Close the GitHub issue with a link to the research file
4. If the recommendation is "New BL" or "Enriches BL-NNN" and the current
   session cannot act on it, create an `_inbox/` entry so the next main
   session picks it up

---

## 21. Context Budget Protocol

> **Core reference:** DSM_0.2 §11. Moved here from core to reduce always-loaded context.

The agent's context window is a finite resource. Large file reads and multi-document
research can exhaust it mid-session, forcing compaction and losing earlier reasoning.
This protocol makes context consumption visible and gives the user control.

**Before reading large files (500+ lines):**

Present options to the user:
1. Read the full file (accept context cost)
2. Read targeted sections (specify which parts are needed)
3. Split the file first, then read the relevant fragment (see DSM_0.1 Reference
   File Size Protocol)
4. Defer to a new session with full context available

**Context threshold warning:**

When estimated remaining context drops below ~40%, proactively alert the user:
- State the estimated remaining capacity
- Suggest session wrap-up or scope reduction
- Do not wait for the system warning at 80%; surface the concern early enough
  for the user to make a deliberate choice

**Session planning:**

When a session involves multiple large files or extensive research:
- Estimate total context needs at planning time
- If the estimate suggests the session will approach context limits, scope
  accordingly: prioritize files, defer secondary reads, or plan a continuation
  session

**Anti-Patterns:**

**DO NOT:**
- Read a 2,000-line file without warning the user about context impact
- Wait until compaction is imminent to mention context pressure; by then the
  user has lost the ability to choose a clean wrap-up
- Guess remaining context; use system warnings and file sizes as indicators

---

## 22. Two-Pass Reading Strategy for Long Structured Files

> **Core reference:** DSM_0.2 §12. Moved here from core to reduce always-loaded context.

When the agent needs to read a structured text file of 200+ lines (markdown,
plain text, or converted-to-markdown), use a two-pass approach instead of
sequential chunk reading. Sequential chunks miss items at boundaries and
provide no structural map before diving into content.

**Trigger:** Structured text files of 200+ lines. Non-markdown, non-text files
of any size should be converted to markdown first (see `scripts/convert_to_markdown.py`
in DSM Central), then the protocol applies to the converted output.

**Flow:**

1. **Scope assessment offer:** Agent informs the user: "This file is N lines.
   Would you like a scope assessment to identify sections we could skip?"
2. **User decides:** Y (scope filtering) or N (read everything)
3. **Pass 1 (structural scan):** Agent uses Grep to extract headings, entry
   markers, and structural boundaries in a single tool call. Produces a skeleton:
   section titles, nesting levels, approximate line ranges, item counts per section.
   Patterns by file type:
   - **Markdown:** `^#{1,6}`, `^- \*\*`, numbered lists, table headers
   - **Plain text:** ALL CAPS lines, `===`/`---` underlines, numbered section
     headers (e.g., `1.`, `1.1`), indentation level changes
4. **Scope filtering gate (conditional):** If user said Y at step 2, the agent
   presents the skeleton with recommendations: "Based on [current task], these
   sections appear less relevant: [list with reasons]. Skip them?" User can
   approve all, approve some, or dismiss all. If user said N, skip this step.
5. **Pass 2 (semantic extraction):** Agent reads content of sections that
   survived filtering (or all sections if no filtering). Targeted reads by line
   range, extracting meaning, key data points, and actionable items.

**Integration with Context Budget Protocol:** The two-pass strategy is the
implementation technique for the "targeted sections" option in the Context
Budget Protocol. When that protocol presents options for reading large files,
the two-pass strategy provides the method for identifying which sections to target.

**Does not apply to:** Code files (which have better tooling: Grep, Glob,
language-aware search), files under 200 lines (overhead exceeds benefit),
or files the agent has already read in the current session.

---

## 23. CLAUDE.md Section Completeness Gate for New Projects

> **Origin:** BACKLOG-307. Ensures every project CLAUDE.md is complete before
> implementation begins.

Every project CLAUDE.md must contain four sections before implementation work
starts. This is a hard gate: the agent does not proceed to implementation
until all sections are present and approved.

### 23.1. Required CLAUDE.md Sections

| # | Section | Content | When added |
|---|---------|---------|------------|
| 1 | **DSM_0.2 Alignment** | Managed by `/dsm-align` (existing) | At first `/dsm-go` |
| 2 | **Participation pattern** | Instructions specific to participation pattern (spoke, hub, standalone, contributor, private) | After initial idea is framed and preliminary plan exists |
| 3 | **Project type** | Instructions specific to project type (notebook, hybrid, documentation, app) | After preliminary plan exists (independent from Section 2) |
| 4 | **Project specific** | Project structure, objectives, tech requirements, domain constraints | After research grounds the plan (`dsm-docs/research/`) |

Sections 2-4 each require explicit user approval before being written.

### 23.2. Completeness Check Behavior

**At `/dsm-go` (step 2a.8):** After content validation (step 2a.7), check
whether all 4 sections are present in CLAUDE.md.

- **All 4 present:** Pass silently. No action needed.
- **Section 1 missing:** This indicates `/dsm-align` was not run. Suggest
  running it before continuing.
- **Sections 2-4 missing (new or incomplete project):** Report which sections
  are missing and suggest completing them: "CLAUDE.md is missing sections:
  [list]. Complete these before starting implementation. Next: [suggest next
  section to add based on project state]."

**Detection heuristic:** The agent checks for numbered section headings in
CLAUDE.md. Each section must use an explicit `## N.` heading:

- Section 1: `## 1. DSM_0.2 Alignment` (inside alignment delimiters, managed by `/dsm-align`)
- Section 2: `## 2. Participation Pattern` (outside delimiters, user-managed)
- Section 3: `## 3. Project Type` (outside delimiters, user-managed)
- Section 4: `## 4. Project Specific` (outside delimiters, user-managed)

**Important:** Content inside the alignment delimiters (`<!-- BEGIN/END
DSM_0.2 ALIGNMENT -->`) only counts for Section 1. Participation pattern
and project type mentions in the alignment block do not satisfy Sections
2 and 3. The numbered headings make detection unambiguous and the structure
readable for both agents and humans.

### 23.3. Hard Gate Enforcement

The completeness gate is enforced at the boundary between setup and
implementation. The agent must not begin implementation work (writing code,
creating deliverables, running experiments) while sections are missing.

**What counts as implementation:** Creating code files, writing notebooks,
building application features, running experiments. Research, planning, and
CLAUDE.md completion are not implementation.

**Existing projects:** Projects with a complete CLAUDE.md (all 4 sections
present) pass the gate silently at every session start. The gate only
activates when sections are missing.

**Empty projects or new folders:** Only accept `/dsm-go` as the first command.
Running other DSM commands on an unscaffolded project could interfere with
proper initialization.

### 23.4. Section Completion Workflow

After `/dsm-go` completes and reports missing sections, the agent guides the
user through completion:

1. List remaining sections with their prerequisites
2. Suggest the next section to add based on available context (e.g., if a
   preliminary plan exists in `dsm-docs/research/`, sections 2 and 3 are
   ready to draft)
3. After each section is written and approved, report remaining sections
4. When all 4 are present, confirm: "CLAUDE.md complete. Ready for
   implementation."

Each section follows the Pre-Generation Brief Protocol (Gate 1 concept,
Gate 2 implementation review).

---

## 24. Sprint Plan Cross-Reference Before Completion

> **Origin:** BACKLOG-312. Prevents premature completion declarations by
> requiring the agent to verify deliverables against the sprint plan.

When a project has an active sprint plan, the agent must cross-reference it
before suggesting that a work block or sprint is complete. Relying on
checkpoints, memory, or partial task lists leads to missed deliverables,
unmet gates, and incomplete boundary checklists (observed in spoke project
sessions where the agent declared completion based on a checkpoint's
"What Remains" list while SHOULD deliverables and experiment gates were
still open).

### 24.1. Trigger Conditions

This protocol activates when **both** conditions are true:

1. The project has an active sprint plan (a file in `dsm-docs/plans/` with
   sprint deliverables, or an equivalent planning document)
2. The agent is about to suggest one of:
   - "Ready to wrap up" or equivalent session-end language
   - "Sprint complete" or "all deliverables done"
   - Moving to the next sprint or phase

### 24.2. Cross-Reference Procedure

When triggered, the agent must:

1. **Read the sprint plan file** in full (not from memory or checkpoint
   summaries)
2. **Classify each deliverable** using MoSCoW priority from the plan:

   | Classification | Meaning | Action |
   |---------------|---------|--------|
   | Done | Deliverable complete with evidence (commit, file, output) | Note evidence reference |
   | Deferred | Explicitly moved to a future sprint with reason | Note the reason |
   | Incomplete | Work remains, not yet deferred | List remaining work |
   | Failed gate | Threshold or success criterion not met | Report actual vs target values |

3. **Present the cross-reference** to the user as a summary table before
   proceeding

### 24.3. Completion Gate

The agent must not suggest wrap-up or sprint completion if any of the
following are true:

- A **MUST** deliverable is classified as Incomplete or Failed gate
- A **SHOULD** deliverable is classified as Incomplete without explicit
  user acknowledgment
- The sprint boundary checklist (§11) has unchecked items

The user may override the gate by explicitly acknowledging incomplete items:
"Defer X to next sprint" or "Accept Y as-is." The agent records the
override in the session transcript.

### 24.4. What Counts as Evidence

- **Code deliverable:** Commit hash or file path
- **Documentation:** File exists at expected path
- **Experiment gate:** Metric value vs threshold (e.g., "89.27% < 90% target")
- **Process deliverable:** Artifact exists (checkpoint, feedback file, blog entry)

Do not count "discussed" or "planned" as evidence of completion.

**Anti-Patterns:**

**DO NOT:**
- Rely on checkpoint "What Remains" lists as the source of truth; checkpoints
  are snapshots, the sprint plan is the contract
- Skip SHOULD deliverables when cross-referencing; they are commitments with
  flexibility, not optional items
- Declare a gate passed when the metric is below threshold, regardless of
  how close it is
- Cross-reference from memory; always re-read the plan file
