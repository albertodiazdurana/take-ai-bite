# DSM_0.2 Module D: Research & Onboarding

**Parent:** DSM_0.2_Custom_Instructions_v1.1.md
**Loaded:** On demand, when the agent needs a protocol from this module
**Reference:** Module Dispatch Table in DSM_0.2 core

This module contains research, onboarding, and governance protocols:
breaking change notifications, external descriptions, situational assessment,
research methodology, environment preflight, new project prompts, phase mapping,
and command file tracking. The agent reads this file via the Read tool when a
protocol listed in the dispatch table is needed.

---

## Breaking Change Notification Protocol

When DSM_0.2 introduces a breaking change, DSM Central must notify all spoke projects
and external contributions so they can update their Protocol Applicability tables.

**What counts as a breaking change:**
- New mandatory protocol added (e.g., Session Transcript Protocol)
- Existing protocol behavior modified in a way that changes agent actions
- Protocol removed or deprecated

**What is NOT a breaking change:**
- Additive/optional sections (new guidance that does not change default behavior)
- Clarifications or rewording without behavioral change
- Bug fixes to existing protocols

**Hub action (when making a breaking change):**

1. Update the `Last Breaking Change` line in the DSM_0.2 header
2. Send an inbox entry to every spoke project and external contribution:

```markdown
### [YYYY-MM-DD] DSM breaking change: {protocol name}

**Type:** Action Item
**Priority:** High
**Source:** DSM Central

DSM_0.2 updated from vX.Y.Z to vA.B.C. Breaking change:

**What changed:** {description of the new or modified protocol}
**Action required:** Update your Protocol Applicability table in `.claude/CLAUDE.md`
to declare whether this protocol applies to your project. Until updated, the agent
will surface this gap at session start rather than executing the protocol silently.

Reference: CHANGELOG.md vA.B.C entry
```

3. List affected spoke paths from the project registry (DSM_3 Section 7)

**Grace period (spoke-side, enforced by agent):**

At session start, if the DSM version has changed since the last handoff AND the spoke's
Protocol Applicability table does not list a protocol that was added or modified in the
intervening versions, the agent must:
1. Surface the gap: "Protocol {name} was added in vX.Y.Z but is not in your Protocol
   Applicability table"
2. Ask the user whether to apply, skip, or defer the protocol for this session
3. Do NOT execute the protocol silently

This ensures no protocol runs in a spoke without the human's awareness and explicit
decision. See DSM_3 Section 6.4.6 for the spoke-side handling process.

---

## External DSM Descriptions

When describing DSM in external-facing documents (job applications, portfolio,
blog posts, LinkedIn), use the canonical descriptions in **DSM_3 Section 7**
rather than composing from scratch. That section provides short, medium, and
full versions with critical framing rules that prevent misattribution.

---

## Step 0: Situational Assessment

Before research or implementation, understand the situation: governance,
dynamics, contribution model, and codebase structure. This is the most
impactful preparatory work for new projects, especially external contributions.

**When to apply:**
- **External contributions:** Mandatory. The governance landscape, owner
  dynamics, and contribution model are critical and non-obvious.
- **New spoke projects:** Recommended when the domain or toolchain is
  unfamiliar.
- **Continuation projects:** Skip; the assessment was done at onboarding.

**Assessment checklist:**

1. **Governance landscape:** What governance, conventions, and agent
   configurations exist? Who decides what? (CLAUDE.md, AGENTS.md,
   CONTRIBUTING.md, CI/CD rules)
2. **Owner/team dynamics:** Solo developer vs team? What is their
   relationship to the project? What constraints do they face?
3. **Contribution model:** How does this project accept contributions?
   PRs, issues, discussions? What is the review cadence?
4. **Codebase orientation:** Incremental understanding (Take a Bite),
   not comprehensive mapping. Each session absorbs only what the current
   task requires. See DSM_3 Section 6.6.9 for systematic codebase analysis.
5. **Governance boundary decisions:** Where does your governance start
   and end? (e.g., "my fork, my rules" for external contributions)

**Relationship to Phase 0.5:** Step 0 answers "what am I walking into?"
Phase 0.5 answers "what do I need to learn about the topic?" Step 0
completes before Phase 0.5 begins.

---

## Phase 0.5: Research and Grounding (Optional)

Before sprint planning, consider whether a research phase would strengthen the project:

**When to apply:**
- Novel technique or domain
- Model or library selection required
- Unfamiliar problem space where prior art informs architecture
- Wrong initial direction would be costly to reverse

**When to skip:**
- Well-understood domain with established patterns
- Follow-up projects using proven approaches
- Small scope where research overhead exceeds benefit

**Scale-aware research:** Phase 0.5 applies at every planning scale, not only
project-level. The agent assesses uncertainty when receiving a planning request
at any scale and suggests research when unresolved uncertainty exists:

| Planning unit | Research depth | Output |
|--------------|---------------|--------|
| Feature | ~10 minutes, inline in session | Decision noted in transcript |
| Sprint | Targeted research doc in `docs/research/` | Findings inform sprint plan |
| Epoch/project | Full Phase 0.5 with checkpoints | Research file + validation gate |

**Proactive suggestion:** When the agent detects uncertainty in a planning
request (unfamiliar technology, multiple viable approaches, assumptions that
need validation), it suggests a research phase before drafting the plan. The
user decides whether to proceed with research or plan directly.

**Tiered research pattern:** Research naturally tiers when an initial pass
produces a decision but leaves implementation-level unknowns unresolved:

```
Idea → Broad Research → Decision → [Assessment gate] → Plan → Action
                                        ↓
                              "Can I detail the scope enough
                               for a concrete plan with
                               actionable items?"
                                        ↓
                              If no: Deep-Dive Research → Plan → Action
```

This is not two mandatory phases; it is one gate with optional depth refinement.
The assessment question is: "Can I now describe the scope in enough detail to
build a concrete plan with actionable items (requirements, breakdown, tasks)?"

**Applies to all uncertainty types:**

| Uncertainty type | Broad research example | Deep-dive trigger |
|-----------------|----------------------|-------------------|
| Technical | Evaluate databases → select one | Selected DB has unresolved API/limitation questions |
| Conceptual | Survey design approaches → select one | Selected approach has unvalidated assumptions |
| Domain | Research business rules → establish requirements | Requirements have ambiguities needing clarification |

**Research execution steps:**

1. **Gather sources:** Identify all relevant inputs: project docs, external references,
   community discussions, ecosystem research, codebase analysis (see DSM_3 Section 6.6.9
   for systematic codebase analysis). Cast a wide net before filtering.
2. **Consume and cluster:** Read all sources and cluster findings by **topic**, not by
   source. This prevents siloed summaries and surfaces cross-source patterns. Move
   consumed reference files to `docs/research/done/` as they are processed.
3. **Synthesize:** Write a consolidated synthesis document in `docs/research/` organized
   by topic cluster. Each cluster should have findings, evidence, and implications for
   the target outcome. Cite all sources with full metadata per DSM_0.1 Citation
   Standards: author, title, institution/publisher, date, and URL where available.
   URLs alone are insufficient; metadata ensures traceability when links break and
   provides attribution for downstream publication.
4. **Validate:** Check the synthesis against the stated Purpose/Target Outcome (from the
   research file header) before proceeding to the target artifact. This is the validation
   gate defined below.
5. **Re-validate (at implementation time):** When there is a time gap between research
   and implementation (separate sessions, upstream activity between sessions), re-read
   the target files and confirm the research findings still hold before implementing.
   Codebases evolve; research conclusions can become stale or wrong. If findings are
   invalidated, update the research document and its `**Last Validated:**` date before
   proceeding. Frame early research as a starting map that requires re-validation, not
   as fixed conclusions.

**External contribution extension:** When research targets an upstream-facing document
(PR description, contribution guide, issue report), add:
- **Tone calibration:** Read 3+ writing samples from the project (README, CONTRIBUTING,
  PR reviews, blog posts) to match the project's communication style
- **Citation scope restriction:** Upstream-facing documents cite public URLs only, never
  DSM internal file paths. Internal research files may cite DSM paths freely.

**Deliverable:** `docs/research/{topic}_research.md` with findings, citations, and
implications for project design. Research should directly inform the sprint plan.

**Research file header:** All research files should include:

```markdown
# Research: [Topic]

**Purpose/Question:** [What this research must address or answer]
**Target Outcome:** [What artifact this will produce: plan, decision, backlog item, etc.]
**Status:** Active | Validated | Done
**Date Created:** YYYY-MM-DD
**Last Validated:** YYYY-MM-DD (updated when re-validation confirms or corrects findings)
**Date Completed:** YYYY-MM-DD (when processed)
**Outcome Reference:** [Link to the artifact produced from this research]
```

**Validation gate:** Before processing research into an outcome, confirm:
- Does the research address the stated purpose or answer the question?
- Are there gaps that need additional research?
- Is the evidence sufficient to support the target outcome?

**Source verification (after drafting, before review):** When research produces a
draft document (upstream PR, guide, report, blog post), verify that every factual
claim in the draft traces to a specific source in the research synthesis. Flag any
claim that cannot be traced as "unsourced" and either find a source or remove the
claim. This gate is especially critical for upstream-facing documents where
inaccurate claims damage contributor credibility.

**done/ convention:** When research has been processed into its target outcome,
complete this checklist before moving the file to `docs/research/done/`:

1. Set `Status:` to `Done`
2. Fill in `Date Completed:` with today's date
3. Fill in `Outcome Reference:` with the artifact(s) produced from this research
4. Verify the referenced outcome artifact exists (file path or URL)

Do not move files to done/ without completing this checklist. This keeps the
active research directory clean and provides traceability from research to
outcome. See DSM_0.1 for the full done/ convention across all docs/ folders.

**Research phase guard:** Research can expand without bound. To prevent unbounded
exploration, checkpoint after each distinct cluster of findings:

1. **Gather** sources on a specific sub-question
2. **Synthesize** findings into the research file
3. **Checkpoint:** Present a summary to the user before moving to the next sub-question
4. **Go/no-go:** The user decides whether to continue exploring, redirect, or move to
   the outcome phase

This applies the Session Delivery Budget at the research level: each checkpoint is a
reviewable "bite" of research. Without checkpoints, the agent may produce a 2,000-line
research file that the user cannot meaningfully review.

**Anti-Patterns:**

**DO NOT:**
- Start research without a stated purpose or question; undirected research produces notes, not outcomes
- Leave consumed research in the active directory; move to done/ with outcome reference
- Skip the validation gate; unvalidated research leads to plans built on incomplete evidence
- Accumulate research across multiple sub-questions without checkpointing; the user cannot redirect what they have not reviewed
- Introduce unsourced claims in research-derived drafts; fluent prose drifts from sourced facts into inference without a verification gate. Every factual claim must trace to a specific source
- Implement from research findings without re-reading target files when sessions have passed; the codebase may have evolved, invalidating conclusions

**Ad-hoc research documentation:** Phase 0.5 covers planned research phases.
Research also happens incidentally during implementation: web searches to
understand API behavior, reference implementation analysis, trade-off
comparisons to inform a design choice. These findings must persist beyond the
session transcript.

**Trigger:** When the agent conducts research involving web searches, external
source analysis, or multi-source comparison to inform a task, write a structured
document to `docs/research/` as part of the research process, not after. Use the
standard research file header (Purpose, Target Outcome, Status, dates). The
session transcript captures reasoning; the research artifact captures conclusions
for future sessions.

**Threshold:** Apply when findings would take more than 5 minutes to reconstruct
from scratch in a future session. Single-fact lookups (a function signature, a
config value) do not need a research artifact.

**Relationship to Phase 0.5:** Phase 0.5 is a planned phase with checkpoints and
validation gates. Ad-hoc research documentation is a lightweight trigger with no
gate; the agent writes the artifact and continues. Both use the same file
conventions (`docs/research/`, standard header, done/ convention).

---

## Environment Preflight Protocol (Optional)

Projects with native toolchains (Android/Kotlin, C/C++, Rust with system deps,
embedded development) have system-level dependencies that surface one at a time
during build or runtime, causing iterative "install, retry, hit next error" cycles.
This protocol resolves all blockers in one pass at project onboarding.

**Applicability:**
- **Required for:** Projects with native binaries, compiled dependencies, or
  system-level runtime requirements
- **Optional for:** Pure Python projects (covered by Section 2.1)
- **Skip for:** Documentation-only projects

**Preflight checklist (run once at project onboarding):**

1. **Identify native binaries:** List executables the project depends on
   (emulators, compilers, runtimes, database servers)
2. **Check shared library dependencies:** `ldd <binary>` for each native
   binary; identify all missing libraries upfront
3. **Check runtime permissions:** Device access (`/dev/kvm`, `/dev/usb`),
   group memberships, filesystem permissions
4. **Check build tools:** Compiler versions, SDK paths, JDK versions,
   platform-specific requirements (e.g., WSL2 for Android emulation)
5. **Resolve all blockers in one pass** before proceeding to build or test

**Evidence:** In an Android/Kotlin external contribution, 5 missing library
blockers were discovered across 2 sessions, each one at a time. A single
`ldd` check on the emulator binary would have found all shared library
dependencies upfront.

**Anti-Patterns:**

**DO NOT:**
- Skip the preflight for projects with native dependencies; iterative
  discovery wastes sessions and context budget
- Assume the development environment is complete because the project
  README does not mention system dependencies; many projects assume
  a standard development setup

---

## First Session Prompt for New Projects

When a new DSM spoke project is scaffolded, it starts with a preliminary plan in
`docs/research/`. The first session in the project should follow a research-to-plan
pipeline before any implementation begins. Send this prompt as an inbox entry to the
spoke project's `_inbox/`. It is a hub-to-spoke action item (arrives, gets processed,
gets deleted), not a session continuity document.

See DSM_3 Section 6.7.1 for the full inbox entry template with metadata fields.

The prompt content:

```
This is a DSM ecosystem project. Read `.claude/CLAUDE.md` for methodology
and interaction protocols.

Read the preliminary plan in `docs/research/` to understand the project
goals and initial design direction.

Based on the preliminary plan:
1. Do extensive research to validate and expand on the plan. Document
   findings with citations in `docs/research/`.
2. Create a project plan in `docs/plans/` covering scope, phases,
   deliverables, and success criteria.
3. Present the plan for review and approval before starting implementation.
4. Create AI collaboration norms in `docs/guides/ai-collaboration.md`
   (see DSM_3 Section 6.7.3).
```

**Why this order matters:** The preliminary plan captures initial intent but may lack
research backing. The agent validates assumptions, fills gaps with cited research,
then produces a concrete plan the user can approve. No implementation begins until
the plan is approved.

**Plan abstraction calibration:** Plan at the level of abstraction that matches
current certainty. For phases where key information is not yet available (e.g.,
preprocessing details before EDA reveals data characteristics), define objectives
and success criteria rather than implementation details. Over-specifying before
exploration leads to plan revisions that waste context.

---

## Phase-to-DSM-Section Mapping

When planning sprint phases, reference the appropriate DSM sections:

| Phase Type | Core Sections | Advanced (if applicable) |
|------------|---------------|--------------------------|
| Setup / Environment | 2.1, Appendix A | -- |
| Exploration / EDA | 2.2, Appendix B.2 | -- |
| Feature Engineering | 2.3 | -- |
| Analysis / Modeling | 2.4 | -- |
| Evaluation / Benchmarking | 2.4, DSM 4.0 Section 4.4 | Appendix C.1.3 (Experiments), C.1.5 (Limitations), Section 5.2.1 (Tracking) |
| Communication | 2.5 | Section 2.5.9 (Blog Style Guide) |

For evaluation phases, check Appendix C.1 for experiment templates before building
custom evaluation harnesses.

**Blog pipeline quick reference:** The blog content pipeline uses three document
types in `docs/blog/`:

| Stage | File | Purpose |
|-------|------|---------|
| Capture | `journal.md` (append-only) | Raw observations, stories, insights as they occur |
| Structure | `YYYY-MM-DD_materials-{scope}.md` | Organized content with audience, key points, evidence |
| Publish | `YYYY-MM-DD_draft-{scope}.md` | Final prose ready for publication |

For the full Blog Style Guide (tone, structure, editorial standards): read
DSM_1.0 Section 2.5.9 on demand. Projects that heavily use the blog pipeline
should reinforce the full template in their project CLAUDE.md.

---

## Command File Version Tracking

All DSM command files (user-level and project-level) have their canonical source
in `scripts/commands/` within DSM Central. The sync script deploys them to their
runtime locations.

**Edit flow:** When modifying a DSM command file:

1. Edit the tracked source in `scripts/commands/{command}.md`
2. Deploy to runtime: run `scripts/sync-commands.sh --deploy`
3. Commit the tracked source alongside the methodology changes it implements

The agent must NOT edit runtime copies directly for DSM commands:
- `~/.claude/commands/dsm-*.md` (user-level commands)
- `.claude/commands/dsm-*.md` (project-level commands, gitignored as deploy artifacts)

Non-DSM commands (if any) in either location remain untracked and are edited directly.

**Drift detection:** `/dsm-align` step 9 compares tracked sources against
runtime copies and reports mismatches. Run `scripts/sync-commands.sh --check`
to see drift details without modifying files.

**Runtime targets:**

| Command type | Runtime location | Example commands |
|-------------|-----------------|------------------|
| User-level | `~/.claude/commands/` | dsm-go, dsm-wrap-up, dsm-light-go, dsm-light-wrap-up, dsm-align, dsm-staa |
| Project-level | `.claude/commands/` | dsm-backlog, dsm-checkpoint, dsm-version-update |

**Anti-Patterns:**

**DO NOT:**
- Edit runtime command copies directly; edit `scripts/commands/` and sync
- Forget to sync after editing tracked sources; the runtime copy will be stale
- Commit project-level runtime copies; they are gitignored deployment artifacts

Reference: BACKLOG-130 (Phase A), BACKLOG-131 (Phase B)
