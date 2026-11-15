# DSM_3 Implementation Guide - Module F: Project Finalization Protocol

Every DSM project has a lifecycle: initialization (Module E), execution across
sessions, and finalization. This module defines the finalization protocol that
runs after a project's final session, capturing cross-session knowledge,
archiving artifacts, and closing the project in the DSM ecosystem. Without
this step, spoke-level reasoning lessons stay local, retrospective insights
are lost, and completed projects leave stale artifacts.

## Contents

1. [Protocol Overview and Trigger Rule](#1-protocol-overview-and-trigger-rule)
2. [Comprehensive Finalization Checklist](#2-comprehensive-finalization-checklist)
3. [Scaling Finalization by Project Size](#3-scaling-finalization-by-project-size)
4. [Retrospective Templates for Finalization](#4-retrospective-templates-for-finalization)
5. [Integration with Other DSM Protocols](#5-integration-with-other-dsm-protocols)

## Document Structure Index

| § | Section | Description |
|---|---------|-------------|
| 1 | Protocol Overview and Trigger Rule | When finalization runs, prerequisites, relationship to wrap-up |
| 2 | Comprehensive Finalization Checklist | Nine-section checklist (A-I) covering knowledge, retrospective, docs, archive |
| 3 | Scaling Finalization by Project Size | Which sections are required vs optional based on session count |
| 4 | Retrospective Templates for Finalization | Epoch and project retrospective document templates |
| 5 | Integration with Other DSM Protocols | How finalization connects to existing skills and protocols |

---

## 1. Protocol Overview and Trigger Rule

Finalization is a project-end activity, distinct from session-end wrap-up.
A session wrap-up (`/dsm-wrap-up`) closes a single session: commits, pushes,
updates MEMORY.md. Finalization (`/dsm-finalize-project`) closes the entire
project: synthesizes knowledge across all sessions, runs retrospectives,
cleans up artifacts, and notifies the ecosystem.

### 1.1. Trigger Rule for Project Finalization

Finalization runs only after these prerequisites are met:

1. The project's final `/dsm-wrap-up` has completed (committed, pushed, merged)
2. No open Level 3 branches remain for the project
3. The working tree is clean

Finalization may run in the same session as the final wrap-up (if context
budget allows) or in a dedicated session. The `/dsm-finalize-project` skill
handles the operational steps; this module provides the protocol definition
and rationale.

### 1.2. What Finalization Captures That Wrap-Up Does Not

Session wrap-up captures per-session artifacts. Finalization adds:

| Dimension | Wrap-up (per session) | Finalization (per project) |
|-----------|----------------------|---------------------------|
| Knowledge | Auto-extracted reasoning lessons | Cross-session STAA, lesson routing to Central |
| Retrospective | None | Project and epoch retrospectives |
| Documentation | Session handoff | README closure, decision log closure |
| Backlog | Status updates | Full triage of remaining items |
| Archive | Checkpoint, transcript | All transcripts, feedback, handoffs to done/ |
| Ecosystem | Push session feedback | Portfolio notification, registry update |
| Environment | None | Virtual env deletion, data artifact cleanup |

---

## 2. Comprehensive Finalization Checklist

The finalization checklist has nine sections (A through I). Each section
addresses a distinct dimension of project closure. The `/dsm-finalize-project`
skill executes these sections in order; this reference describes the purpose
and rationale for each.

### 2.1. Section A: Knowledge Extraction

Cross-session knowledge that per-session auto-extraction misses. This section
runs a project-level STAA across all archived transcripts, looking for
patterns that span multiple sessions: recurring decision types, methodology
gaps that appeared repeatedly, and techniques that evolved over the project.

Extracted reasoning lessons are classified and routed:
- **Project-specific** lessons stay in the spoke's `.claude/reasoning-lessons.md`
- **DSM-methodology-relevant** lessons are pushed to DSM Central's inbox
- **Reusable patterns** are flagged for the Context Library when available

A context budget gate applies: projects with many transcripts offer sampling
options to avoid exhausting the context window during analysis.

### 2.2. Section B: Retrospective

Structured reflection on the project as a whole, using the templates in
Section 4. The project retrospective covers DSM effectiveness, phase-level
assessment, and cross-project transferability. Epoch retrospectives (if the
project used epoch-based sprints) are checked for completeness.

The retrospective summary is pushed to DSM Central's inbox so that
methodology improvements can be identified from the project's experience.

### 2.3. Section C: Communication

Blog posts, case studies, and public-facing summaries. This section checks
for draft content and offers to create final communication artifacts. It is
only required for large projects but optional for medium ones, recognizing
that not every project warrants public documentation.

### 2.4. Section D: Documentation Closure

Ensures the project's documentation reflects its final state:
- README updated (no "in progress" language, outcomes populated)
- Decision log closed (no open decisions without resolution)
- Guides verified current (no stale references to in-progress work)
- Research files processed (active research moved to done/)

This section prevents the common failure mode where a completed project's
README still reads as if work is ongoing.

### 2.5. Section E: Backlog Cleanup

Triages all remaining backlog items: close completed items, defer valuable
items for future projects, transfer items relevant to other projects, and
drop items no longer relevant. The backlog README is updated to reflect the
final state.

### 2.6. Section F: Vocabulary Transfer

Scans project artifacts (decision records, feedback files, blog posts) for
coined terms or recurring domain-specific language. Candidates are flagged for
DSM vocabulary intake via inbox to DSM Central. Only required for large
projects where new terminology is likely to have emerged.

### 2.7. Section G: Profile and Registry Updates

Updates the contributor profile with skills exercised across the entire
project (not just the final session). Reminds the user to update the DSM_3
Section 7 project registry. Sends a project completion notification to the
portfolio inbox.

### 2.8. Section H: Archive

Moves all session artifacts to their done/ subdirectories:
- Transcripts to `.claude/transcripts/done/`
- Reasoning lessons marked as finalized
- Feedback files to `dsm-docs/feedback-to-dsm/done/`
- Handoffs to `dsm-docs/handoffs/done/`

### 2.9. Section I: Environment and Data Cleanup

Removes build artifacts, virtual environments, and raw/intermediate data that
are no longer needed. A safety gate ensures that Section A (Knowledge
Extraction) has completed before any transcripts or data are deleted.
Processed results and sample data are retained for reproducibility.

---

## 3. Scaling Finalization by Project Size

Not all projects need every checklist section. The scaling table maps project
size (measured by session count) to required and optional sections. This
prevents small projects from bearing the overhead of a full finalization while
ensuring large projects receive comprehensive closure.

### 3.1. Project Size Classification

| Size | Session count | Typical duration |
|------|--------------|-----------------|
| Small | 1-3 sessions | Single-focus work, quick deliverable |
| Medium | 4-10 sessions | Multi-sprint project, iterative work |
| Large | 10+ sessions | Extended engagement, multiple epochs |

### 3.2. Required and Optional Sections by Size

| Section | Small | Medium | Large |
|---------|-------|--------|-------|
| A. Knowledge Extraction | Optional | Required | Required |
| B. Retrospective | Optional | Required | Required |
| C. Communication | Optional | Optional | Required |
| D. Documentation Closure | Required | Required | Required |
| E. Backlog Cleanup | Required | Required | Required |
| F. Vocabulary Transfer | Optional | Optional | Required |
| G. Profile and Registry | Required | Required | Required |
| H. Archive | Required | Required | Required |
| I. Environment Cleanup | Required | Required | Required |

**Rationale for small project minimums:** Small projects (1-3 sessions)
generate limited cross-session patterns, making STAA and retrospectives
low-value relative to their context cost. Documentation closure, backlog
cleanup, archive, and environment cleanup are always necessary to prevent
stale artifacts.

---

## 4. Retrospective Templates for Finalization

Two retrospective templates support the finalization process: one for epoch
boundaries within a project, and one for the project as a whole. Both are
created by the `/dsm-finalize-project` skill and stored in
`dsm-docs/feedback-to-dsm/`.

### 4.1. Epoch Retrospective Template

Used at epoch boundaries within multi-epoch projects. Each epoch covers a
range of sprints and provides a mid-project reflection point.

```markdown
# Epoch N Retrospective

**Project:** [project name]
**Epoch:** N
**Sprints covered:** [sprint range]
**Date:** YYYY-MM-DD

## What worked across sprints
- [Cross-sprint patterns that proved effective]

## What didn't work
- [Approaches that required mid-epoch course corrections]

## Methodology effectiveness
- [Which DSM sections were most/least useful at epoch scale]
- [Any gaps that appeared repeatedly across sprints]

## Key decisions and outcomes
- [DEC-NNN references with retrospective assessment]

## Recommendations for DSM
- [Backlog proposals or methodology observations, if any]
```

### 4.2. Project Retrospective Template

Used once at project completion. Provides the highest-level synthesis of the
project's experience with DSM.

```markdown
# Project Retrospective: [project name]

**Date:** YYYY-MM-DD
**Duration:** [start date] to [end date]
**Sessions:** [count]
**Project type:** [spoke / external contribution / private]

## Project summary
- [What was built, one paragraph]

## DSM effectiveness across the project
- [Which DSM tracks were used: 1.0, 4.0, both]
- [Overall methodology score: how well did DSM serve this project?]

## Phase-level assessment
| Phase | What worked | What was missing |
|-------|------------|-----------------|
| Research/Grounding | | |
| Planning | | |
| Implementation | | |
| Communication | | |

## Cross-project transferability
- [What patterns from this project should inform other projects?]
- [What was project-specific and should NOT be generalized?]

## Recommendations for DSM
- [Backlog proposals, methodology observations, vocabulary candidates]
```

---

## 5. Integration with Other DSM Protocols

Finalization does not operate in isolation. It connects to several existing
DSM protocols and skills, extending them to the project-end scope.

### 5.1. Relationship to Session Wrap-Up

Session wrap-up (`/dsm-wrap-up`, `/dsm-light-wrap-up`) handles per-session
concerns. Finalization handles per-project concerns. They are complementary:
the project's final session runs wrap-up first, then finalization. The
finalization skill verifies that wrap-up has completed before proceeding.

### 5.2. Relationship to Feedback Review

The `/dsm-review-feedback` skill triages feedback files from a completed
spoke project. Finalization's Section A (Knowledge Extraction) and Section B
(Retrospective) produce additional feedback artifacts that
`/dsm-review-feedback` can then process. The recommended sequence for
project closure is:

1. Final `/dsm-wrap-up` (closes the last session)
2. `/dsm-finalize-project` (closes the project, produces retrospective)
3. `/dsm-review-feedback` in DSM Central (triages all feedback including
   finalization outputs)

### 5.3. Relationship to Reasoning Lessons Protocol

The Reasoning Lessons Protocol (DSM_0.2 Module A) defines per-session
extraction and reading of reasoning lessons. Finalization extends this to
project-level scope: the project-level STAA in Section A looks for
cross-session patterns that per-session extraction misses, and routes
DSM-relevant lessons to Central's inbox.

### 5.4. Relationship to STAA

The Session Transcript Analysis Agent (`/dsm-staa`) analyzes individual
transcripts. Finalization's project-level STAA applies the same analysis
across all archived transcripts, looking for patterns that emerge only when
sessions are considered together. For large projects, finalization may invoke
`/dsm-staa` on individual transcripts that were not previously analyzed.

### 5.5. Existing Skills Used During Finalization

The `/dsm-finalize-project` skill delegates to existing skills where
appropriate rather than reimplementing their logic:

| Sub-task | Delegated to | Section |
|----------|-------------|---------|
| Deep transcript analysis | `/dsm-staa` | A |
| Feedback file triage | `/dsm-review-feedback` | A |
| Individual BL closure | `/dsm-backlog-done` | E |
| Ecosystem path resolution | `.claude/dsm-ecosystem.md` | G |