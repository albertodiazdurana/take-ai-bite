# DSM Vocabulary

DSM coins terms as it evolves. Each term names a pattern identified as useful
and valuable through practice: formal principles codified in DSM 6.0, emergent
concepts discovered during spoke projects, and operational guidelines that
compress recurring decisions into reusable heuristics.

Naming patterns makes them transferable, testable, and communicable. The
vocabulary extends DSM's scope from single-session AI-Human collaboration to
ecosystem-level collaboration: one human, multiple agents, multiple projects,
shared infrastructure.

This file is the canonical registry. All terms are formalized here, regardless
of where they originate. Spoke projects reference this file; they do not
maintain separate vocabularies.

## Formal Principles (DSM 6.0)

| # | Term | One-liner | Source |
|---|------|-----------|--------|
| 1.1 | **Take a Bite** | Deliver only what the reviewer can chew | DSM 6.0, TAKE_AI_BITE.md |
| 1.2 | **The Human Brings the Spark** | AI amplifies; the human directs | DSM 6.0 |
| 1.3 | **Earn Your Assertions** | Investigate before you claim, verify before you act | DSM 6.0 |
| 1.3.1 | **Accountability Corollary** | Mistakes are the human's responsibility; the agent's job is to make them unlikely | DSM 6.0 |
| 1.4 | **Understand, Review, Decide** | The user understands first, reviews second, decides third | DSM 6.0 |
| 1.4.2 | **Challenge Myself to Reason** | The agent must justify its own composition before presenting it | DSM 6.0 §1.4.2 |
| 1.5 | **Know Your Context** | The agent is responsible for its own resource consumption | DSM 6.0 |
| 1.6 | **Match the Room** | Contribute proportionally to the project's culture and scale | DSM 6.0 |
| 1.7 | **Own Your Process** | Disclose how the work was produced | DSM 6.0 |
| 1.8 | **Know What You Own** | Verify licensing before deploying any third-party asset | DSM 6.0 §1.8 |

## Emergent Concepts (from spoke projects)

| Term | One-liner | Origin |
|------|-----------|--------|
| **Automation Without Restraint** | Comprehensive output is not the same as useful output | AI-in-DS project (S97) |
| **My Fork, My Rules** | Governance sovereignty inside a fork boundary | Reclaim Launcher (S82-89) |
| **Antifragile from the Smallest Element** | Principles as testable units that strengthen from scrutiny | S98, BL-000 |
| **Ripple Effect** | A human design decision propagates through interconnected projects via agent-mediated infrastructure | S104-106, BL-156 |
| **Collaboration Infrastructure** | Deliberate, versioned, explicit structures that define how an ecosystem works; replaces the imprecise "working culture" | S107, BL-164 |

## Operational and Structural Terms

These terms appear pervasively across DSM documents as if defined, but are
neither formal principles nor emergent concepts. They name the structural
units (spoke, hub, mirror), workflow artifacts (BL, Session Transcript,
inbox entry, reasoning lesson), and protocol primitives (Gate 0-3, Level 3
branch, parallel session, `@` reference) that the methodology runs on.

| Term | One-liner | Source |
|------|-----------|--------|
| **spoke** | A DSM project that depends on DSM Central via the `@` reference chain | DSM_3.0.B, DSM_3.0.E |
| **hub** | A DSM project that other projects (spokes) reference; DSM Central is the canonical hub | DSM_3.0.B |
| **mirror repo** | A spoke that receives a categorized copy of methodology files from Central; tracked via `mirror: true` in the ecosystem registry | DSM_0.2 §18, mirror-sync-manifest.md |
| **mirror sync** | The propagation step that copies Central's methodology files to mirror repos at wrap-up or version release | DSM_0.2 §18, CLAUDE.md Change Propagation Protocol |
| **participation pattern** | The role a project plays in the ecosystem: Standard Spoke, External Contribution, Standalone, Private | DSM_3.0.E |
| **inbox entry** | A unit of cross-project communication delivered to `_inbox/` by another project; processed and moved to `_inbox/done/` after handling | DSM_0.2 §3, Inbox Lifecycle |
| **reasoning lesson** | A behavioral pattern extracted at session wrap-up and surfaced at session start; archived after pruning | DSM_0.2.A Reasoning Lessons Protocol |
| **session branch / task branch / Level 3 branch** | The three working layers of DSM branching: session branch (Level 2, per-session), task branch (Level 3, per-BL or per-sprint), main (Level 1) | DSM_0.2 §20 |
| **parallel session** | A short isolated session running on the shared Level 2 session branch with typed prefix (QA / BL-#) and declared file scope | DSM_0.2.A Parallel Session Protocol |
| **Pre-Generation Brief / Gate 0-3** | The four-gate approval model gating artifact creation: collaborative definition (G0), concept (G1), implementation (G2), run (G3) | DSM_0.2 §8 |
| **Session Transcript** | The append-only reasoning log at `.claude/session-transcript.md` that is the agent's primary reasoning channel | DSM_0.2 §7 |
| **`@` reference** | The CLAUDE.md import directive that recursively pulls referenced files into agent context, the discovery mechanism for DSM_0.2 itself | DSM_0.2 §17 |
| **BL / backlog item** | A single, independently-completable unit of proposed work tracked in `dsm-docs/plans/` | DSM_0.2 §21, CLAUDE.md Change Tracking Workflow |
| **Cloned-Mirror Kick-off** | The first-session bootstrap protocol on a fresh mirror clone that promotes `.template` files to runtime paths | DSM_0.2.A Cloned-Mirror Kick-off Protocol |

## Guidelines (operational)

| Term | One-liner | Source |
|------|-----------|--------|
| **Environmental Awareness** | Prefer sufficient over maximal | DSM 6.0 Section 2.3 |
| **The Three-Question Test** | Can the reviewer read, opine, and redirect? | DSM 6.0 Section 2.4 |
| **Questions or Suggestions (Q or S)** | When the human invites questions or suggestions, the agent engages in bidirectional critical thinking rather than passively proceeding | S128 |

## Contribution Path

When a spoke project coins a term:
1. Capture it in a feedback file (per DSM Feedback Tracking)
2. Push to DSM Central's inbox
3. DSM Central evaluates and, if accepted, adds it here
4. DSM Central notifies the originating spoke

## Entry Guidelines

- Each term should have a recognizable trigger ("when you see X, apply Y")
- One-liners must be self-contained: understandable without reading DSM_6.0
- Origin traces the term to the session or project where it emerged
- Extended definitions (when needed) go below the table as subsections
