# DSM 2.0 Module C: Sprint and Assessment Templates

**Parent document:** DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md
**Scope:** Template 8 (sprint planning), Template 10 (end-of-day checkpoint
questions), Template 11 (Q&A preparation), Template 12 (scope limitations log),
Template 13 (project-level plan).

This module contains templates for sprint-level planning and assessment
artifacts. Template 8 provides the comprehensive sprint plan structure;
Templates 10-12 provide assessment tools used during and after sprint execution;
Template 13 sits one tier above Template 8, for projects that arrive with a
decomposition already done.

## Contents

| § | Section | Description |
|---|---------|-------------|
| 1 | [Template 8: Sprint Plan with Cadence Guidance](#1-template-8-sprint-plan-with-cadence-guidance) | Sprint-level planning for multi-sprint projects |
| 2 | [Template 10: End-of-Day Checkpoint Questions](#2-template-10-end-of-day-checkpoint-questions) | Quality gates for daily work verification |
| 3 | [Template 11: Q&A Preparation Document](#3-template-11-qa-preparation-document) | Structured preparation for sprint presentations |
| 4 | [Template 12: Scope Limitations Log](#4-template-12-scope-limitations-log) | Transparent documentation of scope boundaries |
| 5 | [Template 13: Project-Level Plan for Pre-Decomposed Projects](#5-template-13-project-level-plan-for-pre-decomposed-projects) | Routing and tracking tier above Template 8 |

---

## 1. Template 8: Sprint Plan with Cadence Guidance

Sprint-level planning template for multi-sprint projects. Combines task
breakdown, prerequisites, and prioritization at the sprint level (rather than
daily level). Encourages short sprint cadence with feedback at every boundary.

**When to use:** Projects with multiple sprints, or any sprint requiring
structured planning with MUST/SHOULD/COULD deliverables.

**Sprint Cadence Guidance:**
- Prefer 1-3 focused sprints over 1 large sprint
- Each sprint should deliver a testable, demonstrable increment
- Each sprint boundary triggers the Sprint Boundary Checklist below
- Split sprints when: original scope has >2 distinct deliverable types, would
  exceed 3 sessions without a feedback point, or natural delivery boundaries exist

**Format:**

```markdown
# Sprint [N]: [Sprint Title]

**Duration:** [Estimated sessions]
**Goal:** [One-sentence sprint objective]
**Prerequisites:** [What must be complete before starting]

## Research Assessment (before detailing deliverables)

After initial research and any decisions, evaluate:
- Can I describe the scope in enough detail for a concrete task breakdown?
- Are there unresolved unknowns that would make task estimates speculative?

If unknowns remain, conduct targeted deep-dive research (see DSM_0.2 Phase 0.5,
tiered research pattern) before proceeding to deliverables. This prevents plans
built on speculative assumptions.

## Experiment Gate (before implementation begins)

If the sprint introduces a new user-facing capability, an experiment must be
defined before implementation starts:

- [ ] **Capability sprint:** EXP-XXX defined in epoch/project plan with success
  criteria, realistic test data, and expected output (see DSM 4.0 Section 4.4,
  Appendix C.1.3)
- [ ] **Performance-only sprint** (no new capability): experiment skip justified
  in sprint notes

When work emerges between sprints (e.g., findings from a prior experiment reveal
a new capability need), update the epoch/project plan with an experiment
definition before the capability is considered complete.

## Branch Strategy

For multi-sprint projects, each sprint creates a Level 3 sprint branch
(`sprint-N/short-description`) off the session branch (Level 2). The sprint
branch merges back to the session branch when all sprint plan items are
checked off. See DSM_0.2 Three-Level Branching Strategy for the full model.

---

## Deliverables

### MUST (Sprint fails without these)
- [ ] [Deliverable 1] -- [brief description]
- [ ] [Deliverable 2] -- [brief description]

### SHOULD (Expected, defer if blocked)
- [ ] [Deliverable 3] -- [brief description]

### COULD (Stretch goals)
- [ ] [Deliverable 4] -- [brief description]

---

## Phases

### Phase 1: [Phase Name]
- **Focus:** [What this phase accomplishes]
- **Deliverables:** [Which items from above]
- **Execution mode:** notebook | script | document | both
- **DSM references:** [Relevant DSM sections for this phase type]
- **Success criteria:** [How to know phase is complete]

### Phase 2: [Phase Name]
- **Focus:** [What this phase accomplishes]
- **Deliverables:** [Which items from above]
- **Execution mode:** notebook | script | document | both
- **DSM references:** [Relevant DSM sections for this phase type]
- **Success criteria:** [How to know phase is complete]

**Phase planning notes:**
- Tag each phase with an execution mode. Use `script` when the phase involves
  long-running computation (>2 min), batch processing, or results that must
  persist independently. Use `document` for documentation-only phases.
  For data science projects, notebooks should import from or call scripts,
  not replicate computation inline.
- For evaluation/benchmarking phases, reference DSM Appendix C.1
  (Experiment Templates) and Section 5.2.1 (Experiment Tracking).

---

## Phase Boundary Checklist (intra-sprint)
- [ ] Record phase observations and scores in `dsm-docs/feedback-to-dsm/YYYY-MM-DD_sN_methodology.md`
- [ ] Create checkpoint if significant milestone reached
- [ ] Log decisions made during phase (dsm-docs/decisions/)
- [ ] Update blog materials if insights worth sharing

---

## Open Design Questions
1. [Question that needs answering during sprint]
2. [Question that needs answering during sprint]

---

## How to Resume
1. Read this sprint plan
2. Read the most recent checkpoint in dsm-docs/checkpoints/
3. [Project-specific resume steps]

---

## Sprint Boundary Checklist
- [ ] Checkpoint document created (dsm-docs/checkpoints/)
- [ ] Feedback files updated (backlogs, methodology)
- [ ] Decision log updated with sprint decisions
- [ ] Tests passing (DSM 4.0 projects)
- [ ] dsm-docs/guides/smoke-tests.md current (DSM 4.0 projects; N/A for documentation projects)
- [ ] Blog journal entry written
- [ ] Blog publication tracker updated (`dsm-docs/blog/README.md`)
- [ ] Repository README updated (status, results, structure)
- [ ] Next steps summary (3-5 sentences: next sprint goal, key deliverables, relevant plan reference)
```

**Example (abbreviated):**

```markdown
# Sprint 1: Parser MVP

**Duration:** 1-2 sessions
**Goal:** Extract section headings and cross-references from DSM markdown files
**Prerequisites:** Project setup complete (Phase 0), research survey done (Phase 0.5)

## Deliverables
### MUST (3 total - Non-negotiable)
- [ ] Section heading parser -- Extract numbered, appendix, and unnumbered headings
- [ ] Cross-reference extractor -- Find Section X.Y.Z, Appendix X.Y, DSM_X.Y patterns
- [ ] Unit test suite -- 80%+ coverage, TDD approach

### SHOULD (2 total - Complete if on track)
- [ ] Test fixture with realistic DSM patterns

### COULD (1 total - Stretch)
- [ ] Code block skip handling (avoid false positives in fenced blocks)

## Phases
### Phase 1: Section Parser
- **Focus:** Extract headings from markdown
- **Success criteria:** Handles all 4 heading formats, tests pass

### Phase 2: Cross-Reference Extractor
- **Focus:** Find references in body text
- **Success criteria:** Finds all 3 pattern types, skips code blocks
```

---

## 2. Template 10: End-of-Day Checkpoint Questions

Quality gates to prevent compounding errors and ensure readiness for the next
day. Embed 3-5 critical questions at the end of each day's deliverables section.

**Categories of checkpoint questions:**

- **Technical Validation:** Is [requirement] correctly implemented? Are [metrics] within expected ranges? Should we adjust [approach]?
- **Quality Assessment:** Does output meet [standard]? Are visualizations clear? Is documentation complete? Silent errors or edge cases?
- **Scope Management:** Did we complete all parts within budget? Should we add/remove work for next day? Findings worth deeper exploration?
- **Readiness:** Prerequisites met for next day? Intermediate outputs saved and validated? Blockers documented? Clarity on tomorrow?

**Format (embed at end of each day's section):**
```markdown
#### **End-of-Day X Checkpoint**

**Critical Review Questions:**
1. [Technical validation question]?
2. [Quality assessment question]?
3. [Scope management question]?
4. [Readiness question]?
5. [Budget/schedule question]?

**Adjustment Options:**
- If ahead of schedule: [Expansion option]
- If behind schedule: [Reduction option]
- If [condition] found: [Mitigation action]

**Use Daily Checkpoint Template (Section [X]) to document decisions.**
```

**Example:**
```markdown
#### **End-of-Day 2 Checkpoint**

**Critical Review Questions:**
1. Are core components functioning as expected under standard inputs?
2. Did the implemented approach reduce error rate to <1% as planned?
3. Are edge cases identifiable for further analysis?
4. Should we add optional enhancements tomorrow (stretch goal)?
5. Are we on track for integration work (Day 3)?

**Adjustment Options:**
- If ahead of schedule: Add stretch enhancements on Day 3
- If behind schedule: Reduce Day 3 scope to core deliverables only
- If approach insufficient: Revisit design decisions on Day 3

**Use Daily Checkpoint Template (Section 11) to document decisions.**
```

---

## 3. Template 11: Q&A Preparation Document

Prepare for presentation questions and reinforce understanding of work. Creating
a Q&A document forces deep understanding (teaching effect: if you cannot explain
it, you do not understand it) and identifies knowledge gaps before presentation.

**When to Create:** After each major sprint (especially Sprint 1, Sprint 3)

**Filename:** `Sprint[N]_QA_Presentation_Prep.md`

**Location:** `dsm-docs/`

**Structure:**

```markdown
# Sprint [N] Q&A - Presentation Preparation

**Project:** [Name]
**Scope:** [Sprint objectives]
**Total Questions:** ~35 (7 per major deliverable/section)

## Table of Contents
1. [Topic 1 - Deliverable/Area]
2. [Topic 2 - Deliverable/Area]
...

---

## Topic 1 - [Deliverable/Area Name]

### Q1: [Technical question about methodology]

**Technical Answer:**
[Detailed explanation with metrics, algorithms, statistical reasoning]

**Business Answer:**
[Stakeholder-friendly explanation focusing on outcomes and decisions]

**Key Insight:**
[One sentence takeaway that captures essence]

---

### Q2: [Business question about findings]

**Technical Answer:**
[Statistical details, correlation coefficients, test results]

**Business Answer:**
[Action-oriented response with ROI implications]

**Key Insight:**
[Memorable sound bite for presentations]
```

**Question Distribution Guidelines:**

**Early Sprints (Exploration/Research):**
- 40% Technical (methodology choices, quality assessments, validation approach)
- 40% Business/Domain (insights, patterns discovered, implications)
- 20% Contextual (scope decisions, limitations, alternatives considered)

**Later Sprints (Implementation/Delivery):**
- 40% Technical (architecture, design decisions, validation approach)
- 30% Business/Domain (performance metrics, delivery readiness)
- 30% Comparison (why approach A vs approach B, tradeoffs)

**Question Types to Cover:**
- **Methodology:** "Why method X over Y?", "What assumptions?", "How did you handle [challenge]?"
- **Results:** "Most important finding?", "What surprised you?", "How confident?"
- **Decisions:** "Why Option A over B?", "What alternatives?", "Approach differently next time?"
- **Business:** "What should we do with this?", "Expected improvement?", "Limitations?"

**Benefits:**
- Forces deep understanding (teaching effect)
- Identifies knowledge gaps early (before presentation)
- Builds presentation confidence (practiced responses)
- Creates reference material for final report
- Demonstrates systematic thinking to stakeholders

---

## 4. Template 12: Scope Limitations Log

Transparently document what is out of scope and why. This template prevents
stakeholder surprise, documents justification for scope decisions, creates a
roadmap for future phases, and protects against scope creep.

**When to Create:** Sprint 1 (after scope finalized)

**When to Update:** Whenever a scope boundary is discovered or confirmed

**Filename:** `scope_limitations.md`

**Location:** `dsm-docs/`

**Template:**

```markdown
# Scope Limitations - [Project Name]

**Project:** [Name]
**Last Updated:** [Date]
**Version:** [X]

---

## In Scope

**Included in this analysis:**
- [What IS covered - be specific]
- [What IS covered - include metrics if relevant]
- [What IS covered - reference decisions if applicable]

**Example:**
- OK: Module A, B, and C (core functionality, 80% of use cases)
- OK: REST API endpoints only (12 endpoints, excludes GraphQL)
- OK: English language content only (i18n deferred)
- OK: Single-tenant deployment (March 2026 release)
- OK: Development sample for prototyping, full scope for validation

---

## Out of Scope

**Excluded from this analysis:**
- [What is NOT covered] - **Reason:** [Why excluded - resource/time/data/priority]
- [What is NOT covered] - **Reason:** [Why excluded]

**Example:**
- ERROR: GraphQL API layer - **Reason:** REST covers all current integration needs
  (per DEC-010). Out of scope for 4-sprint timeline.
- ERROR: Multi-tenant deployment - **Reason:** Single-tenant sufficient for
  architecture validation. Multi-tenant would triple complexity.

---

## Discovered Limitations

**Limitations identified during analysis:**

| Item | Discovered When | Impact | Mitigation | Status |
|------|-----------------|--------|------------|--------|
| [Limitation] | [Sprint X, Day Y] | [Effect on project] | [How we addressed it] | [Accepted/Workaround/Future] |

**Example:**
| Item | Discovered | Impact | Mitigation | Status |
|------|-----------|--------|------------|--------|
| Edge case X not covered | S1, Day 5 | Cannot validate condition X | Document, note for Phase 2 | Accepted |
| 16% records missing field Y | S1, Day 3 | Cannot distinguish absent vs not-tracked | Conservative default (DEC-003) | Workaround |

---

## Future Scope Expansion

**Potential additions for Phase 2 or future work:**

1. **[Potential addition]**
   - **Value proposition:** [Business benefit]
   - **Prerequisites:** [What needs to happen first]
   - **Priority:** High / Medium / Low
```

---

## 5. Template 13: Project-Level Plan for Pre-Decomposed Projects

A **routing and tracking** tier one level above Template 8. It applies when a
project arrives with a decomposition already done , an external build
specification, a client statement of work, a research protocol , and the
decomposition is better than a sprint plan would produce, because it was made
with the domain in hand before any code existed to rationalise around.

**Canonical filename: `PROJECT-PLAN.md`, with a hyphen**, in `dsm-docs/plans/`.
The hyphen is normative. It matches the `dsm-docs/` convention and the only real
field usage; DSM_0.1's root anti-pattern table records the same spelling.

**When to use:** the project arrives with a specification carrying its own
milestones, numbered requirements, or pre-registered acceptance criteria.

**When NOT to use:** a project without an existing decomposition starts at
Template 8 and stays conformant. **This tier is never mandatory.** It adds a home
for a case that already exists; it does not insert a step for everyone.

**The rule that makes this tier work , reference, do not copy.** The plan's job is
to route and track, not to restate. Where a source specification already carries
acceptance criteria, milestones or invariants, the plan **points at them by
section and does not reproduce them**. Copying creates two standards, and the copy
is the one that rots. A field left as a pointer is the template working, not the
template half-filled.

**Thinness is the design.** If filling this template feels like re-decomposing the
source, stop , the source is the decomposition and this is its index.

**Two kinds of source, and only one of them stays the authority.** The
reference-don't-copy rule above assumes an **external, authoritative** source , a
client specification, a statement of work, a research protocol, anything carrying
pre-registered acceptance criteria the project does not get to rewrite. There the
source stays the standard and the plan points at it.

A **project-authored draft** is the other case: a preliminary plan the team wrote
before doing its own grounding research. When that research invalidates parts of
the draft, the plan **supersedes** it, becomes the authority itself, and the draft
becomes historical origin. That is correct, and it is the opposite of the rule
above.

Record which case applies in the `Source specification` header field , `authority`
or `superseded` , because the two produce different reconciliation duties. Against
an external authority, reconciliation means checking the plan still matches the
source. Against a superseded draft, there is nothing to reconcile against and the
plan's own history is the record.

This distinction came from tracing the one real field instance
(`meter-to-cash`) against an earlier draft of this template: its header reads
`**Supersedes:** _reference/preliminary-plan.md`, which the earlier draft would
have classed as a violation of its own central rule. It is not a violation; it is
the second case, and the template was missing it.

**Format:**

```markdown
# Project Plan: [Project Name]

**Source specification:** [path or URL]
**Source role:** [authority | superseded] , see "Two kinds of source" above
**Status:** [Planning | In progress | Complete]
**Last reconciled:** YYYY-MM-DD

## Source of truth

What this document does NOT restate, and where that content lives instead.

| Content | Lives in | This plan's role |
|---------|----------|------------------|
| Acceptance criteria | [source §N] | reference only, never copied |
| Numbered requirements | [source §N] | mapped to backlog items below |
| Invariants / constraints | [source §N] | listed under Standing constraints |

## Ladder

The ordered phases or milestones, from the source specification. One line each.
Do not restate the source's detail; name the milestone and point at it.

| # | Milestone | Source ref | Status |
|---|-----------|-----------|--------|
| 1 | [name] | [§N] | [not started / in progress / done] |

## Phase to backlog mapping

Which backlog items carry which phase. This is the join between the source
specification and DSM's Actionable Work Items rule: only items in
`dsm-docs/plans/` are actionable, and this table is where a milestone becomes one.

| Phase | Backlog items | Formalized on |
|-------|---------------|---------------|
| 1 | BACKLOG-NNN, BACKLOG-NNN | YYYY-MM-DD |

## Standing constraints

Constraints that hold across every phase (technology, data handling, licensing,
deployment target, non-negotiables from the source). Not a re-listing of the
source's invariants , the ones that shape how work is sequenced.

- [constraint] , [why it constrains sequencing]

## Reconciliation log

This plan is a living document. Record when it was checked against the source
and what moved.

| Date | What changed | Trigger |
|------|-------------|---------|
| YYYY-MM-DD | [phase 2 closed; BACKLOG-NNN formalized] | [sprint boundary / phase close] |
```

**Relationship to Template 8.** Template 13 does not replace Template 8 and does
not compete with it. A project may carry both: Template 13 for the whole-project
ladder, Template 8 for whichever sprint is currently running. Template 13 has no
Sprint Boundary Checklist , that stays Template 8's, and `/dsm-go` Step 3.6's hard
gate continues to look for it there.

**Why Template 13 and not the vacant Template 9.** The numbering runs 1-8 and
10-12; 9 has never existed. Filling it would silently change what "Template 9"
means in any document written while it was vacant, and three live documents
already reference the vacancy , the EXP-004 TAB audit finding A2-041, the
`invoice-triage` intake entry, and BACKLOG-519 itself. A vacant number in a
sequence is a trap: the gap usually means something was removed, and removed
things leave references behind. 13 is unallocated in all three DSM_2.0 modules
and costs only a permanent gap, which the numbering already has.

**Origin:** BACKLOG-519, from two independent spokes reaching the same absence.
`meter-to-cash` invented a `PROJECT-PLAN.md` locally and wrote its own cadence
rule into it because Central had none to inherit; `invoice-triage` then arrived
with a 376-line build specification , 13 milestones, 20 numbered requirements, 13
invariants with named test slots , and no canonical home for the whole-project
view. Evidence base is two spokes, stated plainly rather than dressed up: both
independently built or needed the same artifact, which is stronger than two
reports of the same complaint, but it is two.

**Cadence.** When a backlog item is formalized relative to the plan that spawns
it, and how the plan is reconciled afterwards, is BACKLOG-477's subject. This
template owns the artifact; BL-477 owns the rhythm. The Reconciliation log above
is the join point.

