# Take AI Bite

**A framework for human-AI collaboration where the human stays in control, grows through the work, and retains every lesson learned.**

<p align="center">
  <img src="assets/logo.png" alt="Take AI Bite logo" width="200">
</p>

---

AI tools generate faster than humans can review. When the output exceeds what a person can meaningfully engage with, the collaboration quietly breaks: the human stops reading and starts clicking "approve." The human in the loop becomes decorative, and the distinctive value they bring, direction, judgment, style, goes missing from the work.

Take AI Bite is a set of principles for keeping the human genuinely present in AI-assisted work. Not by slowing the AI down, but by structuring collaboration so that every delivery is sized for real engagement.

But it goes further than review sizing. Take AI Bite builds an agent ecosystem that retains your memory, experience, and decisions across sessions and projects. The ecosystem becomes your avatar: an extension of your professional self that grows with you, remembers what you learned, and carries your accumulated expertise into every new collaboration.

## The Principles

Seven principles govern how humans and AI agents work together. Each addresses a specific failure mode in human-AI collaboration.

| Principle | Core idea |
|-----------|-----------|
| **Take a Bite** | Deliver only what the reviewer can chew. If they can't redirect it, it was too much. |
| **The Human Brings the Spark** | AI amplifies. The human provides direction, intuition, and aesthetic judgment. |
| **Earn Your Assertions** | Investigate before you claim. Verify before you act. Neither side gets to assume. |
| **Critical Thinking** | Understand first, review second, decide third. Then challenge your own reasoning: what did I miss? What am I assuming? |
| **Know Your Context** | The agent manages its own resource consumption. Don't charge ahead until overflow. |
| **Match the Room** | Contribute proportionally to the project's culture and scale. |
| **Own Your Process** | Disclose how the work was produced. Transparency about method is a professional obligation. |

For the full framework, see [`DSM_6.0_AI_Collaboration_Principles_v1.0.md`](DSM_6.0_AI_Collaboration_Principles_v1.0.md).

## The Engine: Deliberate Systematic Methodology (DSM)

These principles are operationalized by DSM, a living, versioned methodology that governs the full lifecycle of human-AI collaboration: research, implementation, governance, and disclosure.

DSM is not a static document. It evolves through a hub-spoke feedback loop where every session, every project, and every practitioner's experience feeds back into the methodology. Protocols are tested, refined, and propagated across the ecosystem. What one project discovers improves every future project.

This is what makes the avatar possible. Session transcripts capture reasoning. Checkpoints preserve milestones. Memory files retain context across sessions. Feedback flows from individual projects to the central methodology and back. The result is an ecosystem that accumulates your expertise, not just your files.

## Start Here

Read [`TAKE_A_BITE.md`](TAKE_A_BITE.md) for the short version of the founding principle. It takes two minutes and captures the core idea: someone offers you a bite of a cookie, you take a bite the size you will enjoy; too small and you won't taste the cookie, too much and it will cause a lot of issues.

## Field-Tested

These principles were developed and validated across real projects spanning:

- **Data science:** exploratory analysis, feature engineering, modeling pipelines
- **Software engineering:** ML applications, production code, test-driven development
- **Open source contribution:** external projects in unfamiliar technology domains (Android/Kotlin), with all contributions merged upstream
- **Structured documentation:** complex, interconnected methodology systems with thousands of cross-referenced lines
- **Research synthesis:** multi-source analysis, competitive landscape mapping, literature review
- **Administrative processes:** financial documentation, regulatory compliance

They are not theoretical; they emerged from daily practice with AI agents across these domains. Practitioners working on complex multi-session tasks independently recreate DSM patterns (checkpoint directories, session handoffs, decision logs) before encountering the framework. DSM formalizes behavior that emerges naturally from deliberate work.

## Recent Features

<details>
<summary>Latest additions to the framework (click to expand)</summary>

- **Incomplete wrap-up recovery** — When a session ends unexpectedly, the next session detects the gap and reconstructs the missing summary from the archived transcript
- **Two-Pass Reading Strategy** — Long structured files are read in two passes: structural scan first, then targeted reads of relevant sections
- **Web Research Capture Protocol** — Raw findings are saved with source URLs before synthesis, ensuring every claim is traceable
- **Session configuration recommendation** — Each session receives a tailored model and effort configuration based on planned work scope
- **Strategic roadmap with GitHub Projects** — A three-layer planning system: strategic document, GitHub Projects board, and individual backlog files
- **Mirror repo sync** — Methodology files are automatically copied to public distribution repos after changes
- **Branch testing requirement** — Feature branches must be tested before merging, with specific test plans per backlog item
- **DSM modularization** — Custom instructions split into a core file (always loaded) and four on-demand modules for context efficiency
- **Ecosystem Path Registry** — Cross-repo paths declared in a local registry, eliminating hardcoded filesystem paths
- **Parallel session protocol** — Run isolated evaluation tasks on independent branches without interfering with the main session

</details>

See the full timeline of 84+ features → [FEATURES.md](FEATURES.md)

## What's Coming

- **Methodology tracks** for data science, software engineering, documentation, and project management, with templates, case studies, and setup scripts
- **A queryable knowledge graph** that compiles human-authored methodology into a navigable, interconnected structure, making the ecosystem's accumulated knowledge searchable across projects and sessions

## Links

- **Website:** [takeaibite.de](https://takeaibite.de)
- **Blog:** [blog.take-ai-bite.com](https://blog.take-ai-bite.com)
- **Author:** [Alberto Diaz Durana](https://www.linkedin.com/in/albertodiazdurana/)

## License

This project uses dual licensing:

- **Methodology documentation** (DSM_0 through DSM_6, guides, TAKE_A_BITE.md): [CC BY-SA 4.0](LICENSE-DOCS.md)
- **Software components** (scripts/, configuration files): [MIT](LICENSE)