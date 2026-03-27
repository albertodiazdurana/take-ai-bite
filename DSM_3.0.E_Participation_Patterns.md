# DSM_3.0 Implementation Guide - Module E: Participation Patterns

This module covers the three participation patterns for DSM projects: spoke
initialization (the mechanical setup checklist), the private project pattern
(for sensitive data), and the standard spoke pattern (the default). Use this
module when setting up a new project or determining which pattern applies.

## Contents

1. [Spoke Project Initialization Checklist](#67-spoke-project-initialization-checklist)
2. [Private Project Pattern](#68-private-project-pattern)
3. [Standard Spoke Pattern](#69-standard-spoke-pattern)

---

### 6.7. Spoke Project Initialization Checklist

When initializing a new DSM spoke project, follow this mechanical checklist.
Section 6.2 covers what the hub prepares (preliminary scope, scaffolding
artifacts, kickoff prompt); this section covers the spoke-side setup that
creates a fully functional DSM project ready for its first working session.

For external contribution projects (repos you don't own), use Section 6.6.8
instead. That checklist handles fork setup, governance separation, and
upstream-specific concerns.

#### Prerequisites

- Preliminary scope exists (created per Section 6.2.1)
- Hub scaffolding checklist complete (Section 6.2.2)

#### Checklist

| Step | Action | Location | Reference |
|------|--------|----------|-----------|
| 1 | Initialize git repo | Project root | `git init` |
| 2 | Create `.gitignore` | Project root | Standard DSM exclusions |
| 3 | Create `.claude/CLAUDE.md` with `@` reference | `.claude/` | Section 2 template, DSM_0.2 |
| 4 | Create `.claude/dsm-ecosystem.md` | `.claude/` | DSM_0.2 Ecosystem Path Registry |
| 5 | Create `_inbox/` with README.md | Project root | Section 6.4 entry template |
| 6 | Create `plan/backlog/` with `done/` and README.md | `plan/backlog/` | Spoke Backlog Template below |
| 7 | Create canonical `dsm-docs/` structure | `dsm-docs/` | DSM_0.1 (9 subdirectories) |
| 8 | Move preliminary plan to `dsm-docs/research/` | `dsm-docs/research/` | If exists from hub kickoff |
| 9 | Send first-session prompt to spoke's `_inbox/` | `_inbox/` | See template below |
| 10 | Send inbox confirmation to DSM Central's `_inbox/` | Hub `_inbox/` | DSM_0.2 migration confirmation |
| 11 | Create AI collaboration norms | `dsm-docs/guides/` | See Section 6.7.3 below |
| 12 | Create README.md | Project root | Project name, purpose, setup, structure |
| 13 | Check `~/.claude/CLAUDE.md` for user conventions | `.claude/CLAUDE.md` | Inherit punctuation, formatting, tone preferences |
| 14 | Initial commit | Project root | |

The canonical `dsm-docs/` structure (Step 7) contains 9 subdirectories per DSM_0.1:
`blog/`, `checkpoints/`, `decisions/`, `feedback-to-dsm/`, `guides/`, `handoffs/` (with
`done/`), `inbox/`, `plans/`, `research/`.

#### 6.7.1. First-Session Prompt

Send this as an inbox entry to the spoke's `_inbox/`, not as a handoff document.
It is a hub-to-spoke action item: it arrives, gets processed in the first session,
and gets deleted.

```markdown
### [YYYY-MM-DD] First session: project initialization

**Type:** Action Item
**Priority:** High
**Source:** DSM Central

This is a DSM ecosystem project. Read `.claude/CLAUDE.md` for methodology
and interaction protocols.

Read the preliminary plan in `dsm-docs/research/` to understand the project
goals and initial design direction.

Based on the preliminary plan:
1. Do extensive research to validate and expand on the plan. Document
   findings with citations in `dsm-docs/research/`.
2. Create a project plan in `dsm-docs/plans/` covering scope, phases,
   deliverables, and success criteria.
3. Present the plan for review and approval before starting implementation.
4. Create AI collaboration norms in `dsm-docs/guides/ai-collaboration.md`
   (see DSM_3 Section 6.7.3).
```

#### 6.7.2. CLAUDE.md Essentials

The `.claude/CLAUDE.md` (Step 3) must include at minimum:

- `@` reference to DSM_0.2 Custom Instructions (discovery mechanism for all DSM protocols)
- Project name, domain, and DSM track (Notebook / Application / Hybrid / Documentation)
- Protocol reinforcements per DSM_0.2 CLAUDE.md Configuration table
- Project-specific instructions (data sources, key paths, standards)
- **Multi-deliverable scope:** When a project contains multiple sub-deliverables,
  enumerate all of them with their respective tool stacks, data sources, and DSM
  tracks. The first-session prompt should cross-check the CLAUDE.md against the
  preliminary plan to catch scope mismatches early.
- **DSM_1 methodology references:** The `@` reference imports DSM_0.2 (behavior
  protocols) but not DSM_1 (methodology content). The CLAUDE.md should reference
  or summarize applicable DSM_1 sections so the spoke agent can discover them:
  - Section 2.1 for environment setup (venv, requirements, setup scripts)
  - Section 2.2 for EDA methodology (Three-Layer Framework)
  - Section 2.5 for communication standards

Use the Custom Instructions template in Section 2 as the starting point. See
DSM_0.2's "Protocol Reinforcement Required" table for which protocols to
explicitly restate.

#### 6.7.3. AI Collaboration Norms

As part of project initialization, create `dsm-docs/guides/ai-collaboration.md`
capturing how human-AI collaboration works for this specific project:

- **Protocol applicability:** Which inherited DSM protocols apply, which are
  skipped, and which need adaptation for this domain
- **Human-agent responsibility split:** What the human owns (decisions, domain
  judgment, review) vs. what the agent owns (research, drafting, mechanical tasks)
- **Collaboration mode:** The expected interaction pattern (notebook cell-by-cell,
  app dev file-by-file, research-then-plan, etc.)
- **Project-specific conventions:** Standards not covered by DSM defaults (naming
  conventions, domain terminology, tool preferences)

This document serves two purposes: it primes the agent with project-specific
collaboration expectations at session start, and it gives the human a reference
for what to expect from the agent's behavior.

For external contributions, the equivalent step is assessing the upstream AI
policy (Section 6.6.4) and documenting collaboration approach in the governance
folder (`{contributions-docs-path}/{project}/dsm-docs/guides/ai-collaboration.md`).

#### Anti-Patterns

**DO NOT:**
- Skip the ecosystem path registry (Step 4); without it, cross-repo operations
  (inbox push, feedback handover) silently fail
- Place the first-session prompt in `dsm-docs/handoffs/`; it is a transient action
  item, not a session continuity document
- Copy the full DSM_0.2 protocol list into the AI collaboration norms; reference
  the Protocol Applicability table pattern from Section 6.6.5 and customize for
  the project's context
- Skip the inbox confirmation to DSM Central (Step 9); the hub needs to know the
  spoke's inbox system is operational
- Defer AI collaboration norms to "later"; the first session is when collaboration
  patterns are established, and undocumented patterns drift

#### 6.7.4. DSM Adoption for Existing Projects

When initializing DSM in a project with prior non-DSM sessions, follow this
adoption checklist before the standard initialization (Section 6.7 checklist).

**Pre-existing artifact migration:**

1. Discover: list all non-DSM session artifacts (`context/`, handoffs,
   checkpoints, memory files at project root)
2. Classify and migrate:
   - `context/*.md` or loose handoff files → `dsm-docs/handoffs/done/` with
     `**Consumed at:** DSM adoption (YYYY-MM-DD)` annotation
   - Checkpoint files at root → `dsm-docs/checkpoints/done/` with consumed annotation
   - Agent-created memory files (e.g., `memody.md`) → extract key user
     preferences into CLAUDE.md, then archive the source file in place
3. Preserve all originals; they are the user's pre-DSM work record
4. Document the migration in the session transcript

**Hierarchical project guidance:**

- CLAUDE.md and `_inbox/` belong at the top-level project root, not in
  subprojects
- Subproject work: navigate to the subproject directory for active work;
  session governance artifacts (transcript, baseline) live in the parent
  `.claude/`
- One CLAUDE.md at root with subproject-specific sections is preferred;
  separate CLAUDE.md per subproject only if governance needs diverge
  significantly

**Agent-created memory vs DSM MEMORY.md:**

- DSM MEMORY.md (in `~/.claude/projects/`) is the canonical cross-session
  memory for Claude Code
- Agent-created memory files in project directories are pre-DSM artifacts;
  extract user preferences into CLAUDE.md, then treat per migration checklist
- Do not maintain parallel memory systems; consolidate into MEMORY.md

---

### 6.8. Private Project Pattern

Some projects contain personal or sensitive data (financial, medical, legal)
that must never appear in any committed artifact. These projects benefit from
DSM's methodology structure but cannot participate in the ecosystem's standard
communication channels without risking data exposure. The Private Project
Pattern provides DSM methodology with strict data isolation.

#### When to Use

- Project contains personal data subject to GDPR or similar regulations
- Data must never appear in any committed artifact across the ecosystem
- Project benefits from DSM structure (session management, checkpoints,
  feedback) but not from public visibility

#### Core Properties

| Property | Standard DSM Spoke | Private Project |
|----------|-------------------|-----------------|
| Git tracking | Remote (GitHub) | Local only (no remote) |
| DSM_3 Section 7 registry | Yes | No |
| Ecosystem path registry | Yes (gitignored) | Yes (gitignored) |
| Inbox (inbound) | Bidirectional | Receive only |
| Feedback push (outbound) | Automatic at wrap-up | Manual only, after user sanitization |
| Inbox notification (outbound) | Automatic with content | Minimal: "feedback available" (path only, no content) |
| README notifications | Yes | No (local README, no notifications) |
| Cross-repo writes from project | Yes | Never (except minimal inbox notification) |
| CLAUDE.md `@` reference | Yes | Yes (with privacy overrides) |
| README.md | Public project description | Local project status dashboard |

#### Git Configuration

Private projects use **local git only**: `git init` with no remote configured.
This provides change history, revert capability, and `git diff` visibility
while ensuring no data leaves the local machine. DSM session commands work
without modification.

**What to track:** The intelligence layer, checkpoints, markdown, CSVs,
structured extracts.

**What to gitignore:** Raw source documents (PDFs, bank statements, scanned
images), application data files (WISO, Elster), and any file containing
unprocessed personal data.

The objective is data isolation from internet exposure, not absence of
version control. Local git minus a remote equals local-only version control
with no exposure risk.

#### Project Status README

Private projects maintain a `README.md` at the project root as a local
status dashboard. Unlike standard spoke READMEs (which describe the project
for external audiences), this README serves the user as a quick orientation
when returning to the project.

**Content:**
- Project description and purpose (1-2 sentences)
- Current stage or phase
- Last session summary (date, what was done)
- Next steps (3-5 actionable items)
- Key file locations within the project

**Lifecycle:**
- **Updated at:** Full `/dsm-wrap-up` (current stage, last session, next steps)
- **Read at:** Full `/dsm-go` (orientation before starting work)
- **Never sent externally:** No README Change Notifications (no remote, no
  portfolio entry)

This README is committed to local git alongside other intelligence-layer
artifacts.

#### CLAUDE.md Template

The project CLAUDE.md includes the standard `@` reference to DSM_0.2 and
adds a Privacy and Data Isolation section:

```markdown
@/path/to/dsm-central/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]
Project type: Private Documentation. DSM private project pattern
(see DSM_3 Section 6.8).

## Privacy and Data Isolation

**Data classification:** Personal/sensitive. GDPR applies.

### Protocol Applicability

| Protocol | Applies? | Override |
|----------|:--------:|---------|
| Session Transcript Protocol | Yes | Standard |
| Pre-Generation Brief Protocol | Yes | Standard |
| Destructive Action Protocol | Yes | Standard |
| Inbox, inbound | Yes | Receive only; DSM Central writes to `_inbox/` |
| Feedback Push, outbound | Yes | Manual only; user sanitizes, then agent sends minimal inbox notification |
| README Change Notification | No | No public README; no notifications |
| Cross-repo writes | No | Only minimal inbox notification to DSM Central |
| DSM_3 Section 7 registration | No | Private; invisible to all committed artifacts |
| Continuous Learning | Yes | Web searches must not include personal data |

### Agent Constraints

- Never include personal data in conversation text
- Never write project content to any path outside this project root
- Never push feedback autonomously; all outbound data requires explicit
  user review and sanitization
- Web searches must not include personal identifiers (Query Sanitization
  applies)

### Data Flow

DSM Central --writes--> _inbox/               (methodology updates only)
{project}   --writes--> DSM Central/_inbox/    (minimal: "feedback available")
DSM Central <--reads--- dsm-docs/feedback-to-dsm/         (sanitized by user, read-only)

### Session Transcript Protocol (reinforces inherited protocol)

- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  `<------------Start Thinking / HH:MM------------>`
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
```

Extend the Agent Constraints with project-specific sensitive data types
(e.g., IBANs, tax numbers, card numbers, addresses) as appropriate.

#### Directory Structure

```
{project}/
  README.md                (local status dashboard)
  .claude/
    CLAUDE.md              (@ reference + privacy overrides)
    session-transcript.md
    session-baseline.txt
    reasoning-lessons.md   (optional)
  _inbox/                  (receives from DSM Central only)
  plan/
    backlog/               (project-specific enhancements, tech debt)
      done/
  dsm-docs/
    decisions/
    feedback-to-dsm/       (per-session: YYYY-MM-DD_sN_{type}.md)
      done/
    checkpoints/
      done/
    research/
      done/
    plans/
      done/
```

Project-specific directories sit alongside the DSM structure. The DSM
directories provide methodology infrastructure; project directories hold
domain content.

#### Data Flow Architecture

```
DSM Central --writes--> {project}/_inbox/         (methodology updates only)
{project}   --writes--> DSM Central/_inbox/       (minimal: "feedback available")
DSM Central <--reads--- {project}/dsm-docs/feedback-to-dsm/  (sanitized by user)
```

No other cross-boundary data flow. The user is the sanitization gate.

#### Communication Protocol

**Inbound (DSM Central to project):**
DSM Central writes methodology updates, protocol changes, and notifications
to `{project}/_inbox/` using the standard inbox entry format (Section 6.4).
The agent processes these at session start per DSM_0.2 Inbox Check.

**Outbound (project to DSM Central):**
The agent writes per-session feedback files to `{project}/dsm-docs/feedback-to-dsm/`
during the session. At wrap-up:
1. Agent lists feedback files that are ripe
2. User reviews content for personal data and confirms sanitization
3. After explicit confirmation, the agent sends a **minimal** inbox
   notification to DSM Central's `_inbox/`:

```markdown
### [YYYY-MM-DD] Feedback available from {project-name}

**Type:** Notification
**Priority:** Low
**Source:** {project-name}

Sanitized feedback is available for review.

**Feedback file:** `{project-path}/dsm-docs/feedback-to-dsm/{filename}`
```

The notification contains only the file path, never project content.
DSM Central reads the feedback file directly when processing the inbox entry.

4. After DSM Central processes the feedback, the source file moves to
   `dsm-docs/feedback-to-dsm/done/`

**Receiver-side validation (DSM Central):**
When DSM Central reads a feedback file from a private project, it must scan
for sensitive patterns (personal names, financial data, card numbers,
addresses) before ingesting. If sensitive content is detected, alert the
user and do not act on the content until re-sanitized.

#### Ecosystem Visibility

- The project path is registered in `.claude/dsm-ecosystem.md` (gitignored),
  giving DSM Central a way to write inbox entries
- No entry in DSM_3 Section 7 project registry (committed)
- No backlog item in `plan/backlog/developments/` (committed)
- The project is invisible to all committed artifacts

#### WSL2 Path Constraint

The CLAUDE.md `@` reference uses a Linux path (e.g.,
`@/home/berto/.../DSM_0.2_Custom_Instructions_v1.1.md`). This works when
the project is opened from WSL2, where both `/home/berto/` and `/mnt/d/`
are accessible. It fails if opened from native Windows, where Linux paths
do not resolve.

**Constraint:** Private projects on Windows drives must be opened via WSL2
(VS Code Remote - WSL or `code "/mnt/d/..."` from WSL terminal). Document
this requirement in the project CLAUDE.md.

#### Initialization Checklist

Use the standard Spoke Project Initialization Checklist (Section 6.7) with
these modifications:

| Step | Standard | Private Project Override |
|------|----------|------------------------|
| 1 | `git init` + remote | `git init` only, no remote |
| 3 | Standard CLAUDE.md | Add Privacy and Data Isolation section (template above) |
| 5 | Bidirectional inbox | Add note: "Receives from DSM Central only" |
| 9 | Inbox confirmation to hub | Same, but note privacy project type |
| 11 | Initial commit + push | Initial commit only (no push, no remote) |
| New | N/A | Create `README.md` as local status dashboard |

#### Anti-Patterns

**DO NOT:**
- Configure a git remote for private projects; the isolation guarantee
  depends on no remote existing
- Include personal data in inbox notifications to DSM Central; the
  notification contains only the file path, never content
- Register private projects in DSM_3 Section 7 or in committed backlog
  items; ecosystem visibility is gitignored-only
- Skip the Privacy and Data Isolation section in CLAUDE.md; without it,
  inherited DSM_0.2 protocols (automatic feedback push, cross-repo writes)
  execute with default behavior, which leaks data
- Send feedback content in the inbox notification; the inbox entry says
  "feedback available" and points to the file, DSM Central reads the
  file directly
- Skip the local README.md; without it, the user loses project orientation
  between sessions

---

### 6.9. Standard Spoke Pattern

The Standard Spoke is the default DSM project type: a project created under
DSM governance, tracked on GitHub, and participating fully in the ecosystem
feedback loop. Most DSM projects follow this pattern. This section provides
a unified entry point; detailed protocols are in Sections 6.1-6.7.

#### When to Use

- New project created to solve a data science, application, or documentation
  problem within the DSM ecosystem
- Project will have a public GitHub repository
- Full participation in the ecosystem feedback loop is appropriate (README
  notifications, automatic feedback push, bidirectional inbox)

#### Core Properties

| Property | Value |
|----------|-------|
| Git tracking | Remote (GitHub) |
| Registry visibility | DSM_3 Section 7 (committed) |
| Inbox direction | Bidirectional |
| Feedback push | Automatic at wrap-up |
| README notifications | Yes (portfolio + DSM Central) |
| Cross-repo writes | Yes |
| CLAUDE.md location | Project `.claude/` |
| `@` reference | Required |

#### Git Configuration

Standard spokes use `git init` with a remote configured to GitHub:

```
git init
git remote add origin https://github.com/{user}/{repo}.git
git branch -m main
```

The remote ensures commits are backed up and the project is visible to
the ecosystem. Push at every session wrap-up.

#### CLAUDE.md Template

```markdown
@/path/to/dsm-central/DSM_0.2_Custom_Instructions_v1.1.md

# Project: [Project Name]
Domain: [domain]
Project type: [Notebook | Application | Hybrid | Documentation].
Standard spoke pattern (see DSM_3 Section 6.9).

## Project-Specific Instructions
[project-specific content here]

## Protocol Applicability

| Protocol | Applies? | Override |
|----------|:--------:|---------|
| Session Transcript Protocol | Yes | Standard |
| Pre-Generation Brief Protocol | Yes | Standard |
| Destructive Action Protocol | Yes | Standard |
| Inbox, inbound | Yes | Bidirectional |
| Feedback Push, outbound | Yes | Automatic at wrap-up |
| README Change Notification | Yes | Standard |
| Cross-repo writes | Yes | Standard |
| DSM_3 Section 7 registration | Yes | Standard |

## Session Transcript Protocol (reinforces inherited protocol)

- Append thinking to `.claude/session-transcript.md` BEFORE acting
- Output summary AFTER completing work
- Conversation text = results only
- Use Reasoning Delimiter Format for every thinking block:
  `<------------Start Thinking / HH:MM------------>`
  [reasoning content]
- HH:MM is 24-hour local time when thinking begins; no end delimiter needed
```

#### Directory Structure

```
{project}/
  README.md                (project description for external audiences)
  .claude/
    CLAUDE.md              (@ reference + project-specific instructions)
    session-transcript.md
    session-baseline.txt
    reasoning-lessons.md   (optional)
    dsm-ecosystem.md       (gitignored: cross-repo paths)
  _inbox/                  (bidirectional; README.md with entry template)
  plan/
    backlog/               (project-specific enhancements, tech debt)
      done/
  dsm-docs/
    blog/
      done/
    checkpoints/
      done/
    decisions/
    feedback-to-dsm/
      done/
    guides/
    handoffs/
    plans/
      done/
    research/
      done/
```

See DSM_0.1 for the full nine-subdirectory canonical structure.

#### Data Flow Architecture

```
DSM Central  --writes--> {project}/_inbox/          (methodology updates, backlog proposals)
{project}    --writes--> DSM Central/_inbox/        (feedback, README notifications)
{project}    --writes--> portfolio/_inbox/          (README notifications)
DSM Central  <--reads--- {project}/dsm-docs/feedback-to-dsm/   (methodology observations, backlogs)
```

Full bidirectional communication. The agent executes inbox and feedback
steps automatically at session start and wrap-up per DSM_0.2 protocols.

#### Communication Protocol

**Inbound (DSM Central to project):** DSM Central writes methodology
updates, protocol change notifications, and backlog proposals to
`{project}/_inbox/`. The agent processes these at session start.

**Outbound (project to DSM Central):** The agent pushes ripe feedback
files at wrap-up (per Session-End Inbox Push in DSM_0.2) and sends
README Change Notifications when `README.md` changes.

See Section 6.1 (feedback handover), Section 6.4 (inbox protocol),
and DSM_0.2 (session-end inbox push, README change notification).

#### Initialization

Use the Spoke Project Initialization Checklist (Section 6.7) without
modifications. All steps apply.

#### Anti-Patterns

**DO NOT:**
- Register standard spokes in `plan/backlog/developments/` without also
  adding them to DSM_3 Section 7; the registry is the discovery mechanism
- Skip README Change Notifications; they keep the portfolio current
- Configure the project as a private project pattern when the repository
  will have a public GitHub remote; the pattern governs isolation rules,
  not just git configuration
- Omit the Protocol Applicability table from CLAUDE.md; without it,
  protocol gaps surface at every session start (DSM_0.2 grace period
  protocol)

---
