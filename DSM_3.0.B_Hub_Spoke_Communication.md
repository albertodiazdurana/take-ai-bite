# DSM_3 Implementation Guide - Module B: Hub-Spoke Communication Protocols

DSM uses a hub-and-spoke model, a distribution pattern originating from
transportation logistics and widely adopted in organizational design, where
DSM Central provides governance and spoke projects execute work. This module
covers the core communication protocols: feedback handover (6.1), project
kickoff (6.2), version propagation (6.3), and the bidirectional inbox (6.4).

## Contents

1. [DSM Project Participation Patterns](#dsm-project-participation-patterns)
2. [Spoke-to-Hub Feedback Handover](#61-spoke-to-hub-feedback-handover)
3. [Hub-to-Spoke Project Kickoff](#62-hub-to-spoke-project-kickoff)
4. [DSM Version Propagation Protocol](#63-dsm-version-propagation-protocol)
5. [Bidirectional Project Inbox](#64-bidirectional-project-inbox)

---

## 6. Project Handover Protocols

This is the hub-spoke communication module. For external contributions, see
Module C. For project initialization patterns, see Modules E and F.

### DSM Project Participation Patterns

Every DSM project follows one of three participation patterns. The pattern
governs git configuration, communication with DSM Central, and isolation
rules. The DSM track (Notebook, Application, Hybrid, Documentation) is
orthogonal to the pattern: a Standard Spoke can be a Notebook project;
a Private Project can be Documentation. The agent identifies both dimensions
at session start.

| Property | Standard Spoke | External Contribution | Private Project |
|----------|---------------|----------------------|-----------------|
| Git tracking | Remote (GitHub) | Fork of upstream | Local only |
| Registry visibility | DSM_3 Section 7 | DSM_3 Section 7 | Gitignored locally only |
| Inbox direction | Bidirectional | Via governance folder | Receive only |
| Feedback push | Automatic | Via governance folder | Manual (sanitized) |
| README notifications | Yes | No (milestone notifications) | No |
| Cross-repo writes | Yes | Governance folder only | Minimal inbox only |
| CLAUDE.md location | Project `.claude/` | Project `.claude/` (excluded from upstream) | Project `.claude/` |
| Pattern reference | Section 6.9 | Section 6.6 | Section 6.8 |

**When to use each pattern:**
- **Standard Spoke:** New project created under DSM governance, tracked on GitHub, participates fully in the ecosystem feedback loop.
- **External Contribution:** Contributing to an upstream project you do not own; governance artifacts live in DSM Central, not in the external repo.
- **Private Project:** Personal or sensitive work (financial records, medical data, private research) where content must not leave the local machine.

### 6.1. Spoke-to-Hub Feedback Handover

When a spoke project completes, its feedback files need to be reviewed and
integrated into DSM. Use this standardized handover process.

#### 6.1.1. Spoke Feedback Handover Prompt Template

Copy this prompt and customize the bracketed sections. Use it in a DSM Central
session to trigger feedback review:

```
Review project feedback at ~/[project-name]/dsm-docs/feedback-to-dsm/:
- methodology.md ([N] scored entries, avg [X.X]/5, [M] gaps identified)
- backlogs.md ([N] backlog proposals, [M] medium / [L] low priority)

For each backlog proposal in backlogs.md:
- Accept: create BACKLOG-XXX in plan/backlog/improvements/ or developments/
- Reject: note why (already addressed, out of scope, or insufficient evidence)
- Defer: note dependency or prerequisite

For methodology.md scores below 3:
- Assess whether a DSM improvement is warranted
- Cross-reference with existing backlog items to avoid duplicates

Project context: [1-2 sentence summary of project type, duration, and key outcomes]
```

#### 6.1.2. Spoke Feedback Handover Checklist

Before handing off feedback, verify in the spoke project:

| Check | Description |
|-------|-------------|
| Files exist | `dsm-docs/feedback-to-dsm/methodology.md` and `backlogs.md` present |
| Scores complete | All used DSM sections scored (1-5 scale) |
| Proposals structured | Each backlog proposal has Problem, Proposed Solution, Evidence |
| Summary metrics | Entry count, average score, gap count included |
| Blog separated | Blog materials in `dsm-docs/blog/`, not in `dsm-docs/feedback-to-dsm/` |

#### 6.1.3. DSM Central Feedback Review Process

In the DSM Central session, the review follows this sequence:

1. **Read** all feedback files from the spoke project path
2. **Triage** backlog proposals: accept, reject, or defer each
3. **Create** accepted proposals as BACKLOG-XXX items
4. **Assess** methodology scores below 3 for DSM improvements
5. **Update** CHANGELOG and version if changes were made
6. **Commit** with reference to the source project

Cross-reference: Section 6.4.5 (Project Feedback Deliverables), DSM_0.2 Custom
Instructions (CLAUDE.md Configuration)

### 6.2. Hub-to-Spoke Project Kickoff

When DSM Central initiates a new spoke project, use this standardized kickoff
process. The hub provides governance and direction (scope, scaffolding, research
prompts); the spoke owns execution planning (sprint plans, daily work).

Principle: the entity that knows the standard should create the initial structure.

#### 6.2.1. Hub Preliminary Scope Template

Create this in the DSM Central session before handing off to the spoke:

```
# [Project Name] - Preliminary Scope

## Goals
- [Primary objective]
- [Secondary objectives]

## Success Criteria
- Quantitative: [measurable targets]
- Qualitative: [quality standards]
- Technical: [technical requirements]

## Constraints and Dependencies
- Timeline: [estimated duration, sprint count]
- Time budget: [available hours per deliverable; forces realistic scoping]
- Data: [data sources, access requirements]
- Technical: [required libraries, APIs, infrastructure]

## DSM Track
- [ ] Notebook (DSM 1.0)
- [ ] Application (DSM 4.0)
- [ ] Hybrid (DSM 1.0 + 4.0)

## Phase 0.5 Research (if applicable)
- Research questions: [what needs investigation before sprint planning]
- Expected deliverable: dsm-docs/research/{topic}_research.md
- Skip criteria: [why research may not be needed]

## Protocols to Reinforce in CLAUDE.md
- [ ] Notebook Collaboration Protocol (DSM 1.0/Hybrid)
- [ ] App Development Protocol (DSM 4.0)
- [ ] Pre-Generation Brief Protocol (all)
- [ ] [Project-specific protocols]
```

#### 6.2.2. Hub Scaffolding Artifact Checklist

The hub creates these artifacts before the spoke session begins:

| Artifact | Location | Notes |
|----------|----------|-------|
| CLAUDE.md | `.claude/CLAUDE.md` | With `@` reference to DSM_0.2 and protocol reinforcement |
| Feedback files | `dsm-docs/feedback-to-dsm/` | `methodology.md` and `backlogs.md` (2 files) |
| Decision log | `dsm-docs/decisions/` | Initialized with DEC-000 template |
| Blog directory | `dsm-docs/blog/` | Empty directory for sprint journal entries |
| Research directory | `dsm-docs/research/` | If Phase 0.5 applies |
| Sprint plan location | `dsm-docs/plans/` | Directory ready for spoke to create sprint plan |
| Inbox directory | `_inbox/` | For hub-to-spoke action items (see Section 6.4) |
| Handoffs directory | `dsm-docs/handoffs/` | Session continuity documents |
| Checkpoints directory | `dsm-docs/checkpoints/` | Milestone snapshots |

Use canonical folder names from DSM_0.1. Before creating any folder, check if a
similar folder already exists (e.g., `plan/` when creating `plans/`) to avoid
duplicates.

Cross-reference: Gateway 1 criteria (DSM_1.0 Section 6.5.2) for validation.

#### 6.2.3. Spoke Kickoff Prompt Template

Use this prompt to start the spoke project's first session:

```
This is a new DSM project. Preliminary scope and scaffolding have been
prepared by DSM Central.

Read the CLAUDE.md for project configuration and protocol reinforcement.

Preliminary scope: [path or inline summary]

Phase 0.5 research questions (if applicable):
- [question 1]
- [question 2]

First task: [Phase 0.5 research | Sprint 1 planning | specific starting point]

Governance notes:
- Feedback files initialized in dsm-docs/feedback-to-dsm/ (methodology.md, backlogs.md)
- Blog materials go in dsm-docs/blog/ (not dsm-docs/feedback-to-dsm/)
- Decision log initialized in dsm-docs/decisions/
- Sprint boundary checklist: checkpoint, feedback, decision log, blog entry, README
```

### 6.3. DSM Version Propagation Protocol

Spoke projects inherit DSM protocols through the `@DSM_0.2` reference in their
CLAUDE.md. When DSM Central is updated, spoke agents detect changes through two
mechanisms:

**Immediate detection (session start):** The version header at the top of DSM_0.2
is visible to agents via the `@` reference. Agents compare it against the version
recorded in their most recent handoff document.

**Handoff tracking (session end):** Each handoff records the DSM version active
during that session (DSM_1.0 Section 6.1.2 template). This creates a version trail
that the next session can reference.

**When versions differ:** The agent notes the delta, checks the DSM CHANGELOG for
relevant changes, and applies updated protocols. No manual spoke CLAUDE.md updates
are needed; the `@` reference always reads the latest DSM_0.2.

Cross-reference: DSM_0.2 (Session-Start Version Check), DSM_1.0 Section 6.1.2
(Handoff Template)

### 6.4. Bidirectional Project Inbox

Sections 6.1 and 6.2 handle batch handovers (project end feedback, project start
kickoff). The inbox pattern handles ongoing communication between hub and spoke
during active work, with a defined lifecycle: write, process, remove.

#### 6.4.1. Inbox Architecture and Layout

**Hub inbox** (`_inbox/` at project root in DSM Central):
- One file per spoke project: `{project-name}.md`
- Contains entries pushed by spokes when observations are ripe
- Hub processes entries at session start, then removes them

**Spoke inbox** (`_inbox/` at project root in spoke projects):
- Single file: `from-hub.md`
- Contains action items, notifications, or guidance from DSM Central
- Spoke processes entries at session start, then removes them

**Relationship to feedback files:** Spoke `dsm-docs/feedback-to-dsm/` files (backlogs.md,
methodology.md) remain as a drafting space where observations accumulate over
multiple sessions. The inbox handles entries that are ripe and need attention.
Feedback files are for collecting; the inbox is for transmitting.

#### 6.4.2. Inbox Entry Format Template

Each inbox entry uses this structure:

```markdown
### [YYYY-MM-DD] Entry title

**Type:** Backlog Proposal | Methodology Observation | Action Item | Notification
**Priority:** High | Medium | Low
**Source:** [project name or "DSM Central"]

[Description: problem statement, proposed solution, or action requested]
```

#### 6.4.3. Inbox Entry Processing Lifecycle

The inbox is a transit point, not a permanent record. Entries are written,
processed, and removed:

1. **Write:** Author creates an entry in the target inbox file
2. **Surface:** At session start, the agent reads inbox and presents pending entries
3. **Process:** For each entry, take action:
   - Backlog Proposal: create BACKLOG-XXX item (accept), note reason (reject/defer)
   - Methodology Observation: assess, create improvement if warranted
   - Action Item: defer with rationale, reject with reason, or implement.
     When implementation involves creating, modifying, or deleting files with
     substantive content (code, documentation, configuration), create a BL first
     and follow the standard BL workflow (plan -> branch -> test -> merge).
     Direct implementation without a BL is reserved for trivial actions:
     acknowledging a notification, moving a file, updating a single value.
   - Notification: acknowledge and apply
4. **Remove:** Move processed entries to `_inbox/done/`. Do not delete them;
   processed entries in `done/` preserve communication history and traceability.

Permanent records of processing outcomes live in the backlog system, CHANGELOG,
decision logs, and `_inbox/done/`, not in the active inbox.

#### 6.4.4. Spoke-to-Hub Inbox Communication Flow

**When to push (ripe criteria):**
- Backlog proposals: has Problem, Proposed Solution, and Evidence sections
- Methodology feedback: concrete gap identified with score and context
- Cross-project observation: pattern or issue that affects multiple projects

**Pushing process:**
1. At session end, review `dsm-docs/feedback-to-dsm/` for ripe entries
2. Copy ripe entries to DSM Central's `_inbox/{project-name}.md`
3. Remove or mark the source entry in `dsm-docs/feedback-to-dsm/` as "Pushed to hub"

**Hub processing:**
1. At session start, check `_inbox/` for unprocessed files
2. For each entry, read the source spoke's `dsm-docs/feedback-to-dsm/` files (methodology.md,
   backlogs.md) to extract full context; the inbox entry is a summary, the feedback
   file has the detailed rationale and evidence
3. Process each entry per Section 6.4.3 using the full context
4. Clear processed entries from inbox

#### 6.4.5. Hub-to-Spoke Inbox Communication Flow

**When to send:**
- DSM protocol changes that require spoke action
- Requested improvements or fixes for a specific project
- Feedback on spoke's proposals (accept/reject/defer decisions)

**Sending process:**
1. Write entry to spoke's `_inbox/from-hub.md`
2. Entry is surfaced at spoke's next session start

**Spoke processing:**
1. At session start, check `_inbox/from-hub.md`
2. Process each entry per Section 6.4.3
3. Clear processed entries

#### Inbox Communication Anti-Patterns

**DO NOT:**
- Use the inbox as a drafting space; draft in `dsm-docs/feedback-to-dsm/`, push when ripe
- Leave processed entries in the inbox; the inbox is a transit point, not an archive
- Push entries without the required structure (type, priority, description); unstructured entries cannot be triaged
- Skip surfacing inbox entries at session start; unseen entries defeat the purpose

Cross-reference: Section 6.1 (Spoke-to-Hub Feedback), Section 6.2 (Hub-to-Spoke
Kickoff), DSM_0.2 (Feedback Tracking, Session-Start Version Check)

#### 6.4.6. Breaking Change Spoke Notification

When DSM_0.2 introduces a breaking change (new mandatory protocol, modified protocol
behavior, or removed protocol), DSM Central uses the Hub-to-Spoke Flow (6.4.5) to
notify all affected projects. This subsection defines the spoke-side handling.

**Spoke action on receiving a breaking change notification:**

1. Read the notification to understand what changed
2. Update the Protocol Applicability table in `.claude/CLAUDE.md`:
   - Add the new protocol with `Yes`, `No`, or `Partially` and a rationale
   - If the protocol does not apply, document why (e.g., "No notebooks in this project")
3. Delete the inbox entry after updating the table

**Grace period enforcement (agent behavior):**

The Session-Start Version Check (DSM_0.2) detects version changes between sessions.
When a version change includes a breaking change and the spoke's Protocol Applicability
table has not been updated, the agent must:

1. Identify protocols added or modified in the version gap (from CHANGELOG)
2. Check whether each protocol appears in the spoke's Protocol Applicability table
3. For any missing protocol, surface the gap to the user before executing:
   "Protocol {name} was added/modified in vX.Y.Z but is not listed in your Protocol
   Applicability table. Apply, skip, or defer?"
4. Record the user's decision in the session transcript
5. Never execute an unlisted protocol silently

**Why this matters:** Without this gate, new protocols run in spoke projects without
the human having declared whether they apply. This violates the principle that the
human understands first, reviews second, approves third (DSM_6.0 Principle 1).

#### Breaking Change Notification Anti-Patterns

**DO NOT:**
- Execute a new protocol in a spoke without checking the Protocol Applicability table
- Assume all DSM protocols apply to all projects; each spoke declares applicability
- Skip the notification because "the spoke will see the version change anyway"; the
  notification provides context the CHANGELOG alone may not convey

---

**Parent document:** `DSM_3.0_Methodology_Implementation_Guide_v1.1.md`
