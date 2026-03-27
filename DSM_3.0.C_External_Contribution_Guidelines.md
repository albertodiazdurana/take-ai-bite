# DSM_3 Implementation Guide - Module C: External AI Guidelines and Governance

This module covers two related topics: a reusable template for projects to define
their own AI contribution policies (Section 6.5), and the governance framework
for the contributor's side of external contributions (Section 6.6, subsections
6.6.1 through 6.6.7). For templates and analysis tools, see Module D.

## Contents

1. [External Project AI Contribution Guidelines](#65-external-project-ai-contribution-guidelines)
2. [External Contribution Governance Framework](#66-external-contribution-governance-framework)

---

### 6.5. External Project AI Contribution Guidelines

Open-source projects increasingly receive AI-assisted contributions, but most lack
guidelines for how these should be handled. Some projects ban AI contributions
entirely, others accept them with disclosure requirements, most have no policy at
all. DSM agents encounter this gap during external contributions and can help
projects define their own guidelines using this template.

This section provides a reusable template, not a prescriptive policy. The project's
governance model, community norms, and maintainer preferences determine where on
the policy spectrum the guidelines should land.

#### 6.5.1. AI Policy Spectrum Positions

Five positions observed in published policies, from most permissive to most
restrictive:

| Position | Example | Key Trait |
|----------|---------|-----------|
| Full embrace | [ClickHouse](https://github.com/ClickHouse/ClickHouse/blob/master/AI_POLICY.md) | AI welcome, no disclosure required, contributor takes full responsibility |
| Disclosure | Linux Kernel (mailing list discussions) | AI-assisted code accepted with `Co-developed-by:` trailer, contributor signs off |
| Proportional | Red Hat (internal guidelines, blog post) | Trivial AI use (autocomplete): no disclosure; substantial use: must be marked |
| Strict | [Ghostty](https://github.com/ghostty-org/ghostty/blob/main/AI_POLICY.md) | Mandatory disclosure (tool + extent), accepted issues only, human testing required |
| Ban | QEMU (mailing list discussion) | AI-generated code cannot satisfy DCO, full prohibition |

These are reference points, not the only options. Most projects will land between
positions. Use this spectrum to calibrate the template sections below.

#### 6.5.2. AI Contribution Guidelines Template

A reusable 6-section structure. Each section addresses a dimension that every
published policy, regardless of strictness, covers.

**Section 1: Philosophy**

*Question answered:* What is this project's stance on AI-assisted contributions?

Connect to the project's existing values (lean software, code quality, community
culture). This section sets the tone for everything that follows.

| Permissive | "AI is a normal developer's tool, similar to an IDE or a keyboard. We welcome its use." |
|------------|-----------------------------------------------------------------------------------------|
| Strict | "We welcome AI as a tool, but require transparency due to quality concerns from unqualified use." |

**Section 2: Scope**

*Question answered:* What types of contributions are covered?

Define which contribution types the guidelines apply to: code, documentation,
tests, issues, discussions, media. Some policies cover all artifacts; others
focus on code only.

**Section 3: Disclosure**

*Question answered:* Must AI usage be disclosed? How?

| Approach | Mechanism |
|----------|-----------|
| Not required | No special disclosure (ClickHouse position) |
| Encouraged | PR description note, optional (contributor decides) |
| Required | Commit message tag, PR body section, or both (Ghostty, LLVM position) |

Specify the preferred mechanism: commit trailer (`Co-developed-by:`), PR body
section, checkbox in PR template, or other project-specific convention.

**Section 4: Quality Standards**

*Question answered:* What review expectations apply to AI-assisted contributions?

Common minimum: contributor must understand and be able to explain all submitted
code without referencing AI. This is the "human-in-the-loop" standard from LLVM.
Stricter policies add: human testing required, no AI-generated media, higher
review scrutiny.

**Section 5: Contributor Responsibility**

*Question answered:* Who is accountable for AI-generated code?

Universal answer across all published policies: the contributor who submits the
code takes full responsibility, regardless of how it was generated. This section
makes that explicit for the project.

**Section 6: Enforcement**

*Question answered:* What happens when guidelines are violated?

| Severity | Response |
|----------|----------|
| Graduated | Warning, then PR closure, then ban (most common) |
| Immediate | PR closed on first violation (Ghostty for undisclosed AI) |
| Informal | Reputation-based ("it may negatively affect your reputation as an engineer") |

#### 6.5.3. Optional Guideline Policy Extensions

For projects with stricter requirements, add these sections as needed:

| Extension | When to add | Example |
|-----------|-------------|---------|
| Eligible contributions | Project receives many drive-by PRs | "AI PRs only for accepted issues" (Ghostty) |
| Verification requirements | Safety-critical or complex codebase | "Must be verified with human testing" |
| Media restrictions | Project includes visual/audio assets | "No AI-generated media" |
| Maintainer exemptions | Trusted contributors have different workflow | "Maintainers are exempt from disclosure" |
| Tooling restrictions | Specific tools raise concerns | "Only tools that respect project license" |

#### 6.5.4. Guidelines Adaptation Process Steps

When a DSM agent helps an external project create AI contribution guidelines:

1. **Assess project character:** Examine governance model (BDFL, committee,
   foundation), community size, license type (permissive licenses have lower
   legal risk than copyleft + DCO), and existing contribution norms
2. **Map to spectrum position:** Use Section 6.5.1 to identify the closest
   reference point based on the project's character assessment
3. **Fill template sections:** Calibrate each section (6.5.2) to the mapped
   position; use the permissive/strict language examples as starting points
4. **Reference project-specific precedents:** Look for existing PRs with AI
   disclosure, maintainer statements about AI, or community discussions that
   reveal the project's implicit norms
5. **Present draft to maintainers:** The guidelines belong to the project, not
   to DSM. Present as a suggestion for the project to own and adapt

#### Legal Context for AI Contributions

License type affects AI contribution risk:

| License Type | Risk Level | Reason |
|-------------|------------|--------|
| MIT / Apache-2.0 | Lower | Permissive, attribution-based, no copyleft |
| GPL / AGPL | Higher | Copyleft + DCO requirements may conflict with AI generation |
| BSD | Lower | Similar to MIT |

No court has ruled definitively on AI-generated code and OSS licenses. The
practical consensus: contributors take responsibility regardless of generation
method, and standard copyright rules apply equally to AI-generated and manual code.

#### AI Contribution Guidelines Anti-Patterns

**DO NOT:**
- Impose DSM's preferences on the project; the project's governance model determines the position on the spectrum
- Skip the spectrum assessment; a strict template for a permissive project wastes maintainer time, and a permissive template for a strict project undermines trust
- Create guidelines without reviewing existing project norms and precedents (PRs, maintainer statements, community discussions)
- Present guidelines as final; they are a draft for the project to own and iterate on

Cross-reference: DSM_0.2 (Session-Start Inbox Check for AI policy detection)

Research basis: `dsm-docs/research/done/2026-02-13_backlog-096-ai-contribution-guidelines-research.md`
(7 policies mapped, legal analysis, ecosystem data, full source list)

---

### 6.6. External Contribution Governance Framework

Sections 6.1-6.4 govern spoke projects the contributor owns. This section governs
contributions to repositories owned by others: fork model, pull requests to upstream
maintainers. The contributor does not control the repository, cannot commit governance
artifacts there, and must adapt to the upstream project's conventions and review cycles.

Section 6.5 provides a template the target project itself can adopt for AI guidelines.
This section governs the contributor's side: where to keep governance artifacts, what
checks to perform, and how feedback flows back to DSM.

#### 6.6.1. When to Use External Governance

Apply this section when all of the following are true:

- The target repository is owned by someone else (not the contributor)
- Contributions go through a fork-and-PR workflow
- DSM governance artifacts (feedback, decisions, plans) cannot live in the target repo
- The contributor follows DSM methodology for their own workflow

#### 6.6.2. Governance Artifact Storage Location

All DSM governance artifacts for external contributions live in the governance
storage repo at `{contributions-docs-path}/{project-name}/` (resolved from the
Ecosystem Path Registry), not in the external repository:

```
{contributions-docs-path}/{project-name}/
  _inbox/          # Hub-spoke communication (Section 6.4 pattern)
  _references/     # Upstream docs, architecture notes, API references
  backlog/         # Contribution-specific backlog items
  blog/            # Blog journal entries and materials
  checkpoints/     # Milestone snapshots
  decisions/       # Design decisions log
  feedback-to-dsm/ # methodology.md, backlogs.md (DSM feedback)
  handoffs/        # Session handoff documents
  plan/            # Contribution plans and scope documents
  research/        # Phase 0.5 research (upstream analysis, gap studies)
  README.md        # Project overview, status, and contribution roadmap
```

This structure mirrors the spoke project `dsm-docs/` layout (DSM_0.1) but is stored
externally because the external repo is not ours to modify. The path is resolved
from the Ecosystem Path Registry (`contributions-docs` logical name).

#### 6.6.3. Key Differences from Spoke Projects

| Aspect | Spoke Project | External Contribution |
|--------|--------------|----------------------|
| Repo ownership | Contributor owns | Upstream maintainer owns |
| Governance artifacts | In project `dsm-docs/` | In `{contributions-docs-path}/` |
| Scaffolding | Hub creates `dsm-docs/` structure | Project already exists; no scaffolding |
| Sprint cadence | Contributor-defined | Upstream review cycles dictate pace |
| Feedback cadence | Sprint boundaries | Contribution milestones (PR merged, issue resolved) |
| Commit authorship | Per project CLAUDE.md policy | Must follow upstream conventions |
| CLAUDE.md location | `.claude/CLAUDE.md` (committed or gitignored) | `.claude/CLAUDE.md` (excluded via `.git/info/exclude`) |
| DSM visibility | DSM references may appear in project | No DSM references in the external repo |

#### 6.6.4. Mandatory External Pre-Contribution Checks

**Step zero: AI policy check.** Before any technical work on a new external project,
determine the project's stance on AI-assisted contributions. Use the policy spectrum
in Section 6.5.1 to map the project's position. Check for:

- Published AI policy (e.g., `AI_POLICY.md`, `CONTRIBUTING.md` section)
- Maintainer statements in PRs, issues, or discussions
- Community norms (existing AI-disclosed PRs and their reception)

If no policy exists, apply the **human-in-the-loop standard** by default: the
contributor must understand and be able to explain all submitted code without
referencing AI assistance.

**Upstream precedence rule:** If the target project establishes an AI disclosure
policy at any point, it takes precedence over the contributor's preferences. This
includes commit attribution, disclosure requirements, and any restrictions on
AI-generated content. The contributor adapts, not the project.

#### 6.6.5. CLAUDE.md Pattern for External Projects

External projects require a local `.claude/CLAUDE.md` for the agent to follow DSM
protocols, but this file must not appear in commits or pull requests. The file is
created locally and excluded via `.git/info/exclude` (not `.gitignore`, which would
be committed).

**Why protocol filtering matters:** Not all DSM_0.2 sections apply to external
contributions. The IronCalc protocol analysis (R1) found only ~3 of 13 sections
apply directly; the rest need adaptation or do not apply. The CLAUDE.md must
specify which protocols apply and which are filtered out.

See **Module D, Section 6.6.8** for the complete CLAUDE.md template, kickoff prompt
template, and setup checklist.

#### 6.6.6. External Contribution Feedback Cadence

Contribution milestones replace sprint boundaries as feedback triggers:

| Milestone | Feedback Action |
|-----------|----------------|
| PR submitted | Note approach, design decisions, observations |
| PR reviewed (changes requested) | Record reviewer feedback, adapt approach |
| PR merged | Update methodology.md scores, note what worked |
| Issue resolved | Record contribution impact and lessons |
| Review cycle complete | Push ripe entries to DSM Central inbox |

Feedback files use the same structure as spoke projects (methodology.md, backlogs.md)
but are located in `{contributions-docs-path}/{project}/feedback-to-dsm/`.

#### 6.6.7. External Contribution Onboarding Lifecycle

External contributions follow a three-phase progression that builds understanding
incrementally while producing value at each stage.

**Phase 1: Opportunity Research**

Before writing any code, understand the project and map contribution opportunities:

- Explore the project's philosophy, mission, architecture, and contribution norms
- Identify where the contributor's skills align with project needs (not just open issues)
- Check AI policy (Section 6.6.4) and contribution requirements
- Deliverable: **Contribution Scope Plan** in `{contributions-docs-path}/{project}/plan/`

This follows the Phase 0.5 research pattern (DSM_0.2): stated question, research,
validation gate. The question is "where can I contribute most effectively?"

**Contribution Scope Plan Template:**

```markdown
# Contribution Scope Plan - {Project}

**Date:** YYYY-MM-DD
**Contributor Profile:** {Summary of relevant skills and domain expertise}
**Project Overview:** {One-line description of the project and its mission}

---

## {Domain Area 1} ({path or component})

### Current State
- {What exists: file count, function count, coverage level}

### Gaps
- {What is missing, broken, or incomplete}

### Opportunities

| ID | Description | Difficulty | Value |
|----|-------------|------------|-------|
| {A1} | {Specific opportunity} | Green/Yellow/Red | High/Medium/Low |

---

## {Domain Area N}
{Repeat Current State / Gaps / Opportunities for each relevant area}

---

## Ranked Opportunities

### Immediate (Green, 1-2 weeks)
1. **{ID}**: {Description} - {Why this is a good starting point}

### Short-Term (Yellow, 2-4 weeks)
2. **{ID}**: {Description} - {What skills are needed}

### Long-Term (Red, requires discussion)
3. **{ID}**: {Description} - {Why maintainer input is needed}
```

**Portfolio-to-Opportunity Mapping:**

The Scope Plan maps contributor skills to project domains, not just open issues.
Assess each opportunity along two dimensions:

- **Difficulty tier:** Green (follows existing patterns, low risk), Yellow (moderate
  complexity or unfamiliar tooling), Red (requires architectural discussion with
  maintainer). Tier reflects the contributor's current skill level, not absolute
  difficulty.
- **Value assessment:** High when the contributor has domain expertise the project
  team lacks (e.g., statistical knowledge for a spreadsheet engine). Medium for
  general improvements. Low for cosmetic or optional enhancements.

Prioritize opportunities where high contributor expertise meets high project need;
these produce the most value with the least friction.

**Value-Add Identification:**

Look beyond open issues. The most impactful contributions often address needs the
project team has not yet articulated:

- Missing functionality that domain expertise reveals (functions, algorithms, edge cases)
- Test gaps that only show up with domain-specific test data (e.g., NIST reference datasets)
- Documentation that requires specialist knowledge to write accurately
- Cross-reference the project's roadmap and discussions to align value-add proposals
  with the project's direction

Reference implementation: `{contributions-docs-path}/IronCalc/plan/value-add-opportunities.md`

**Phase 2: Onboarding**

Build trust through small, high-quality contributions:

- Start with low-hanging fruit: documentation fixes, test additions, small bug fixes
- Learn the project's review process, coding conventions, and communication norms
- Collect feedback on contribution style and quality
- Deliverable: first merged contributions, lessons learned documented

**Phase 3: Deepening**

Increase contribution complexity based on earlier feedback:

- Feedback from Phases 1-2 informs which deeper contributions to pursue
- Understanding of project philosophy enables contributions that align with direction
- Deliverable: substantial contributions, potential for ongoing collaboration

**Phase Transitions**

| Transition | Validation Criteria |
|------------|-------------------|
| Phase 1 → 2 | Opportunity map reviewed, initial contribution targets selected, AI policy checked |
| Phase 2 → 3 | At least one contribution merged, conventions understood, reviewer feedback positive |

Do not skip phases. A contributor who jumps to Phase 3 without Phase 1 research
misaligns contributions with project needs; a contributor who skips Phase 2 produces
work that doesn't match project conventions.

**PR Size Guidance (Match the Room)**

External contributions must match the upstream project's review culture. Oversized PRs
burden maintainers and delay review; undersized PRs fragment context. The right size is
whatever the maintainer can review with substance (DSM_6.0 Principle 1: Take a Bite;
Principle 6: Match the Room).

| Project Signal | Typical PR Size | Contributor Target |
|----------------|----------------|-------------------|
| Small PRs in merge history (30-60 lines) | Micro | Match: one function, one test, one doc section per PR |
| Medium PRs (100-300 lines) | Standard | Keep under 300 lines; split if larger |
| Large PRs accepted (500+ lines) | Liberal | Still prefer smaller; split when natural boundaries exist |
| No clear pattern | Unknown | Default to small PRs until feedback calibrates expectations |

**How to calibrate:**
1. During Phase 1 research, review the project's recent merged PRs (last 20-30)
2. Note the median line count, number of files, and review turnaround time
3. Record findings in the Contribution Scope Plan
4. Use this as the target for your own PRs

**Onboarding Lifecycle Anti-Patterns:**

**DO NOT:**
- Submit a 500-line PR to a project with a 50-line PR culture; split into smaller PRs
- Assume your internal session output maps 1:1 to a PR; a session may produce work for
  multiple PRs or a PR may span multiple sessions
- Treat PR size guidance as absolute; maintainer feedback overrides any heuristic

---

**Parent document:** `DSM_3.0_Methodology_Implementation_Guide_v1.1.md`
**Continues in:** Module D (Templates and Analysis), Module E (Governance Isolation)
