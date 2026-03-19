# DSM_0.2 Module A: Session Lifecycle

**Parent:** DSM_0.2_Custom_Instructions_v1.1.md
**Loaded:** On demand, when the agent needs a protocol from this module
**Reference:** Module Dispatch Table in DSM_0.2 core

This module contains session lifecycle protocols: inbox communication,
notifications, feedback tracking, sprint cadence, session management,
and cross-session learning. The agent reads this file via the Read tool
when a protocol listed in the dispatch table is needed.

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

## 2. README Change Notification

When a project's `README.md` is updated (content changes, not just formatting),
send inbox entries to notify downstream consumers. The `/dsm-wrap-up` skill
automates this check at session end; this section defines the notification
targets and format.

**Notification targets by project type:**

| Project type | Notify portfolio? | Notify DSM Central? |
|-------------|:-:|:-:|
| DSM Central | Yes | N/A (is DSM Central) |
| Spoke project | Yes | Yes |
| External contribution | Yes | Yes |

**Portfolio target:** `{portfolio-path}/_inbox/{this-project-name}.md` (resolved from Ecosystem Path Registry; logical name: `portfolio`)

**DSM Central target:** `{dsm-central-path}/_inbox/{this-project-name}.md`

**Entry format (same for both targets):**
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
Both writes are required. (Observed gap: portfolio S44, where feedback was
saved to auto-memory but not to `dsm-docs/feedback-to-dsm/`, skipping the Central pipeline.)

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

When a human needs to orchestrate multiple concurrent AI sessions on independent
tasks within the same repository, parallel sessions provide isolation. Each
parallel session operates on its own Level 3 git branch (type: parallel-session,
see DSM_0.2 Three-Level Branching Strategy) with all output confined to a
dedicated staging folder. The main session retains exclusive control over shared
files, memory, inbox, and session transcripts.

**Commands:** `/dsm-parallel-session-go` (start) and `/dsm-parallel-session-wrap-up` (end).

**When to use:** Short, isolated evaluation tasks: research collection, document
assessment, artifact generation, BL drafting. Parallel sessions are not full
sprints; they produce artifacts that the main session reviews and distributes.

**Lifecycle:**

```
main session running -> user opens new Claude Code instance
  -> /dsm-parallel-session-go {task} -> creates parallel/{descriptor} branch
  -> work (all output to BL staging folder)
  -> /dsm-parallel-session-wrap-up -> merge to session branch (Level 2), delete branch
main session picks up merged artifacts
```

**Isolation rules:**

| Allowed (parallel session) | Prohibited (main session only) |
|---------------------------|-------------------------------|
| Create files in BL staging folder | Modify MEMORY.md |
| Read MEMORY.md, CLAUDE.md | Modify session transcript |
| Read any repo file | Process inbox entries |
| Create new files in isolated subfolders | Edit shared/central files |
| Commit on parallel branch | Push feedback to DSM Central |

**Shared file identification:** At session start, the parallel session reads
`.claude/CLAUDE.md` to identify files that serve as project-wide references
(READMEs, config files, trackers, profile documents, source-of-truth files).
These are off-limits. If the work scope expands to require shared file edits,
the parallel session stops and defers to the main session.

**Safety checks (before creating branch):**
1. No uncommitted changes overlapping with planned work scope
2. No existing `parallel/*` branch targeting the same folder or topic
3. Planned work does not require shared file modifications

**BL staging folder:** `dsm-docs/plans/BL-{NNN}-{descriptor}/` contains all generated
artifacts. The folder includes a README.md tracking task description, status, and
artifact list. The main session reviews this folder after merge and distributes
artifacts to their proper locations.

**Merge strategy:** Wrap-up attempts fast-forward merge to main. If conflicts
arise, the merge is aborted, the branch is preserved, and the main session
resolves conflicts manually.

**What parallel sessions skip:**

| Skipped | Reason |
|---------|--------|
| Session transcript | Avoids concurrent writes to shared file |
| MEMORY.md writes | Main session owns memory lifecycle |
| Inbox processing | Avoids duplicate processing |
| Reasoning lessons | Main session handles extraction |
| Feedback push | Main session handles DSM Central communication |
| Ecosystem path validation | Unnecessary for isolated tasks |

**Anti-Patterns:**

**DO NOT:**
- Use parallel sessions for full sprint work; they are for short, isolated tasks
- Modify files outside the BL staging folder (except new files in isolated subfolders)
- Process inbox entries or push feedback from a parallel session
- Run multiple parallel sessions targeting the same topic or folder
- Treat parallel session output as final; the main session must review and distribute

Reference: BACKLOG-220

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
