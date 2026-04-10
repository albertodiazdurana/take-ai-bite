# Deliberate Systematic Methodology (DSM) - Start Here
**A gentle introduction to working with AI on real projects**

**Version:** 1.4.14
**Last Updated:** 2026-04-10

---

## Contents

1. [What is DSM?](#1-what-is-dsm)
2. [The DSM Ecosystem](#2-the-dsm-ecosystem)
3. [Participation Patterns](#3-participation-patterns)
4. [Project Types](#4-project-types)
5. [Getting Started](#5-getting-started)
6. [How DSM Evolves](#6-how-dsm-evolves)
7. [Document Map](#7-document-map)
8. [Common Questions](#8-common-questions)
9. [References](#9-references)

---

## 1. What is DSM?

DSM is a structured way to collaborate with an AI agent on real work: file
organization, project builds, documents, data analysis, software, whatever you
need done. Think of it as the **rules of the game** for working with AI.

- **Take AI Bite** is the guiding philosophy: work in small, understandable steps.
  The agent creates things (research, summaries, ideas, code, plans) and presents
  them to you one piece at a time. You review each piece: did you understand it?
  Can you imagine what comes next? If not, you refine it together and try again.
  You are always in control.

- **DSM** is the infrastructure. It gives the agent a memory across sessions, a
  way to organize your project, and rules for how to communicate with you. When you start a session, the agent knows where you left off, what
  decisions were made, and what comes next.

- **The agent** follows the rules, reads your files, builds context, and creates
  deliverables step by step. Over time, it builds context about your project,
  your preferences, and your decisions.

**A "session" is not a chat.** In a browser AI chat, you type, it responds, and
the conversation ends. A DSM session is a focused work period with a specific
goal, a record of what was discussed and decided, and a way to pick up exactly
where you left off next time.

---

## 2. The DSM Ecosystem

DSM uses a **hub-spoke architecture**. One central repository holds the
methodology; your projects inherit it automatically.

```
DSM Central (hub)
│
├── Portfolio (spoke)
├── ML Research Project (spoke)
├── Blog Platform (spoke, mirror)
├── Tax Documents (private, no git)
└── Open Source Contribution (external contribution)
```

**How methodology flows:**

1. **DSM Central** defines the rules: session management, collaboration protocols,
   project structure, quality standards
2. **Your project** references Central through a single line in its configuration
   file (`.claude/CLAUDE.md`). The agent loads the methodology from there
3. **Updates propagate automatically.** When Central improves a protocol, every
   project that references it gets the improvement at the next session start

You never need to copy methodology files into your project. The agent reads them
from Central and applies them in context.

---

## 3. Participation Patterns

Every project in the ecosystem relates to Central in one of four ways.

### Hub

The hub is DSM Central itself, the repository you are reading now. It holds:
- All methodology documents (DSM_0 through DSM_6)
- Operational protocols (DSM_0.2 and its modules)
- The backlog of improvements and development plans
- Shared command files that spokes inherit

There is one hub. Everything else is a spoke, private project, or external
contribution.

### Spoke

A spoke is any project that references DSM Central via the `@` import. This is the
most common pattern. Spokes:
- Inherit all methodology automatically
- Send feedback to Central when they discover gaps or improvements
- Receive updates through the inbox system
- Can be any project type (data science, application, documentation)

**Mirror spokes** are a special case: they receive automatic file sync from Central
after methodology changes, used for public distribution.

### Private Project

Some projects contain sensitive data (financial records, medical data, personal
documents) and cannot use git or share artifacts externally. Private projects:
- Follow DSM methodology locally, without a git repository
- Do not send feedback to Central or other projects
- Keep all artifacts on the local filesystem
- Receive methodology updates by reading Central directly

### External Contribution

When you contribute to someone else's open-source project, you maintain DSM
governance in your own ecosystem while the code contributions go to the external
repository. This pattern:
- Keeps governance artifacts (decisions, feedback, plans) in your DSM storage
- Sends only code contributions to the upstream repository
- Follows the external project's conventions for code style and PR format
- Maintains DSM session management for your own workflow

---

## 4. Project Types

Regardless of how your project connects to the ecosystem, DSM adapts to
what you are building. The agent detects this automatically from your folder
structure.

### Data Science (DSM 1.0)

For projects focused on analysis and insights: customer segmentation, demand
forecasting, exploratory data analysis, research synthesis.
- Deliverables: notebooks, presentations, reports
- Key feature: one-cell-at-a-time notebook collaboration
- Indicator: `notebooks/` folder, no `src/`

### Application (DSM 4.0)

For building software that uses ML or AI components: chatbots, automation tools,
data processing pipelines, API services, CLI utilities.
- Deliverables: code packages, deployed services
- Key feature: step-by-step development with test-driven workflow
- Indicator: `src/`, `tests/`, `app.py`

### Hybrid

Projects that combine analysis and application code: a RAG application with
evaluation notebooks, a data pipeline with exploratory analysis.
- Uses DSM 1.0 for `notebooks/`, DSM 4.0 for `src/`
- The agent identifies which track applies to each task

### Documentation (DSM 5.0)

For projects where the primary deliverable is written content: methodology
repositories, professional portfolios, knowledge bases, technical writing.
- Deliverables: markdown files, structured documents
- Indicator: `dsm-docs/`, markdown-only, no `notebooks/` or `src/`

---

## 5. Getting Started

### Prerequisites

- **VS Code** with the **Claude Code** extension installed
- A folder for your project (new or existing)
- Access to DSM Central (this repository) on your local machine

### Your First Session

1. Open your project folder in VS Code
2. Type `/dsm-go` in the Claude Code panel
3. The agent sets up the project structure, identifies what kind of project it is,
   and asks what you want to work on

The agent handles the rest: creating folders, loading context, and guiding you
through your first session step by step.

### What Happens During `/dsm-go`

The agent runs through a checklist:
- Identifies your project type (data science, application, hybrid, documentation)
- Creates a session branch to isolate your work (reversible if needed)
- Checks for pending items from previous sessions or from Central
- Loads memory from past sessions so context is preserved
- Asks what you want to work on and recommends a configuration

From there, the agent proposes and you review. Every artifact goes through approval
before it is created.

### When the Session Ends

Type `/dsm-wrap-up`. The agent:
- Saves session context to memory
- Commits and pushes your work
- Creates a handoff document if there is complex pending work
- Merges your session branch back to main

Next session, `/dsm-go` picks up exactly where you left off.

---

## 6. How DSM Evolves

DSM changes over time. It improves through a feedback loop between Central and
every project in the ecosystem.

### The Feedback Cycle

1. **You work on your project.** During sessions, the agent observes what works
   and what does not: missing protocols, unclear guidance, useful patterns
2. **Feedback flows to Central.** Observations are captured in feedback files and
   sent via the inbox system
3. **Central improves.** Feedback is triaged, and improvements are implemented as
   backlog items
4. **Projects get updates.** The next time a spoke starts a session, it inherits
   the improved methodology automatically

### The Inbox System

Every project has an `_inbox/` folder, a transit point for communication. Entries
arrive, get processed, and move to `done/`. This is how Central notifies spokes
about changes, and how spokes send observations back.

You do not need to manage this manually. The agent handles inbox processing at
session start and feedback generation at session end.

---

## 7. Document Map

DSM is organized into numbered documents. You do not need to read them all; the
agent loads what is relevant. This map helps if you want to explore.

| Document | Purpose | When to Read |
|----------|---------|--------------|
| **DSM_0.0** (this file) | Introduction and orientation | First time using DSM |
| **DSM_0.1** | Citation standards and file conventions | When publishing or referencing external work |
| **DSM_0.2** | Operational protocols (session management, safety, collaboration) | The agent reads this; you rarely need to |
| **DSM_1.0** | Data science collaboration methodology | Working on data analysis projects |
| **DSM_2.0** | Project management guidelines | Planning sprints, managing deliverables |
| **DSM_2.1** | Production extension for enterprise projects | Deploying to production environments |
| **DSM_3.0** | Implementation guide (setup, configuration, ecosystem) | Setting up DSM for the first time |
| **DSM_4.0** | Software engineering adaptation | Building applications with ML/AI |
| **DSM_5.0** | Documentation project adaptation | Working on documentation-only projects |
| **DSM_6.0** | AI collaboration principles | Understanding the philosophy behind DSM |
| **DSM_6.1** | Systems prompt engineering and AI product architecture | Understanding DSM as an instruction system |

DSM_0.2 is the operational backbone. It defines how sessions work, how the agent
communicates, and how safety protocols operate. The agent loads it via the `@`
reference in your project's `.claude/CLAUDE.md`. You benefit from it without
reading it.

---

## 8. Common Questions

**Do I need to read all the DSM documents?**
No. Read this file. The agent loads what is relevant to your project type and task.
Explore other documents only when you are curious or need specific guidance.

**What if I already have a project with existing files?**
Run `/dsm-go` in that folder. The agent detects existing structure and adapts.
It will not overwrite your files.

**Can I use DSM without git?**
Yes. Private projects work without a git repository. You lose branching and version
history, but session management and methodology guidance still apply.

**What is the difference between DSM and Take AI Bite?**
Take AI Bite is the philosophy (work in small, reviewable pieces). DSM is the
implementation (the protocols, documents, and tools that make it work). Take AI
Bite is the "why"; DSM is the "how."

**How do I contribute improvements to DSM?**
The agent captures feedback automatically during sessions. If you notice something
that could be better, mention it. The feedback flows to Central and gets triaged
as a potential improvement.

**Can I use DSM with a team?**
DSM is designed for individual human-AI collaboration. Team coordination (shared
repositories, code review) uses standard git workflows. Each team member runs
their own DSM sessions.

---

## 9. References

- **Take AI Bite philosophy:** [`TAKE_A_BITE.md`](TAKE_A_BITE.md)
- **Full implementation guide:** [`DSM_3.0_Methodology_Implementation_Guide_v1.1.md`](DSM_3.0_Methodology_Implementation_Guide_v1.1.md)
- **AI collaboration principles:** [`DSM_6.0_AI_Collaboration_Principles_v1.0.md`](DSM_6.0_AI_Collaboration_Principles_v1.0.md)
- **Systems prompt engineering:** [`DSM_6.1_Systems_Prompt_Engineering_v1.0.md`](DSM_6.1_Systems_Prompt_Engineering_v1.0.md)
- **Changelog:** [`CHANGELOG.md`](CHANGELOG.md)
- Preston-Werner, T. (2013). [Semantic Versioning 2.0.0](https://semver.org/)
