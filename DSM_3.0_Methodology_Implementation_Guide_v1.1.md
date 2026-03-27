# Methodology Implementation Guide

**Purpose:** Quick setup guide for new projects using an AI agent
**Version:** 1.3.0
**Last Updated:** 2026-03-25

---

## 1. Overview

### What This Guide Provides

**Complete Custom Instructions Template** for configuring agent projects with:
- Project planning context (scope, stakeholders, timeline)
- Execution standards (code quality, deliverable format, communication)
- Domain-specific adaptations
- Advanced practices selection

**Three Complete Examples** across DSM tracks:
- Data Science project (DSM 1.0)
- Software Engineering / Application project (DSM 4.0)
- Documentation project (DSM 5.0)

### Quick Start (5 Steps)

1. **Read:** `DSM_0.0_START_HERE_Complete_Guide.md` (system overview)
2. **Create `.claude/CLAUDE.md`** in your project with `@` reference to DSM Custom Instructions
3. **Copy template** (Section 2) → Customize for your project
4. **Add project-specific instructions** after the `@` reference in CLAUDE.md
5. **Start first session** with project plan request

**For system overview, see:** `DSM_0.0_START_HERE_Complete_Guide.md`

---

## 2. Custom Instructions Template

**Copy this template and customize bracketed sections:**

```markdown
# Project: [PROJECT_NAME]
Domain: [Your project's domain, e.g., analytics, web application, API service, documentation]

## Framework Documents
This project uses:
- **PM Guidelines** (via `@` reference): Project planning structure and templates
- **Collaboration Methodology v1.3.0** (via `@` reference): Execution workflow with hierarchical numbering
- **Project Reference Documentation** (project-specific): Domain context (create if needed)
- **Complete Getting Started Guide** (via `@` reference): Integrated system overview

## Project Planning Context

### Scope
- **Purpose**: [Main objective and business value in 1-2 sentences]
- **Resources**: [Time: X sprints, Team: Y people, Budget/constraints]
- **Success Criteria**:
  - Quantitative: [Measurable metrics, e.g., "RMSE < 10%", "F1 > 0.85"]
  - Qualitative: [Business alignment, e.g., "Actionable insights for marketing"]
  - Technical: [Reproducibility, documentation quality]

### Data & Dependencies
- **Primary dataset**: [Name, size (rows/GB), source, access method]
- **Secondary data**: [External sources, APIs, if applicable]
- **Dependencies**: [Outputs from prior work, team deliverables]
- **Data quality**: [Known issues: missing values, outliers, bias]

### Stakeholders & Governance
- **Primary**: [Name, role] - needs [information type, e.g., "executive summary"]
- **Secondary**: [Name, role] - needs [information type, e.g., "technical details"]
- **Communication**: [Frequency: per sprint/biweekly, Format: email/Slack/presentation]
- **Governance** (Production only): [Project Lead, Data Owner, RACI matrix if multi-team]

## Execution Context

### Timeline & Phases
- **Duration**: [X sprints total]
- **Phase 1 - Exploration** (Sprint 1): [Specific focus for your domain]
- **Phase 2 - Feature Engineering** (Sprint 2): [Key features to create]
- **Phase 3 - Analysis** (Sprint 3): [Models/algorithms to test - might iterate to phase 2 if major changes are identified]
- **Phase 4 - Communication** (Sprint 4): [Deliverables to produce]

### Deliverables
- [ ] [Primary deliverables for your DSM track: notebooks (DSM 1.0), source code (DSM 4.0), documents (DSM 5.0)]
- [ ] Project plans: [Sprint plans following PM Guidelines templates]
- [ ] Presentation: [Slide count, audience, e.g., "15 slides for executives"]
- [ ] Report: [Length, format, e.g., "20-page technical report"]
- [ ] Other: [Additional artifacts: API, dashboard, package, etc.]

## Domain Adaptations

### Key Techniques (Reference: Appendix D for domain-specific guidance)
- [Technique 1 specific to this domain/problem]
- [Technique 2 specific to this domain/problem]
- [Technique 3 specific to this domain/problem]

### Known Challenges
- [Challenge 1] → [Mitigation strategy]
- [Challenge 2] → [Mitigation strategy]

### Solved Challenges (Update as you progress)
- [Challenge X] → [Solution applied]

## Advanced Practices

**Select from Methodology Section 5 (activate as needed):**
- [ ] Experiment Tracking (ML-heavy, comparing >10 model variants)
- [ ] Hypothesis Management (research/academic projects)
- [ ] Performance Baseline & Benchmarking (production benchmarking required)
- [ ] Ethics & Bias Considerations (sensitive data, fairness concerns)
- [ ] Testing Strategy (production deployment, team collaboration)
- [ ] Data Versioning & Lineage (frequent data updates, multiple sources)
- [ ] Technical Debt Register (long-term maintenance, production systems)
- [ ] Scalability Considerations (large datasets >10GB, production deployment)
- [ ] Literature Review Phase (novel domain, research validation)
- [ ] Risk Management (high-stakes decisions, production requirements)

**For implementation details, see:** Appendix C

## Communication & Style

### Artifact Generation
- Ask clarifying questions before generating artifacts
- Confirm understanding: "Confirm that you understand what I need"
- Be concise in work
- Progressive execution: Build incrementally, each output becomes reference for the next
- Follow the artifact generation protocol for your DSM track (DSM 1.0 Section 3.1 for notebooks, DSM 4.0 for modules)
- File naming: See Appendix E.11 for detailed conventions

### Environment Setup
- Run `scripts/setup_base_environment_minimal.py` (academic) or `scripts/setup_base_environment_prod.py` (production)
- Generate domain extensions as needed (see Appendix A for guidance)
- Always resolve paths relative to project root using `.resolve()`
- Document functions with docstrings
- See Methodology Section 2.1 (Environment Setup) for complete guide

### Standards (CRITICAL - Always Follow)

**Text Formatting:**
- Never use emojis (no checkmarks, cross marks, warning symbols, chart symbols, etc.)
- Use plain text: "OK:", "WARNING:", "ERROR:"
- Checkboxes: `[ ]` incomplete, `[x]` complete
- ASCII-only characters in all documentation

**Code Output:**
- Show actual values/metrics (shapes, counts, correlations)
- Avoid generic confirmations: "Complete!", "Done!", "Success!"
- Use: `print(f"Correlation: {value:.3f}")` or `print(df.shape)`
- Avoid: `print("Data loaded successfully!")`

**Print Statement Patterns (See Appendix E.4 for details):**
- Show computed values, not confirmation strings
- Use f-strings for metrics: `print(f"Result: {value:.4f}")`
- Let framework-native formatting handle display

**Deliverable Standards (track-specific):**
- DSM 1.0 (Notebooks): Precede code cells with markdown, ~400 lines per notebook, visible output per cell. See Methodology Section 3
- DSM 4.0 (Applications): Modular source code, type hints, docstrings, tests. See DSM 4.0
- DSM 5.0 (Documentation): Structured markdown, cross-references, versioned. See DSM 5.0

### Session Management
- Monitor tokens continuously
- Alert at 80% capacity (~160K tokens)
- Provide session summary as Handoff for the following chat if nearing limit
- Reference Methodology Section 6.1 for session handoff templates
- Store handoffs in `dsm-docs/handoffs/` within the project repository for continuity
  - **Why**: Keeps session handoffs alongside the project code, accessible via git history

### Language & Formatting
- Primary language: [English / German / Spanish]
- Presentation language: [If different from primary]
- Number format: [1,234.56 or 1.234,56]
- Date format: [YYYY-MM-DD or DD/MM/YYYY]
- Code examples: [Language/framework if specific]

## Project-Specific Requirements
- [Unique constraints: regulatory, compliance, business rules]
- [Required/prohibited tools or libraries]
- [Output format specifications: file types, schemas]
- [Performance requirements: runtime, memory, latency]
- [Privacy/security considerations]
```

---

## 3. Template Usage Guide

### Filling Out the Template

**Project Planning Context:**
- **Purpose:** One clear sentence. Business value first, technical second.
- **Success Criteria:** Be specific. "Improve quality" is vague. "Reduce error rate by 10%" or "Pass all integration tests" is clear.
- **Stakeholders:** Include communication preferences (technical depth, frequency).

**Execution Context:**
- **Timeline:** Methodology assumes 4-sprint academic project structure unless specified. See DSM_2.0 Template 8 (Sprint Plan with Cadence Guidance) for sprint configuration.
- **Phase Focus:** Customize based on domain (see Appendix D for domain-specific guidance).

**Domain Adaptations:**
- **Key Techniques:** List 3-5 domain-specific methods you'll use.
- **Known Challenges:** Document upfront. Add solutions as you discover them.

**Advanced Practices:**
- Start simple: Check only 2-3 practices initially.
- Add more as project complexity increases.
- Each checked practice has detailed implementation in Appendix C.

**Communication & Style:**
- Keep this section mostly as-is (proven standards).
- Customize language/formatting based on location and audience.

### When to Update Custom Instructions

**During project:**
- Activate new advanced practices (check boxes)
- Add newly discovered challenges and solutions
- Update timeline if scope changes
- Add project-specific requirements as discovered

**Don't update:**
- Core standards (text formatting, deliverable structure)
- Methodology references (keep stable)

### What NOT to Include

**Avoid duplicating:**
- Complete methodology content (available via `@` reference, searchable)
- Detailed templates (reference section numbers instead)
- Generic guidance (focus on project-specific only)

**Character limit:** Keep under 8K characters for best performance.

---


## 6. Module Dispatch Table for Implementation Guide

The full Implementation Guide is organized as this core file plus five
companion modules. Each module is self-contained with its own TOC,
numbered headings, and intro paragraphs.

| Module | Title | Scope |
|--------|-------|-------|
| [A](DSM_3.0.A_Template_Examples.md) | Template Examples by DSM Track | Three complete examples (DSM 1.0, 4.0, 5.0) and quick reference |
| [B](DSM_3.0.B_Hub_Spoke_Communication.md) | Hub-Spoke Communication Protocols | Feedback handover, project kickoff, version propagation, inbox |
| [C](DSM_3.0.C_External_Contribution_Guidelines.md) | External Contribution Guidelines | AI policy assessment, governance framework, onboarding lifecycle |
| [D](DSM_3.0.D_External_Contribution_Templates.md) | External Contribution Templates | CLAUDE.md template, codebase analysis, anti-patterns |
| [E](DSM_3.0.E_Participation_Patterns.md) | Participation Patterns | Spoke initialization, private project pattern, standard spoke pattern |

**When to read modules:** The core provides the template and usage guide.
Read modules when you need examples (A), communication protocols (B),
external contribution guidance (C-D), or project setup patterns (E).

---

## 7. Canonical External Description

When describing DSM in external-facing documents (job applications, blog posts, README,
presentations), use these canonical descriptions. They ensure consistent framing across
all projects and prevent misattribution.

**Critical framing rules:**
- DSM is a personal initiative, independently developed since August 2025
- Masterschool specialization projects (TravelTide, Favorita) are case studies that stress-tested DSM, not the source of DSM
- Dog-fooding projects (Graph Explorer, Research Agent) validate DSM by building tools using DSM itself
- Never frame DSM as a Masterschool product or coursework output

**Usage:** The descriptions below are in first person ("I developed"). For third-person
contexts (LinkedIn summaries, portfolio "About" sections), adapt the voice but preserve
the framing rules above. When writing job applications, cover letters, or portfolio
materials, reference this section directly rather than re-deriving the framing each time.

### Short Version (1-2 sentences)

> The Deliberate Systematic Methodology (DSM) is a framework for human-AI collaboration
> across data science, software engineering, and documentation projects. It covers the
> full lifecycle from exploration through production, validated across 10+ projects.

### Medium Version (1 paragraph)

> The Deliberate Systematic Methodology (DSM) is a comprehensive framework for
> human-AI collaboration across multiple domains. Started in August 2025, it provides
> a structured workflow, project management templates, software engineering adaptations,
> and documentation standards. The methodology has been validated through real-world
> projects spanning data science, Android/Kotlin development, and open-source
> contributions, as well as through a growing ecosystem of tools that validate DSM
> by building with DSM.

### Full Version (3-4 paragraphs)

> The Deliberate Systematic Methodology (DSM) is a comprehensive, open-source framework
> for human-AI collaboration. Started in August 2025, the methodology addresses a gap
> in how professionals collaborate with AI tools: most workflows lack the structure
> needed for reproducibility, quality assurance, and systematic decision tracking.
>
> The framework provides an integrated system of five core documents covering
> project management, a 4-phase execution workflow, software engineering adaptations
> for ML applications, documentation project standards, and an implementation guide.
> At over 10,000 lines, it includes sprint planning templates, notebook standards,
> app development protocols, domain adaptation guides, and a gateway review protocol
> for multi-project governance.
>
> DSM has been validated across 20+ projects spanning customer analytics, demand
> forecasting, NLP, computer vision, process mining, RAG systems, energy engineering,
> and agentic AI. Case studies completed during my Masterschool AI Data Science
> specialization (TravelTide, Favorita) served as early stress tests, with lessons
> learned incorporated back into the framework. A growing ecosystem of dog-fooding
> projects, tools built using DSM to validate DSM itself, provides continuous
> feedback and demonstrates the methodology's adaptability across project types.
>
> The methodology is agent-agnostic and open-source (MIT License), designed for data
> scientists, students, and professionals who want a systematic approach to working
> with AI coding agents across notebook, application, and documentation projects.

### Project Registry

Complete list of projects that DSM has supported, organized by domain. When
referencing DSM externally, select projects relevant to the context.

**Customer Analytics & Forecasting:**
- TravelTide: Customer segmentation, CLV analysis, hierarchical clustering (case study)
- Corporacion Favorita: Demand forecasting, XGBoost, 4.8M transactions (case study)
- Favorita App: Streamlit deployment of demand forecasting model

**NLP & Text Analysis:**
- Disaster Tweets: Tweet classification, TF-IDF vs embeddings vs transformers
- NLP Topic Modeling: LDA on Jira case data, process mining integration

**Computer Vision:**
- Computer Vision: CIFAR-10 classification (ResNet50), steel defect segmentation (U-Net)

**Agentic AI & RAG:**
- SQL Query Agent: Text-to-SQL with Ollama, local LLM
- RAG Document Assistant: Multi-provider RAG system, FastAPI, MLflow evaluation
- DSM Research Agent: MCP server for academic paper search across 6 APIs (in progress)

**Process Mining & MLOps:**
- DevFlow Analyzer: LangGraph ReAct agent for CI/CD analysis, 10K+ builds
- Log Processor: ETL pipeline, BPM data to event logs

**Energy Engineering:**
- Residential Heating DS Guide: 6K-line domain knowledge base, German standards documentation
- Residential Energy Apps: Heating curve simulator, Streamlit app, RANSAC regression

**DSM Tooling (dog-fooding):** See also `dsm-docs/core-tools.md` for the authoritative
Core Tools registry (branding, ecosystem-wide updates).
- DSM Graph Explorer: Cross-reference validation, 471 tests, 95% coverage
- Take AI Bite: Public-facing framework distribution, curated DSM subset for external adoption
- DSM Jupyter Book: Automated methodology publishing (planned)
- DSM Blog Poster: Hugo site for methodology insights (planned)

**Other:**
- Political Parties: CHES 2019 dataset analysis
- Loan Approval Prediction: ML classification
- IronCalc: External contribution to open-source spreadsheet engine (Rust)

---

## Version History

**v1.3.0** (2026-03-25):
- Domain-neutrality audit (BL-204): genericized data-science-specific terminology
- Replaced three DS-domain examples with three DSM-track examples (DSM 1.0, 4.0, 5.0)
- Updated template to support any project type, not just data science
- Fixed stale `0_START_HERE` references to `DSM_0.0_START_HERE`

**v1.1.1** (2025-11-19):
- Updated all references to v1.1.1 file structure
- Consolidated content, removed duplication
- Updated file naming references to Appendix E.11
- Streamlined examples with reference-based approach
- Added Quick Reference section
- Aligned with consolidated methodology system

**v1.1.0** (2025-11-19):
- Updated references to hierarchical numbering
- Added appendix references

**v1.0** (2025-11-13):
- Initial release with comprehensive template
- Two domain examples (Time Series, NLP)

---

**End of Implementation Guide**

**For complete methodology system, see:** `DSM_0.0_START_HERE_Complete_Guide.md`  
**For detailed phase guidance, see:** `1.0_Methodology_Appendices.md`
