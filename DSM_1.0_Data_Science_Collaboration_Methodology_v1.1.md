# Data Science Project Collaboration Methodology
## Working Framework for Human-AI Collaboration
### Academic Edition v1.1

**Version:** 1.3.0 (Academic Edition)
**Date:** January 2026
**Purpose:** Standard operating procedures for data science projects across domains, optimized for academic tasks with extensibility for advanced complexity

**This document is part of an Integrated System** → Refer to `0_Integrated_System_Guide-START-HERE.md` for complete guide

## Contents

1. [Introduction](#1-introduction)
2. [Module Dispatch Table](#module-dispatch-table)
3. [Version History and Closing](#8-version-history--closing)

---

## 1. Introduction

This section covers the methodology's purpose, target audience, core philosophy,
and accuracy standards for data science work.

### 1.1. Overview & Purpose

This methodology provides a systematic framework for collaborative data science projects between human analysts and an AI agent. It emerged from real-world project experience where rigorous methodology enabled data-driven pivots and successful stakeholder communication.

**Core Value Proposition:**
- **Systematic Workflow:** 4-phase process from environment setup through communication
- **Quality Standards:** Reproducible notebooks, clear documentation, validated decisions
- **Scalability:** Core practices for all projects + advanced practices for complex scenarios
- **Stakeholder Focus:** Technical rigor balanced with business communication needs

### 1.2. When to Use This Methodology

**Ideal For:**
- Academic data science projects (thesis, coursework, research)
- Exploratory analysis with uncertain requirements
- Projects requiring stakeholder communication (technical + non-technical audiences)
- Iterative development with AI agent collaboration
- Projects where requirements may pivot based on data insights

**Best Fit Scenarios:**
- Analytical projects requiring structured exploration and validation
- Predictive modeling with business constraints
- Feature engineering from raw data sources
- Multi-stakeholder projects requiring documentation at various technical levels
- Projects with 4-8 sprint timelines and iterative deliverables

**Not Ideal For:**
- Simple one-off analyses (<4 hours total work)
- Projects with complete, unchanging specifications
- Real-time production systems (though methodology can inform development)
- Projects without need for documentation or reproducibility

**For Software Engineering Projects:**
If your primary deliverable is a working application (not analytical insights), see **DSM 4.0: Software Engineering Adaptation** which provides adapted phases, architectural decision templates, and code organization standards for ML application development.

### 1.3. Core Philosophy

#### 1.3.1. Communication Style
- **Concise responses**: Direct answers without unnecessary elaboration
- **Clarifying questions first**: Before generating artifacts or lengthy outputs, confirm understanding
- **Token monitoring**: Track conversation length and warn at 95% capacity for session summary
- **Text conventions**:
  - Use "WARNING:" instead of warning emoji
  - Use "OK:" instead of checkmark
  - Use "ERROR:" instead of cross mark
  - No emojis in professional deliverables

#### 1.3.2. Project Structure Philosophy
- **Phased approach**: Break complex projects into 3-5 major phases
- **Sprint iteration cycles**: Each sprint represents a distinct analytical stage
- **Daily objectives**: Each day within a sprint has clear deliverables
- **Progressive execution**: Each phase builds on validated outputs from previous stages

#### 1.3.3. Code Organization Standards
- **Consolidated notebooks**: Prefer fewer, well-structured notebooks (~400 lines, 5-6 sections) over many small files
- **Stage-based naming**: Use sequential numbers with descriptive names (See Section 3.3 for details)
- **Section structure per notebook**:
  1. Setup & environment configuration
  2. Data loading & validation
  3. Core processing (3-4 sections)
  4. Validation & export
  5. Summary & next steps
- **Path management**: Relative paths with constants defined at notebook start
- **Reproducibility**: Each notebook must run end-to-end without manual intervention

#### 1.3.4. Data-Driven Decision Making
- **Validate assumptions**: Never trust predetermined business expectations without verification
- **Pivot when necessary**: Statistical validity overrides initial hypotheses
- **Document decisions**: Every significant choice needs rationale and evidence (See Section 4.1)
- **Honest limitations**: Better to remove uncertain features than include misleading metrics

#### 1.3.5. Factual Accuracy - No Guessing

**Core Principle:** Never provide information based on estimation, assumption, or speculation in data science work.

**Requirements:**

1. **Token Counting:**
   - ONLY report from system warnings
   - Never estimate manually ("I think we've used about 150K tokens")
   - Wait for: "Token usage: 73372/190000"
   - Report exactly: "Current: 73K tokens (38%), 117K remaining"

2. **Data Metrics:**
   - ONLY report actual computed values
   - Never approximate: "About 300,000 rows"
   - Always compute: `print(f"Rows: {len(df):,}")`
   - Result: "Rows: 300,896"

3. **File Locations:**
   - ONLY reference confirmed paths
   - Never assume: "The file is probably in data/processed/"
   - Always check: `Path('data/processed/file.pkl').exists()`

4. **Code Results:**
   - ONLY state what actual output shows
   - Never predict: "This should give you around 0.6 correlation"
   - Always verify: Run code, report actual result

5. **Decision References:**
   - ONLY cite documented decisions
   - Never paraphrase from memory: "I think we decided to use XGBoost"
   - Always reference: "DEC-014: Selected XGBoost based on ablation study"

**When Uncertain:**

```
OK: "I need to check [source] to confirm"
OK: "Can you run [command] so I can see the actual result?"
OK: "I don't have that information available"
OK: "We could find this out by [approach]"

ERROR: "Approximately..." (without computing from data)
ERROR: "Should be around..." (without verification)
ERROR: "I estimate..." (without basis)
ERROR: "Probably..." (without evidence)
```

**Especially Critical For:**
- Performance metrics (RMSE, accuracy, improvement percentages)
- Resource usage (tokens, memory, GPU utilization)
- Data dimensions (row counts, feature counts)
- File sizes and locations
- Decision log references
- Statistical test results
- Model hyperparameters

**This is non-negotiable in data science where precision and reproducibility are paramount.**

### 1.4. Version History

**v1.1 (November 2025):**
- Reorganized with hierarchical numbering (4 levels: # ## ### ####)
- Split detailed content into 5 appendices for better maintainability
- Enhanced cross-referencing system
- Improved navigation without Table of Contents
- All content preserved from v1.0, better organized

**v1.0 (November 2025):**
- Initial academic edition release
- Based on real-world data science project experience
- Integrated 4-phase workflow with advanced complexity practices
- Comprehensive decision-making and stakeholder communication frameworks

---

## Module Dispatch Table

DSM 1.0 content is split into this core file and four on-demand modules. When a
task requires content from a module, read the corresponding file using the Read
tool before applying the guidance.

All module files are in the same directory as this core file.

### Core Sections (this file)

| § | Content |
|---|---------|
| 1 | Introduction (Overview, Philosophy, Accuracy Standards) |
| 8 | Version History & Closing (Getting Started, Customization, Extensibility) |

### Module Protocols (on-demand)

| § | Content | Module |
|---|---------|--------|
| 2 | Core Workflow: Phase 0 (Environment Setup), Phase 1 (Exploration), Phase 2 (Feature Engineering), Phase 3 (Analysis), Phase 4 (Communication) | [A](DSM_1.0.A_Core_Workflow.md) |
| 3 | Working Standards: Notebook Structure, Code Standards, File Naming, Directory Structure, Feature Dictionary, Inclusive Language | [B](DSM_1.0.B_Working_Standards.md) |
| 4 | Essential Practices (Tier 1): Decision Log Framework, Hypothesis Testing, Pivot Criteria, Stakeholder Communication | [C](DSM_1.0.C_Practices.md) |
| 5 | Advanced Practices (Tiers 2-4): Experiment Tracking, Hypothesis Management, Ethics/Bias, Testing, Data Versioning, Scalability, Literature Review, Risk Management | [C](DSM_1.0.C_Practices.md) |
| 6 | Session & Quality Management: Token Monitoring, Handoffs, Daily Documentation, Quality Assurance, Troubleshooting, Checkpoint/Feedback, Gateway Review | [D](DSM_1.0.D_Session_Quality.md) |
| 7 | Progressive Execution with the Agent: Cell-by-Cell Development, Validation Patterns, Collaboration Best Practices | [B](DSM_1.0.B_Working_Standards.md) |

---

## 8. Version History & Closing

This section contains version history, getting started guidance, extensibility
notes, appendix references, and future enhancement plans.

### 8.1. Version History

**v1.1.1 (November 2025):**
- File consolidation for better maintainability
- Getting started files consolidated: 3→1 (`0_START_HERE_Complete_Guide.md`)
- Appendices consolidated: 5→1 (`1.0_Methodology_Appendices.md`)
- Repository files reduced from 20 to 13 (-35%)
- All cross-references and content preserved
- Section numbering unchanged for backward compatibility

**v1.1 (November 2025):**
- Reorganized with 4-level hierarchical numbering (# ## ### ####)
- Split into main document (~1,400 lines) + 5 appendices (~800 lines)
- Enhanced navigation without Table of Contents
- Added comprehensive cross-referencing system
- Improved section findability and maintainability
- All v1.0 content preserved, better organized

**Content Structure Changes:**
- Main doc: Core workflow, essential practices, advanced practices overview
- Appendix A: Environment setup details
- Appendix B: Phase deep dives with examples
- Appendix C: Advanced practices detailed implementation
- Appendix D: Domain-specific adaptations
- Appendix E: Quick reference tables

**v1.0 (November 2025):**
- Initial academic edition release
- Based on real-world data science project experience
- Integrated 4-phase workflow (Phases 0-4)
- Essential Tier 1 practices (decision log, pivot criteria, stakeholder communication)
- Advanced practices (Tiers 2-4) for selective use
- Comprehensive stakeholder communication framework
- Progressive execution patterns with the agent

---

### 8.2. Using This Methodology

#### 8.2.1. Getting Started

**For New Projects:**
1. Read Section 1 (Introduction) to understand when this methodology applies
2. Review Module A, Section 2 (Core Workflow) to understand the 4-phase process
3. Check Module B, Section 3 (Working Standards) for notebook and code standards
4. Execute Phase 0 (Module A, Section 2.1) to set up your environment
5. Begin Phase 1 (Module A, Section 2.2) with exploratory data analysis

**For Experienced Users:**
- Reference Module C, Section 4 for decision log, pivots, stakeholder communication
- Consult Module C, Section 5 when project complexity increases
- Use Module D, Section 6 for quality assurance and session management
- Refer to Module B, Section 7 for effective agent collaboration patterns

**When Stuck:**
- Check Module D, Section 6.3 (Troubleshooting) for common issues
- Review Appendix B for detailed phase guidance
- Consult Appendix C for advanced practice implementations
- Reference decision log examples (Module C, Section 4.1.4)

#### 8.2.2. Customization Guidelines

**Adapt This Methodology:**
- Phase names and lengths (adjust to your domain)
- Advanced practices selection (activate as needed)
- Stakeholder communication frequency (match your project)
- File naming conventions (if organizational standards differ)

**Don't Change:**
- Core principle of documentation (decision logs, feature dictionaries)
- Progressive execution pattern (cell-by-cell validation)
- Data-driven decision making (let data guide pivots)
- Quality standards (reproducibility, clear outputs)

#### 8.2.3. Domain Adaptations

**For domain-specific guidance:**
- Time Series: See Appendix D.1
- NLP: See Appendix D.2
- Computer Vision: See Appendix D.3
- Clustering: See Appendix D.4
- Regression/Classification: See Appendix D.5

**Common Adaptations:**
- Different feature engineering for different domains
- Domain-specific validation metrics
- Specialized visualization requirements
- Domain literature and best practices

---

### 8.3. Extensibility

**This Methodology Supports:**
- Addition of domain-specific practices
- Integration with organizational standards
- Extension to production environments
- Scaling to team collaboration

**Future Enhancement Areas:**
- Automated testing frameworks
- CI/CD pipeline integration
- Model monitoring and maintenance
- MLOps tooling integration
- Advanced deployment patterns

**Contributing:**
This methodology is open for feedback and contributions. Suggested additions or improvements welcome through project repository.

---

### 8.4. Appendix References

**Complete methodology system includes:**
- **This document:** Core methodology (slim core + module dispatch table)
- **Module A:** Core Workflow (4-Phase Process)
- **Module B:** Working Standards + Progressive Execution
- **Module C:** Essential + Advanced Practices
- **Module D:** Session & Quality Management
- **Appendices (consolidated):** `DSM_1.0_Methodology_Appendices.md`
  - Appendix A: Environment Setup Details
  - Appendix B: Phase Deep Dives
  - Appendix C: Advanced Practices Detailed
  - Appendix D: Domain Adaptations
  - Appendix E: Quick Reference + File Naming Standards

**Related Documents:**
- `0_Integrated_System_Guide-START-HERE.md`: Complete getting started guide
- `DSM_2.0_ProjectManagement_Guidelines_v2_v1.1.md`: Project planning framework
- `DSM_3.0_Methodology_Implementation_Guide_v1.1.md`: Step-by-step implementation

---

### 8.5. Future Enhancements

**Planned Additions:**
- Case study examples from multiple domains
- Video walkthroughs of methodology application
- Template notebooks for each phase
- Automated project setup scripts
- Integration with popular ML platforms
- Domain-specific deep dives

**Community Feedback:**
- Submit issues and suggestions via repository
- Share your project experiences
- Contribute domain adaptations
- Propose methodology improvements

---

**End of Main Methodology Document**

**Version:** 1.3.0 (Academic Edition)
**Last Updated:** January 2026
**Next Review:** Quarterly updates based on project learnings

**For complete details on advanced topics, see appendices A-E and modules A-D.**
