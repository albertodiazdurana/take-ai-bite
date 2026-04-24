# DSM 6.0: AI Collaboration Principles

**Version:** 1.0
**Date:** February 2026
**Purpose:** Define the principles that govern human-AI collaboration in DSM projects.

---

AI can write faster than any human can read. That asymmetry is the central
challenge of human-AI collaboration: not whether the AI can produce, but
whether the human can keep up.

DSM's position is that the human must always keep up. Not because AI output
is untrustworthy, but because the human contributes something the AI cannot
generate on its own: direction, experience, intuition, aesthetic judgment,
and the sense of when something is right. The human provides the spark of the
work. AI magnifies, amplifies, and expands. It is a productive dichotomy, but
only when balanced. It feeds and nurtures when the proportions are right. It
controls and chokes in excess.

The principles below exist to maintain that balance.

---

## 1. Principles

### 1.1 Take a Bite

**Deliver only what the reviewer can chew.**

The amount of work an agent produces in a single delivery, whether a notebook
cell, a file, a PR, or a session's worth of artifacts, must not exceed what
the reviewer can engage with and respond to with substance. If the best the
reviewer can say is "oh wow, impressive... but ok, I trust you," the delivery
was too large.

The test is not about counting artifacts. A single file can be too much if
it's 500 lines of dense logic. Three files can be fine if they're small and
self-explanatory. The test is cognitive: can the reviewer read it, understand
it, form an opinion, and redirect if needed?

When the delivery exceeds that threshold, the collaboration silently degrades.
The human stops reviewing and starts approving. The "human in the loop"
becomes decorative. The spark goes missing from the work.

This principle applies to tool output too, not just deliverables. Automated
tools (profiling reports, linting summaries, test suites) can generate hundreds
of data points in seconds. When the agent runs every available tool because it
can, not because the output serves the next step, the result is info-dumping:
the human scrolls instead of analyzing. Generate only what you can meaningfully
process in the next step. Comprehensive reports serve as reference material and
safety nets ("did we miss anything?"), not as the analysis itself.

See `TAKE_AI_BITE.md` for the short version.

### 1.2 The Human Brings the Spark

**AI amplifies. The human directs.**

The human plans, perceives, senses when something is off, guides the work,
and provides what no model can generate: the lightness, the aesthetic, the
style, the tone. These are not nice-to-haves; they are the difference between
work that is correct and work that is right.

AI is exceptionally good at producing volume, finding patterns, and executing
known procedures. It is not good at knowing when to stop, when the tone is
wrong, or when the technically correct answer misses the point. Those
judgments require the human to be present, not just in the loop but actively
engaged with the material.

This principle is why "Take a Bite" matters: if the delivery is too large for
the human to engage with, the human's unique contribution, the spark, gets
bypassed.

### 1.3 Earn Your Assertions

**Investigate before you claim. Verify before you act.**

Neither the human nor the agent gets to assume. Every assertion should be grounded
in context that was actually built, not borrowed from intuition alone. When the agent
presents a fact, it should be something it checked. When the human approves a
delivery, it should be because they reviewed it. When either side says "this is how
it works," they should have looked.

Context is the foundation for both sides. The agent builds context by reading the
codebase, researching the domain, and checking actual outputs. The human builds
context by reviewing prior art, understanding the problem space, and verifying
results. Neither should act from a vacuum.

This means:
- Research state of the art before assuming novelty; someone likely solved a
  similar problem, and their experience shortens the path
- Cite sources and references; assertions that trace back to evidence are
  stronger than assertions that trace back to confidence
- Explore the codebase before proposing changes
- Research the domain before building
- Verify consequences before executing destructive commands
- Report actual values, never estimates
- Test, experiment, and validate with real data, not just read the summary

The alternative, asserting without checking, compounds silently. One unchecked
assumption becomes the foundation for the next, until the work looks solid but rests
on nothing verified.

**Accountability corollary:** The human who submits the work is the author of
record, regardless of which tools produced it. AI is an instrument; the human
bears responsibility for correctness, completeness, style, and impact. "The AI
wrote it" is not a defense for errors, omissions, or harm. This responsibility
is not diminished by the quality of the AI's output; it is established by the
act of submitting the work under your name. Review is not optional when the
stakes include your professional credibility.

### 1.4 Critical Thinking

**Question your own reasoning before asking others to trust it.**

Self-regulation, thinking about your own thinking, is what distinguishes critical
engagement from passive processing. It is the deliberate act of questioning,
confirming, validating, or correcting one's own reasoning before acting on it
(Facione, 1990). It is the meta-skill that makes all other skills trustworthy.

Critical thinking in collaboration is bidirectional. The human understands first:
the vision, the plan, the direction. The agent follows that plan and examines its
own choices before presenting them. The human examines what is presented before
approving it. Both sides exercise purposeful, self-regulatory judgment, but the
human sets the course.

When either side skips this step, the collaboration degrades silently. The agent
that presents without self-challenging produces work that looks complete but
has not been stress-tested. The human who approves without scrutinizing
creates a loop where oversight exists in form but not in substance.

#### 1.4.1 Understand, Review, Decide

**The human understands first, reviews second, and decides third.**

This is DSM's core interaction loop. Before any approval, the human must
understand what was done and why. Before any decision, the human must have
reviewed the actual output. Skipping steps, approving without understanding,
deciding without reviewing, breaks the collaboration even when the output
happens to be correct.

In practice this means:
- The agent follows a plan that the human has reviewed and approved
- The agent explains before it acts (pre-generation briefs) and waits for
  agreement
- The agent delivers in reviewable increments (Take a Bite)
- The agent waits for the human's substantive response before continuing
- "Continue" is a valid response only when the human has seen and understood
  the previous output

#### 1.4.2 Challenge Myself to Reason

**Before presenting a choice, challenge why you made it.**

This principle applies symmetrically. For the agent: before presenting a design,
a collection of items, or a sequence of edits, ask yourself why this composition
and not another. What requirement does each piece trace to? What did you consider
and exclude? What are you assuming? The goal is not to produce a defense, but to
surface the reasoning so the human can evaluate it alongside the output.

For the human: before approving, ask what would need to be different for you to
reject this. If you cannot articulate a reason to say no, you may not have
examined the work closely enough. The question "why not something else?" is as
valuable as "why this?"

- **Agent self-regulation:** "I proposed six tests. Why six? Each traces to a
  specific requirement. I considered a seventh for edge cases but excluded it
  because the edge case is already covered by test three." Present this reasoning
  proactively, not only when challenged.
- **Human self-regulation:** "I am about to approve this. Do I understand what
  each piece does? Could I explain to someone else why this is the right
  approach? If not, I need to ask before approving."

The operational protocols that implement this principle, Composition Challenge
for multi-item artifacts and Edit Explanation Stop for intra-file edits, live in
DSM_0.2.

### 1.5 Know Your Context

**The agent is responsible for its own resource consumption.**

An AI agent operates within constraints: context window size, session
duration, the user's available review time. A responsible agent is aware of
these constraints and manages them proactively rather than consuming resources
until they run out.

This means:
- Estimating context impact before reading large files
- Warning when context is running low, with options to scope down or wrap up
- Splitting large reference material into manageable pieces
- Planning session scope proportional to available resources

The alternative, charging ahead until the context overflows and hoping the
recovery mechanism works, is reactive. It wastes the user's time and
degrades the quality of the session's second half.

### 1.6 Match the Room

**Contribute proportionally to the project's culture and scale.**

When collaborating with an external project, the contribution should match
the project's existing style, conventions, and pace. A project that reviews
30-line PRs should not receive a 500-line PR. A project with a minimalist
README should not receive a verbose policy document. A project that values
concise commit messages should not get essays.

This principle extends "Take a Bite" to the social dimension: the "reviewer"
is not just the DSM user, but the upstream maintainer, the community, and
anyone who encounters the contribution.

**Guardrail: Inclusive Language.** Matching the room does not mean silently
adopting language that conflicts with DSM's inclusive language standards
(DSM_0.2). If an external project's conventions include language that DSM
would avoid (violence-implying, gendered, political, religious, or
superiority-implying), the agent must surface the conflict to the human and
obtain explicit approval before adopting that language. The human decides
consciously; the agent does not decide on their behalf.

**Governance boundary: My Fork, My Rules.** When contributing to an external
project through a fork, the contributor operates in two governance worlds
simultaneously. Match the Room governs the outward dimension: contributions
conform to upstream conventions, style, and review expectations. The inward
dimension, governance sovereignty, is equally important: inside the fork, the
contributor maintains their own methodology (DSM) as the active governance
system. These two dimensions are complementary, not contradictory; the
contributor translates deliverables to match each context while keeping their
own process intact.

When the upstream project has its own AI governance artifacts (CLAUDE.md,
copilot instructions, AI policy documents), these are reference material, not
active instructions. The contributor renames them (e.g., `CLAUDE.md.upstream`)
to prevent tool conflicts, studies them to understand upstream expectations,
and ensures their own governance remains sovereign. The upstream's AI governance
informs what the contribution should look like; the contributor's governance
determines how the work is produced.

Evidence: an external contribution project maintained DSM governance in a fork
with its own CLAUDE.md while all PRs merged upstream with zero governance
leakage. The contributor acted as intermediary between two governance worlds,
translating deliverables to match each context.

See DSM_3 Section 6.6.10 (Fork Governance Isolation) for operational guidance
including file handling, conflict resolution, and anti-patterns.

### 1.7 Own Your Process

**Disclose how the work was produced. The human decides the level of detail.**

When AI contributes to a deliverable, the people who receive that deliverable
deserve to know. Not because AI involvement is a deficiency, but because
transparency about production methods is a professional obligation. A reviewer
who knows AI was involved reviews differently than one who assumes manual work.
A maintainer who knows a PR was AI-assisted can calibrate their expectations.
Concealing the method undermines trust even when the output is flawless.

DSM's position: default to disclosure. The question is not whether to disclose,
but how much detail the context requires.

**Decision framework:**

| Context | Disclosure level | Example |
|---------|-----------------|---------|
| External contribution (PR, issue, upstream commit) | Explicit: state AI involvement in PR description or commit message | "AI-assisted: Claude used for implementation, human reviewed and tested" |
| Published artifact (blog post, documentation, report) | Explicit: note in artifact or metadata | "Written with AI assistance" or project-level AI collaboration document |
| Internal DSM work (spoke project, methodology) | Implicit: Session Transcript and commit history provide the record | No additional disclosure needed; the process is self-documenting |
| Exploratory work (notebooks, scratch analysis) | Optional: disclose if sharing results externally | Personal workflow; disclose when outputs leave the notebook |

**What to disclose:**
- Which tool was used (model name, not version unless relevant)
- The nature of AI involvement (generation, review, editing, research)
- What the human contributed (direction, review, domain judgment, testing)

**What NOT to disclose:**
- Exact prompts or conversation transcripts (these are process artifacts, not
  deliverables; sharing them may expose proprietary methods or internal context)
- Token counts or cost metrics (irrelevant to the recipient)

**Relationship to other principles:** Own Your Process complements Earn Your
Assertions: EYA ensures the work is verified; OYP ensures the method is
transparent. Together they establish that the human is both the quality gate
and the accountable party, regardless of which tools were used in production.

**External frameworks context:** Disclosure norms are forming rapidly. The EU AI
Act (2024) introduces transparency obligations for AI providers. Research on
open source AI attribution (arXiv:2512.00867) shows explicit disclosure
increasing from near-zero in early 2024 to 40% by late 2025. DSM aligns with
this trajectory by making disclosure the default rather than the exception.

See DSM_3 Section 6.7.3 (AI Collaboration Norms) for project-level
instantiation of this principle.

### 1.8 Know What You Own

**Verify licensing before deployment. Free tier does not mean free use.**

Any material produced by or sourced through a third-party tool can carry
licensing restrictions that surface after deployment. AI-generated images,
stock photos, fonts, code snippets from AI assistants, data from APIs, and
documentation from copyrighted sources all carry the same risk. The common
failure mode: asset created, deployed, licensing reviewed later (or never),
rework required across multiple deployment targets.

The risk is especially acute for AI-generated assets. Free tiers of
generative tools routinely retain full ownership of outputs. Paid tiers
grant commercial use. The same tool, different tier, different rights. This
is not disclosed prominently, and the defaults favor the tool vendor.

**Due diligence checklist (before any public deployment):**

1. **Verify licensing for the specific tool and tier.** Free tier vs. paid
   tier often differ. Check the current terms; they change. Do not rely on
   what the terms were when you last checked.
2. **Document** the tool, tier, date terms were verified, and any
   restrictions. Record this alongside the asset (e.g., in a creation log,
   `dsm-docs/assets/` manifest, or inline in the session transcript).
3. **Flag high-risk scenarios:**
   - Free tier with no commercial use rights
   - Tool retains ownership of generated outputs
   - Public gallery clause (your output may appear in the tool's showcase)
   - Attribution required for use
   - Terms changed recently (check change history if available)

**Scope:** applies to all public-facing deliverables. Internal artifacts
(session transcripts, draft documents, personal analysis) do not require
the same review, but treat them as restricted until verified if they may
become public.

**When to apply:** at asset creation time, not at deployment time. The
cost of discovery at deployment is always higher: assets are embedded in
multiple locations, social media previews are cached, blog posts are
indexed.

**Relationship to other principles:** Own Your Process (1.7) covers
disclosure of how work was produced. Know What You Own covers the legal
status of what was produced. Both apply when AI is in the production
chain; 1.7 addresses the human's accountability to the audience, 1.8
addresses the human's accountability to the asset's licensor.

**Evidence:** A logo generated via Recraft AI's free tier was deployed
across blog, GitHub, and LinkedIn. Recraft's free tier retains full
ownership of generated images (policy effective 2024-08-12). Discovery
required replacement across 6+ deployment targets (favicon, navigation
bar, OpenGraph, social preview, GitHub repository image, LinkedIn post).
Full incident documented in the affected spoke project's governance folder.

### 1.9 Think Ahead

**Build the map before you walk the territory. Strategy emerges from operational
maturity, not before it.**

A collaboration framework that grows organically will eventually outpace its own
ability to prioritize. Features accumulate, backlog items self-generate (each
implementation surfaces observations that become new items), and the question
shifts from "what can we build?" to "what should we build next, and why?" This
is the signal that strategic planning is no longer optional; it is an emergent
requirement of the system's own complexity.

The instinct is to plan early. Resist it. Strategic planning requires material
to plan with: operational foundations that work (so you know what "done" looks
like), governance infrastructure that scales (so you can track what exists),
philosophical clarity about what you value (so you can weigh trade-offs), and
learning mechanisms that feed back into decisions (so plans stay connected to
reality). Without these layers, a roadmap is speculation with formatting.

The progression is not arbitrary:

1. **Operational:** build the guidelines, templates, and conventions that make
   work repeatable
2. **Infrastructure:** build the governance systems (backlogs, versioning,
   hub-spoke routing) that track what exists
3. **Philosophical:** articulate the principles that explain why you work this
   way, not just how
4. **Learning:** build the mechanisms (experiments, feedback loops, reasoning
   extraction) that make the collaboration improve over time
5. **Strategic:** build the roadmap that directs which operational work to
   prioritize, informed by everything above

Each layer enables the next. Strategic thinking closes the loop: vision informs
which operational work to prioritize, and operational results feed back through
the learning layer to refine the vision.

**Maturity indicators** (signals that strategic planning is warranted):

| Signal | What it means |
|--------|---------------|
| Backlog self-generation | Implementations produce more items than they consume; the system creates work faster than it can finish |
| Dependency clusters | Items block each other; sequencing matters and is no longer obvious |
| Phase ambiguity | New items cannot be prioritized without knowing the project's strategic direction |
| Audience expansion | External stakeholders appear; communication priorities must be weighed against internal priorities |
| Ecosystem growth | Multiple repos, projects, or contribution streams compete for attention |

**What this means in practice:**
- Do not create a roadmap in the first week. Build, learn, reflect, then plan.
- When the backlog starts self-generating, treat it as a maturity signal, not a
  problem. The system is producing more work because it has enough operational
  depth to see what is missing.
- Strategic planning is a living activity, not a one-time document. Review the
  roadmap at regular intervals (sprint boundaries) and let operational experience
  update the plan.
- The roadmap's value is not prediction; it is alignment. It answers "why this
  item next?" so that individual sessions connect to a larger arc.

**Relationship to other principles:** Think Ahead complements Take a Bite (1.1):
where Take a Bite governs the size of individual deliveries, Think Ahead governs
the sequence and direction of deliveries over time. It also depends on the
learning layer: without Earn Your Assertions (1.3) and Critical Thinking (1.4),
strategic plans lack the epistemic discipline to distinguish aspiration from
evidence.

**Evidence:** DSM's own evolution from a single methodology document (November
2025) to a 14-repo ecosystem with 83 documented features, 796 commits, and a
38-item strategic roadmap (March 2026). The roadmap system was not
planned at the start; it emerged when the backlog reached ~30 active items and
the acceleration curve (0.7 → 10.1 commits/day) made ad-hoc prioritization
unsustainable. Full analysis: `dsm-docs/research/2026-03-16_dsm-evolution-git-history-analysis.md`
and `dsm-docs/research/2026-03-16_dsm-feature-inventory.md`.

### 1.10 We Need to Talk

**The conversation that defines the work IS the collaboration, not a preamble
to it.**

When a complex task arrives, the instinct is to plan quickly and start building.
The agent drafts a proposal, the human says "yes" or "no," and work begins. This
feels efficient. It is not. The proposal carries assumptions about scope,
dependencies, and packaging that the human never shaped. The "yes" is not
approval; it is acquiescence to a structure the human did not co-create.

The quality of collaboration is determined by the quality of the conversation
that precedes the work. When the human is invited to confirm threads ("are these
the right topics?"), analyze dependencies ("which must come first?"), and package
units ("how should we group these?"), they are not approving a plan. They are
building one. Each step creates a decision point where the human's knowledge,
context, and judgment actively shape what will be built.

The difference is subtle but structural:

- **Approval-seeking:** Agent presents a finished plan. Human approves or
  rejects. The human's contribution is a boolean: yes or no.
- **Collaborative definition:** Agent and human build the plan together in
  steps. The human's contribution is directional: "not those threads, these
  threads," "that dependency is wrong," "package these two together."

When the agent presents a pre-formed plan and asks for approval, it reduces
the human from collaborator to approver. The "human in the loop" becomes a
rubber stamp. The collaboration loses the human's most valuable input: the
ability to reframe the problem before the first line of work begins.

This principle applies to every entry point where work is defined: backlog
creation, sprint planning, architecture decisions, infrastructure changes,
and any task whose scope is not already confirmed by prior conversation.
Single-topic, well-defined work with no ambiguity ("fix this typo,"
"implement the BL we just scoped") does not need this dialog; the prior
conversation already provided it.

**Relationship to other principles:** We Need to Talk complements Take a Bite
(§1.1): where Take a Bite governs the size of individual deliveries, We Need
to Talk governs the quality of the conversation that decides what to deliver.
It also reinforces The Human Brings the Spark (§1.2): the human's directional
judgment is most impactful when it shapes work definition, not just work review.

**Evidence:** S182. The three-step dialog model for defining BLs 341-344
(confirm threads → analyze dependencies → package into units) was improvised
at the user's request when the agent proposed a pre-formed BL list for
approval. The user redirected: "let's slow down and figure out what the
threads actually are." The improvised model was then recognized as the
missing entry point to all collaboration, codified as Gate 0 in DSM_0.2
§8.0. The principle names the reasoning that makes Gate 0 necessary.

---

### 1.11 Read the User's Manual

**Ground your collaboration on what the tool actually does, not what you
assume it does.**

Every AI-collaboration practice built on an external tool , a CLI, a hook
runtime, a platform API, a standards document , inherits the tool's real
behavior whether or not the practitioner has read how the tool works. When
the practice is designed around assumed behavior rather than documented
behavior, the gap is invisible until something breaks. By then, the practice
has been propagated across sessions and projects; the cost of discovery
compounds with the cost of unwinding.

"Read the User's Manual" is the discipline of treating external-tool
understanding as a prerequisite to collaboration design, not an optional
afterthought. Also known as "Ground Before You Build": before a pattern is
built on a platform feature, the practitioner reads the platform's own
documentation, verifies the understanding against the documentation (not
against memory or experiential knowledge), and documents the understanding so
it is shared, not individual.

The principle is a specific form of Earn Your Assertions (§1.3) applied to
the tools the collaboration runs on, and a specific form of Know Your Context
(§1.5) applied to external systems rather than the current project. Its
distinctiveness is scope: §1.3 governs claims made in work; §1.5 governs the
context of the current project; §1.11 governs the external substrate that
collaboration patterns are built on. The three reinforce one another without
replacing.

This principle maps to the PMP Procurement knowledge area. Procurement is
about what you acquire from outside your team before you build with it; in
the agentic-stakeholder translation, the acquired artifact is the platform,
the hook runtime, the slash-command execution model, the API contract. The
procurement step is reading the manual. Skipping procurement in either
discipline produces the same class of failure: late discovery that the
acquired artifact does not behave as assumed.

The practitioner's behavioral trigger is pre-emptive: before designing a
pattern around tool X, spend time reading X's documentation. Not after the
pattern fails. The cost of the up-front read is measured in minutes; the
cost of a broken pattern propagated across N sessions is measured in
sessions.

**Relationship to DSM_7.0 §2.1:** §1.11 is the principle; DSM_7.0 §2.1
Claude Code is its first full operational instance. The §2.1 filled
template (installation, core concepts, capability surface, permission
model, troubleshooting catalog, reference cheatsheet) is what "reading
the manual" produces when the output is shared, not individual. Future
`§2.N` platform instances extend the same discipline to other
substrates. When this principle fires, the practitioner's destination
is DSM_7.0 §2.N, or the backlog item to write one.

**Relationship to other principles:** Read the User's Manual sits at the
intersection of Earn Your Assertions (§1.3, don't claim what you haven't
verified) and Know Your Context (§1.5, know what surrounds your work). It
operationalizes both for the specific case of external substrate. Think
Ahead (§1.9) provides the temporal framing: the cost of reading the manual
is paid once; the cost of not reading compounds.

**Evidence:**

- **F-094 (per-turn transcript hook).** The hook scripts were stored in the
  git index at mode `100644`. `core.fileMode = false` on WSL hid the
  divergence, so every fresh clone of any DSM project got non-executable
  hooks and the per-turn reminder hook silently failed end-to-end. The cause
  was not a bug in the hook code; it was a lack of grounding in how Claude
  Code dispatches `UserPromptSubmit` hooks (mode bit enforcement, exit code
  semantics, index-mode persistence across clones). 2.5 months of hook
  non-function accrued before the root cause was traced. Resolved via
  `git update-index --chmod=+x`, `/dsm-align` hub fast-path step 10b
  inclusion, and sub-step b re-applying `chmod +x` on every run.

- **S180 executable-bit incident.** The same class of failure as F-094 at
  smaller scale: hooks were bytewise correct but not executable on a
  specific instance, and the symptom was silent non-firing rather than a
  loud error. Diagnosis required reading Claude Code's hook-execution model
  end-to-end, not reading the hook scripts themselves. The manual was
  authoritative; the agent's working mental model was not.

- **Claude Code platform research (2026-04-12 assessment).** The corrective mitigation:
  The platform research was filed as a High-priority research item to read Claude Code's
  changelogs and hook documentation systematically. Research completed 2026-04-12. The research surfaced multiple platform capabilities the DSM
  skills had been working around rather than using (allowed-tools
  governance, register-sensitive skill evaluation, PreToolUse/PostToolUse
  matchers). The platform research output made subsequent decisions defensible; its
  absence is what made F-094 and S180 possible.

The principle does not prevent the first encounter with a new tool from
surfacing surprises; it establishes that the surprises should come from
reading the documentation, not from running the system.

### 1.12 Don't be a Hero, Delegate the Effort

When a sub-task inside the current work fits a subagent's profile,
bounded scope, token-heavy, reasoning-light, or parallelizable with
the main reasoning thread, propose delegation rather than absorbing
the sub-task on-thread. Heroism, meaning taking on everything on-
thread to "just get it done," burns context budget the main reasoning
needs, delays the decision chain, and hides the delegation choice
from the human.

The principle operationalizes Environmental Awareness (§2.3) at the
sub-task granularity. §2.3 establishes that the sufficient
configuration is preferable to the maximal one; §1.12 extends that
preference to the orchestration layer: prefer the sufficient agent
for the sub-task over absorbing every sub-task into the main agent.

Three guard rails keep delegation honest:

- **Propose, do not decide.** The human approves each offload
  explicitly (DSM_0.2 §8.8). The principle authorizes the proposal,
  not the action.
- **Count synthesis cost.** Delegation is counterproductive when
  reading and integrating the subagent's output costs more than the
  sub-task would have on-thread. Offload only when *net* savings are
  positive.
- **Do not fragment the reasoning.** Delegate sub-tasks that are
  self-contained enough to produce a discrete deliverable; do not
  split the core reasoning of the artifact into subagent pieces the
  main agent must stitch together. Reasoning stays with the main
  agent; labor can travel.

Relationship to other principles:

- **§1.1 Take a Bite.** Don't swallow a large sub-task whole when you
  can slice it off to a subagent. Delegation is "taking a bite" at
  the orchestration layer.
- **§1.10 We Need to Talk.** The offload analysis IS the conversation
  about how the work will get done; it is not a preamble to the real
  work.
- **§2.3 Environmental Awareness.** §2.3 anchors the *why*. §1.12
  extends the preference to the sub-task granularity with §8.8 as
  its operational protocol.

The wrong failure mode is silent heroism: the main agent absorbs a
bulk rename, a multi-file context sweep, or an external research
pass on-thread, burns Opus-scale tokens on Sonnet-scale work, and
never surfaces the alternative to the human. §1.12 exists to make
that failure visible.

---

## 2. Guidelines

The principles above translate into concrete practices at each scale of work.
Rather than duplicating protocol details here, this section maps principles
to existing DSM protocols and identifies the gaps that remain.

### 2.1 Existing Protocols (already implementing these principles)

**Inception**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Project scaffolding (backlog item, CLAUDE.md, dsm-docs/ structure) | DSM_3, DSM_0.1 | Critical Thinking |
| First Session Prompt (research -> plan -> approve -> implement) | DSM_0.2 | Critical Thinking, Earn Your Assertions |
| Phase 0.5: Research and Grounding | DSM_0.2 | Earn Your Assertions, Know Your Context |
| Plan Mode Protocol (explore, design, present for approval) | DSM_0.2 | Earn Your Assertions, Critical Thinking |

**Building**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Pre-Generation Brief (what/why/structure before creating) | DSM_0.2 | Critical Thinking |
| Gate 0 Collaborative Definition (confirm threads → dependencies → package) | DSM_0.2 §8.0 | We Need to Talk |
| Composition Challenge (justify multi-item collections) | DSM_0.2 | Challenge Myself to Reason |
| Edit Explanation Stop (review each edit before execution) | DSM_0.2 | Challenge Myself to Reason |
| Notebook Collaboration (one cell, wait for output) | DSM_0.2 | Take a Bite |
| App Development (File Creation Loop) | DSM_0.2 | Take a Bite |
| Sprint Cadence and Feedback Boundaries | DSM_0.2 | Take a Bite |
| Tests vs Capability Experiments | DSM 4.0, Section 4.4 | Earn Your Assertions |

**Session Management**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Session Transcript (reasoning visible in real time) | DSM_0.2 | The Human Brings the Spark |
| Session-Start Checks (inbox, version, handoffs) | DSM_0.2 | Know Your Context |
| Session Close-Out and Wrap-Up | DSM_0.2 | Know Your Context |
| Checkpoint and Handoff system | DSM_0.2, DSM_5.0 | Know Your Context |
| Daily Documentation Protocol | DSM 1.0, Section 6.1.4 | Know Your Context |
| Skill Self-Reference Protocol (read skill file before claiming behavior) | DSM_0.2 §8.6 | Read the User's Manual, Earn Your Assertions |
| Platform Research Items (Claude Code research, ongoing under Platform Alignment Protocol) | DSM_0.2 §10, `dsm-docs/research/` | Read the User's Manual |

**Quality and Feedback**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Feedback Tracking (methodology.md, backlogs.md) | DSM_0.2 | Critical Thinking |
| Session-End Inbox Push (ripe feedback to hub) | DSM_0.2 | Know Your Context |
| Backlog System (improvements, developments, done) | CLAUDE.md | Critical Thinking |
| Decision Logging (dsm-docs/decisions/) | DSM_5.0 | The Human Brings the Spark |
| Gateway Review Protocol | DSM 1.0, Section 6.5 | Understand/Review/Decide, Earn Your Assertions |
| Factual Accuracy, No Guessing | DSM 1.0, Section 1.3.5 | Earn Your Assertions |
| Destructive Command Protocol | DSM_0.2 | Understand/Review/Decide, Earn Your Assertions |

**Communication**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Blog and Post artifacts (dsm-docs/blog/) | DSM_0.1, DSM 1.0 Section 2.5.9 | The Human Brings the Spark |
| Canonical External Descriptions | DSM_3 Section 7 | Match the Room |
| README Change Notification | DSM_0.2 | Know Your Context |
| Hub-Spoke Inbox system | DSM_3, DSM_0.2 | Know Your Context |
| Inclusive Language | DSM_0.2 | Match the Room, Understand/Review/Decide |

**Evolution**

| Protocol | DSM Location | Principle |
|----------|-------------|-----------|
| Version lifecycle / epochs (semantic versioning for content) | DSM_5.0, CLAUDE.md | Take a Bite |
| DSM Version Propagation | DSM_3, Section 6.3 | Know Your Context |
| Dogfooding (apply DSM to build DSM tools) | DSM_3 Section 7 | Critical Thinking |
| External Contributions (governance in DSM Central) | DSM_3 Section 6.6 | Match the Room |
| Fork Governance Isolation (My Fork, My Rules) | DSM_3 Section 6.6.10 | Match the Room |
| External AI Contribution Guidelines | DSM_3, Section 6.5 | Match the Room |
| Contributor Profile (skills inventory evolves with work) | CLAUDE.md | The Human Brings the Spark |
| Roadmap System (phases, clusters, dependencies) | CLAUDE.md, plan/roadmap.md | Think Ahead |
| Phase-Gated Work (backlog items assigned to strategic phases) | plan/roadmap.md | Think Ahead |
| Backlog Scope Rule (single topic per item, split indicators) | DSM_0.2, CLAUDE.md | Think Ahead, Critical Thinking |
| Feature Branch Rule (test before merge, branch retention) | DSM_0.2, CLAUDE.md | Think Ahead, Earn Your Assertions |

### 2.2 Gaps (require new protocols)

| Scale | Gap | Principle | Backlog | Status |
|-------|-----|-----------|---------|--------|
| Session | No delivery budget: no limit on artifacts per session | Take a Bite | BACKLOG-122 | Addressed: Session Delivery Budget in DSM_0.2 |
| File | No reference file size guidance | Know Your Context | BACKLOG-119 | Open |
| Session | No context budget awareness or early warning | Know Your Context | BACKLOG-121 | Open |
| Wrap-up | Mechanical status updates require individual approval | Critical Thinking | BACKLOG-120 | Open |
| External | No systematic framework for contribution sizing | Match the Room | BACKLOG-122 | Addressed: PR Size Guidance in DSM_3 Section 6.6.7 |
| Research | No checkpoint guard for unbounded exploration | Take a Bite | BACKLOG-122 | Addressed: Research Phase Guard in DSM_0.2 Phase 0.5 |
| Ethics | No attribution/disclosure framework | Own Your Process | BACKLOG-124 | Addressed: Principle 1.7 |
| Ethics | Accountability implicit, not stated | Earn Your Assertions | BACKLOG-124 | Addressed: Accountability corollary in 1.3 |
| Ethics | No environmental awareness | (Guidelines) | BACKLOG-124 | Addressed: Guideline 2.3 |
| Ethics | No licensing/ownership check for third-party assets | Know What You Own | BACKLOG-166 | Addressed: Principle 1.8 |

### 2.3 Environmental Awareness

AI collaboration has an environmental cost. Every prompt, every context window,
every regenerated response consumes compute resources with real energy and
carbon implications. Major frameworks (OECD, WEF) are developing lifecycle
reporting standards for AI sustainability, though these target organizations
rather than individual practitioners.

DSM does not prescribe model selection or usage limits; those decisions depend
on task requirements, budget, and availability. Instead, DSM encourages
awareness:

- **Prefer sufficient over maximal.** When a smaller or faster model handles
  the task adequately, use it. Reserve larger models for tasks that genuinely
  benefit from their capabilities.
- **Avoid unnecessary regeneration.** Refine prompts rather than requesting
  multiple full outputs to pick the best one.
- **Be intentional about context.** Reading a 2,000-line file "just in case"
  has a cost. The Context Budget Protocol (DSM_0.2) already encourages this
  discipline for session management; the environmental dimension reinforces it.

This is an awareness principle, not a compliance requirement. The individual
practitioner's choices are small relative to infrastructure-level decisions,
but awareness is the prerequisite for better choices at every scale.

### 2.4 Applying the Principles

When in doubt about whether a delivery is the right size, apply this
sequence:

1. **Can the reviewer read all of it?** If not, split it.
2. **Can the reviewer form an opinion on it?** If not, it needs more
   explanation or less volume.
3. **Can the reviewer redirect it?** If the cost of "actually, let's try
   this differently" feels prohibitive because too much work has been done,
   the delivery was too large.

### 2.5 The DSM Vocabulary

DSM's principles are not just rules; they are a coined vocabulary. Each term
names a pattern that standard language does not capture precisely. Naming makes
patterns transferable across domains, testable against new situations, and
communicable to practitioners outside the ecosystem.

The vocabulary represents three layers of collaboration infrastructure, each
addressing a different dimension of "how does an ecosystem define its way of
working":

| Layer | Artifact | Dimension |
|-------|----------|-----------|
| Operational | Document structure conventions (DSM_0.1) | How things are organized |
| Philosophical | Principles (this document) | What we value |
| Linguistic | Vocabulary (`dsm-docs/guides/dsm-vocabulary.md`) | How we name what we do |

The vocabulary grows as the methodology encounters new situations, extending
from single-session collaboration (formal principles) to ecosystem-level
patterns (emergent concepts like Ripple Effect and My Fork, My Rules).

**Canonical registry:** `dsm-docs/guides/dsm-vocabulary.md` in DSM Central.

---

## References

- Facione, P.A. (1990). *Critical Thinking: A Statement of Expert Consensus for Purposes of Educational Assessment and Instruction (The Delphi Report)*. California Academic Press. [ERIC ED315423](https://files.eric.ed.gov/fulltext/ED315423.pdf)

## 3. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-02-14 | Initial release. Five principles codified from external collaboration experience and DSM core philosophy. BACKLOG-122. |
| 1.1 | 2026-02-14 | Added "Earn Your Assertions" (principle 1.3). Renamed "The Human Brings the Soul" to "The Human Brings the Spark". Added 7 missing protocol mappings (Tests vs Capability Experiments, Daily Documentation, Gateway Review, Factual Accuracy, Destructive Command, DSM Version Propagation, External AI Contribution Guidelines). Re-mapped Phase 0.5, Plan Mode, and First Session Prompt to include Earn Your Assertions. BACKLOG-123. |
| 1.2 | 2026-02-15 | Added Inclusive Language protocol mapping (Communication table). Added guardrail to Match the Room: agent must surface conflicts between external conventions and DSM inclusive language standards, human decides consciously. |
| 1.3 | 2026-02-15 | Updated gap table (Section 2.2): added Status column, marked 3 gaps as addressed by BACKLOG-122 (Session Delivery Budget, PR Size Guidance, Research Phase Guard). Added Research phase guard row. |
| 1.4 | 2026-03-01 | AI Collaboration Ethics (BACKLOG-124). Added Principle 1.7 "Own Your Process" (attribution/disclosure framework with decision table). Extended Principle 1.3 with accountability corollary. Added Guideline 2.3 "Environmental Awareness." Updated gap table with 3 ethics rows. Based on research: NIST AI RMF, EU AI Act, IEEE CertifAIEd, arXiv:2512.00867. |
| 1.5 | 2026-03-12 | Critical Thinking restructure (BACKLOG-175). Renamed Section 1.4 "Understand, Review, Decide" to "Critical Thinking" with two subsections: 1.4.1 Understand, Review, Decide (preserved), 1.4.2 Challenge Myself to Reason (new). Grounded in Facione (1990) self-regulation concept. Added Composition Challenge and Edit Explanation Stop to protocol mapping. Updated protocol references from "Understand/Review/Decide" to "Critical Thinking." |
| 1.6 | 2026-03-16 | Strategic Thinking Layer (BACKLOG-212). Added Principle 1.9 "Think Ahead" documenting the four-layer maturity progression (operational → philosophical → learning → strategic). Added 4 Evolution protocol mappings (Roadmap System, Phase-Gated Work, Backlog Scope Rule, Feature Branch Rule). Evidence: 83 features across 14 repos, 796 commits, backlog self-generation as maturity signal. |
| 1.7 | 2026-04-19 | Read the User's Manual (BACKLOG-344). Added Principle 1.11 establishing external-tool grounding as a prerequisite to collaboration design. Maps to PMP Procurement knowledge area. Evidence: F-094 (per-turn transcript hook 2.5 months broken due to index-mode `100644`), S180 (+x bug from same root cause), BL-342 (Claude Code platform research as corrective mitigation, Implemented 2026-04-12). Added protocol mappings in Session Management: Skill Self-Reference Protocol (DSM_0.2 §8.6) and Platform Research Backlog Items. |
