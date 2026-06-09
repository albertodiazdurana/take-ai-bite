# Take AI Bite

**A framework for human-AI collaboration where the human stays in control, grows through the work, and retains every lesson learned.**

<p align="center">
  <img src="assets/logo.png" alt="Take AI Bite logo" width="200">
</p>

---

AI tools generate faster than humans can review. When the output exceeds what a person can meaningfully engage with, the collaboration quietly breaks: the human stops reading and starts clicking "approve." The human in the loop becomes decorative, and the distinctive value they bring, direction, judgment, style, goes missing from the work.

Take AI Bite is a set of principles for keeping the human genuinely present in AI-assisted work. Not by slowing the AI down, but by structuring collaboration so that every delivery is sized for real engagement.

But it goes further than review sizing. Take AI Bite builds an agent ecosystem that retains your memory, experience, and decisions across sessions and projects. The ecosystem becomes your avatar: an extension of your professional self that grows with you, remembers what you learned, and carries your accumulated expertise into every new collaboration.

Take AI Bite is the public face of DSM (Deliberate Systematic Methodology), authored and maintained by [Alberto Diaz Durana](https://www.linkedin.com/in/albertodiazdurana/). It is one practitioner's working methodology, refined through real projects and made public, not a generated template.

## The Principles

Thirteen principles govern how humans and AI agents work together. Each addresses a specific failure mode in human-AI collaboration.

| Principle | Core idea |
|-----------|-----------|
| **Take a Bite** | Deliver only what the reviewer can chew. If they can't redirect it, it was too much. |
| **The Human Brings the Spark** | AI amplifies. The human provides direction, intuition, and aesthetic judgment. |
| **Earn Your Assertions** | Investigate before you claim. Verify before you act. Neither side gets to assume. |
| **Critical Thinking** | Understand first, review second, decide third. Then challenge your own reasoning: what did I miss? What am I assuming? |
| **Know Your Context** | The agent manages its own resource consumption. Don't charge ahead until overflow. |
| **Match the Room** | Contribute proportionally to the project's culture and scale. |
| **Own Your Process** | Disclose how the work was produced. Transparency about method is a professional obligation. |
| **Know What You Own** | Verify licensing before deployment. Free tier does not mean free use. |
| **Think Ahead** | Build the map before you walk the territory. Strategy emerges from operational maturity. |
| **We Need to Talk** | The conversation that defines the work is the collaboration, not a preamble to it. |
| **Read the User's Manual** | Ground the work on what the tool actually does, not on what you assume it does. |
| **Don't be a Hero, Delegate the Effort** | Hand bounded, token-heavy, reasoning-light sub-tasks to a subagent instead of absorbing them. |
| **Introduce Once, Then Deepen** | Introduce each concept once; let the body deepen it rather than repeat it. |

For the full framework, see [`DSM_6.0_AI_Collaboration_Principles_v1.0.md`](DSM_6.0_AI_Collaboration_Principles_v1.0.md).

## The Engine: Deliberate Systematic Methodology (DSM)

These principles are operationalized by DSM, a living, versioned methodology that governs the full lifecycle of human-AI collaboration: research, implementation, governance, and disclosure.

DSM is not a static document. It evolves through a hub-spoke feedback loop where every session, every project, and every practitioner's experience feeds back into the methodology. Protocols are tested, refined, and propagated across the ecosystem. What one project discovers improves every future project.

This is what makes TAB unique to your own experience. Session transcripts capture reasoning. Checkpoints preserve milestones. Memory files retain context across sessions. Feedback flows from individual projects to the central methodology and back. The result is an ecosystem that accumulates your expertise, not just your files.

## Systems Prompt Engineering

Most prompt engineering focuses on crafting individual prompts. Take AI Bite operates at a different level: designing, versioning, and governing entire instruction systems across an ecosystem of projects.

This is Systems Prompt Engineering, a discipline that applies project management rigor to AI instruction artifacts. All ten PMP knowledge areas show up in DSM, framed as methodology governance rather than project management: communication management is the inbox and feedback channels, schedule management is the session lifecycle, risk management is the failure-mode taxonomy and violation-triage protocol. The extension worth naming is Stakeholder Management. DSM treats the AI agent as a second stakeholder alongside the human, and the instruction system that governs it is that stakeholder's management plan. See [Project Management for the Agentic Stakeholder](https://take-ai-bite.com/blog/2026-04-10-project-management-for-the-agentic-stakeholder/).

The framework operates at three levels:

| Level | What it manages | Example |
|-------|----------------|---------|
| **Individual** | A single prompt or instruction | A system prompt, a chat message |
| **System** | Coordinated instructions for one project | CLAUDE.md + command files + session protocols |
| **Ecosystem** | Instruction architecture across projects | Hub-spoke propagation, feedback loops, mirror sync |

For the full chapter, see [`DSM_6.1_Systems_Prompt_Engineering_v1.0.md`](DSM_6.1_Systems_Prompt_Engineering_v1.0.md).

## Start Here

Read [`TAKE_AI_BITE.md`](TAKE_AI_BITE.md) for the short version of the founding principle. It takes two minutes and captures the core idea: someone offers you a bite of a cookie, you take a bite the size you will enjoy; too small and you won't taste the cookie, too much and it will cause a lot of issues.

For the full picture, [`DSM_0.0_START_HERE_Complete_Guide.md`](DSM_0.0_START_HERE_Complete_Guide.md) is the guided entry point into the methodology. It maps the document set, so the volume of `DSM_*.md` files reads as deliberate architecture rather than sprawl.

## Field-Tested

These principles were developed and validated across real projects spanning:

- **Data science:** exploratory analysis, feature engineering, modeling pipelines
- **Software engineering:** ML applications, production code, test-driven development
- **Open source contribution:** external projects in unfamiliar technology domains, with contributions merged upstream
- **Structured documentation:** complex, interconnected methodology systems with thousands of cross-referenced lines
- **Research synthesis:** multi-source analysis, competitive landscape mapping, literature review
- **Administrative processes:** financial documentation, regulatory compliance

They are not theoretical; they emerged from daily practice with AI agents across these domains. The tested work, the spoke repositories and the merged open-source pull requests, lives on the author's GitHub: [github.com/albertodiazdurana](https://github.com/albertodiazdurana). Practitioners working on complex multi-session tasks independently recreate DSM patterns (checkpoint directories, session handoffs, decision logs) before encountering the framework. DSM formalizes behavior that emerges naturally from deliberate work.

## Recent Features

<details>
<summary>Latest additions to the framework (click to expand)</summary>

- **Systems Prompt Engineering (DSM_6.1)** — A full chapter naming the discipline: version-controlled instruction systems, failure mode taxonomy, practitioner maturity model, and PMP knowledge area mapping
- **Chunked drafting for structured documents** — Project plans, proposals, reports, and other prose deliverables are drafted one section at a time with per-section review, not generated whole
- **User-reframes-proposal handling** — When the human re-shapes a proposal instead of answering yes or no, the agent re-decomposes the work rather than defending its original framing
- **Introduce Once, Then Deepen** — A writing principle for summary-plus-body prose: introduce each concept once and let the body deepen it, instead of restating it
- **Non-suppressible safety prompts** — Certain session-start safety checks must be answered explicitly even under auto mode; speed settings cannot silently skip them
- **Pre-merge test execution and preemptive risk definition** — Every backlog item names its failure modes up front and runs its test plan with per-item evidence before merging
- **Concurrent-session detection** — A second session on the same project is detected and halted before it can corrupt shared state, and fresh mirror clones self-initialize on first run
- **Compact reasoning-lessons mirror** — Accumulated cross-session reasoning lessons are distilled into a size-bounded file the agent reads at session start
- **Document modularization** — All methodology documents split into slim cores with on-demand modules, reducing context consumption while preserving full coverage
- **Parallel session protocol** — Run isolated evaluation tasks on independent branches without interfering with the main session

</details>

See the full timeline of 135+ features → [FEATURES.md](FEATURES.md)

## What's Coming

- **Structural compliance retrofit** — Applying document structure standards (TOC, intro paragraphs, line budgets) across all methodology files
- **A queryable knowledge graph** that compiles human-authored methodology into a navigable, interconnected structure, making the ecosystem's accumulated knowledge searchable across projects and sessions
- **Onboarding guide** — A newcomer-friendly path into the framework for practitioners encountering DSM for the first time

## Links

- **Website:** [take-ai-bite.com](https://take-ai-bite.com)
- **Author:** [Alberto Diaz Durana](https://www.linkedin.com/in/albertodiazdurana/)
- **Vocabulary:** [DSM terms and concepts](dsm-docs/guides/dsm-vocabulary.md) , spoke, hub, Level 3 branch, Pre-Generation Brief gates, `@` reference

## License

This project uses dual licensing:

- **Methodology documentation** (DSM_0 through DSM_6, guides, TAKE_AI_BITE.md): [CC BY-SA 4.0](LICENSE-DOCS.md)
- **Software components** (scripts/, configuration files): [MIT](LICENSE)
