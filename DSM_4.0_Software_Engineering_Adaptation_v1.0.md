# DSM 4.0: Software Engineering Adaptation

**Version:** 1.3
**Date:** January 2026
**Purpose:** Extend DSM methodology for ML/software engineering projects where the primary deliverable is a working application, not analytical insights.

---

## 1. When to Use This Adaptation

**Use this adaptation when:**
- Building a software application that uses ML components
- Primary deliverable is code/package, not insights/recommendations
- Output is a tool others will use, not a report stakeholders will read
- Project requires software architecture decisions, not analytical decisions

**Examples:**
- LLM-powered applications (chatbots, report generators, agents)
- ML pipelines and tools
- Data processing applications
- API services with ML backends

**Continue using standard DSM (Sections 1-3) when:**
- Primary goal is data analysis and insights
- Deliverables are notebooks, presentations, reports
- Stakeholder communication of findings is the end goal

---

## 2. Project Structure Patterns

Both DSM 1.0 and 4.0 projects keep documentation in-repo under `docs/`. The CLAUDE.md `@` reference imports methodology content from DSM Central.

### 2.1 DSM 1.0 Pattern (Data Science Projects)

**Project Structure:**
```
my-analysis/
├── _inbox/                         # Hub-spoke communication (DSM_3 Section 6.4)
├── notebooks/
├── data/
├── docs/
│   ├── handoffs/                   # Session continuity documents
│   ├── checkpoints/                # Progress checkpoints
│   ├── feedback-to-dsm/            # Methodology feedback (optional)
│   └── research/                   # Research artifacts (if Phase 0.5)
├── outputs/
└── .claude/CLAUDE.md               # Points to central DSM via @ reference
```

**Rationale:**
- All project artifacts in one repository, accessible via git history
- CLAUDE.md `@` reference imports DSM methodology for automatic context
- Session handoffs alongside the code they document

### 2.2 DSM 4.0 Pattern (Software Engineering Projects)

**Project Structure:**
```
D:\data-science\
└── my-application\                 # Single repo for everything
    ├── .claude\
    │   └── CLAUDE.md              # Points to central DSM via @path
    ├── .github\
    │   └── workflows\             # CI/CD pipelines
    ├── _inbox\                    # Hub-spoke communication (DSM_3 Section 6.4)
    ├── src\                       # Source code
    │   ├── __init__.py
    │   └── module\
    ├── tests\                     # Test suite
    │   └── test_module.py
    ├── docs\                      # Project documentation (in-repo)
    │   ├── handoffs\              # Session continuity
    │   ├── decisions\             # Architectural Decision Records (ADRs; Nygard, 2011)
    │   ├── checkpoints\           # Development milestones
    │   ├── feedback\              # DSM methodology feedback
    │   ├── plans\                 # Sprint plans, roadmaps
    │   ├── research\              # State-of-art surveys (if Phase 0.5)
    │   ├── blog\                  # Blog materials (if applicable)
    │   └── guides\                # User-facing documentation (if applicable)
    ├── data\
    │   └── experiments\            # Capability experiments (Section 4.4)
    ├── outputs\                   # Artifacts, reports
    ├── README.md
    ├── pyproject.toml            # Python project config
    └── .gitignore
```

**Rationale:**
- Follows software engineering conventions (standard practice)
- Simpler for contributors (single clone, everything together)
- CI/CD integration (workflows can reference docs easily)
- GitHub/GitLab features work better in-repo (Issues, Projects, Wikis)
- Standard for open-source Python projects

### 2.3 When to Use Each Pattern

| Project Type | Deliverables | Pattern | Examples |
|--------------|--------------|---------|----------|
| **Data Science** | Notebooks, analysis, insights | In-repo `docs/` | TravelTide segmentation, Favorita forecasting, NLP classification |
| **ML Application** | Python packages, APIs, services | In-repo `docs/` | RAG system, prediction API, recommendation engine |
| **Documentation Tool** | CLI tools, parsers, validators | In-repo `docs/` | DSM Graph Explorer, markdown processors |
| **Hybrid** | Notebooks + production code | In-repo `docs/` | Research → production pipeline |

### 2.4 Agent Context

**CLAUDE.md `@` reference pattern:**
- Create `.claude/CLAUDE.md` with `@/path/to/DSM_0.2_Custom_Instructions_v1.1.md`
- The `@` reference imports methodology content automatically
- Project-specific instructions follow after the `@` reference
- Session handoffs in `docs/handoffs/` provide continuity between sessions

### 2.5 Migration Guidance

**Projects with separate `_Project_Knowledge/` repos:** Migrate session artifacts into the main project's `docs/` folder:
- `session_handoffs/` → `docs/handoffs/`
- `decisions/` → tracked via backlog items or `docs/decisions/`
- `checkpoints/` → `docs/checkpoints/`

---

## 3. Adapted Phase Structure

### Standard DSM Phases (Data Science Projects)
```
Phase 0: Environment Setup
Phase 1: Exploration (EDA, cohort definition)
Phase 2: Feature Engineering
Phase 3: Analysis/Modeling
Phase 4: Communication (reports, presentations)
```

### Adapted Phases (Software Engineering Projects)
```
Phase 0: Environment Setup (unchanged)
Phase 1: Data Pipeline (load, validate, transform)
Phase 2: Core Modules (models, services, providers)
Phase 3: Integration & Evaluation (agents, testing, metrics)
Phase 4: Application & Documentation (UI, README, demos)
```

### Phase Mapping

| Adapted Phase | Focus | Key Activities | Deliverables |
|---------------|-------|----------------|--------------|
| **Phase 0** | Environment | venv, requirements, project structure | Working dev environment |
| **Phase 1** | Data Pipeline | Data loading, validation, PM4Py/pandas integration | `process_analyzer.py`, sample data |
| **Phase 2** | Core Modules | Data models, service classes, provider factories | `models.py`, `llm_provider.py`, `llm_reporter.py` |
| **Phase 3** | Integration | Agent orchestration, evaluation pipeline, testing | Agent module, MLflow integration, tests |
| **Phase 4** | Application | Streamlit app, documentation, demo | `app.py`, README, architecture docs |

---

## 4. Development Protocol

### 4.1 Module Development (replaces Notebook Protocol)

When building application modules, follow the **File Creation Loop** defined in
DSM_0.2 (Custom Instructions). The loop enforces a predictable stop-review-continue
rhythm for each file:

1. Show todo list (current file marked in_progress)
2. Show description, stop
3. Ask to proceed (Y/N as plain text), stop
4. If yes, create file via Write/Edit, stop (user reviews diff)
5. Show updated todo list, repeat from step 2

**Build order:** imports → constants → one function → test → next function.
**TDD (Beck, 2003):** Write tests in `tests/` alongside code.

**Anti-Patterns:** Do not batch-generate files, do not use AskUserQuestion for
approvals, do not skip todo list updates between files. See DSM_0.2 for full list.

### 4.2 When to Use Notebooks

Notebooks are appropriate for:
- **Exploration:** Understanding data structure, testing PM4Py functions
- **Demos:** `notebooks/01_demo.ipynb` showing end-to-end flow
- **Prototyping:** Quick experiments before committing to module design

Notebooks are NOT for:
- Production code (use `src/` modules)
- Core application logic
- Code that will be imported elsewhere

### 4.3 Code Organization

```
project/
├── src/
│   ├── __init__.py
│   ├── models.py          # Data classes, Pydantic models
│   ├── process_analyzer.py # PM4Py wrapper
│   ├── llm_provider.py    # Provider factory
│   ├── llm_reporter.py    # LangChain integration
│   └── agent.py           # ReAct agent (if applicable)
├── tests/
│   ├── test_models.py
│   ├── test_analyzer.py
│   └── test_provider.py
├── prompts/
│   └── *.txt              # Prompt templates
├── notebooks/
│   └── 01_demo.ipynb      # Demo/exploration only
├── data/
│   ├── sample/            # Sample datasets
│   └── experiments/       # Capability experiments (C.1.3)
├── app.py                 # Streamlit application
├── requirements.txt
└── README.md
```

#### 4.3.1 Branching Strategy for Development Workflow

All DSM software projects follow the Three-Level Branching Strategy defined in
DSM_0.2:

- **Level 1 (main):** production line, receives only session branch merges
- **Level 2 (session branch):** created at session start, merges to main at wrap-up
- **Level 3 (task branches):** BL branches, sprint branches, or parallel-session
  branches, each with specific merge conditions

For sprint-based projects, each sprint creates a Level 3 sprint branch off the
session branch. BL implementations create Level 3 BL branches. See DSM_0.2
Three-Level Branching Strategy for naming conventions, push policy, and
resumption protocol.

### 4.4 Tests vs Capability Experiments

Software projects use two distinct validation approaches. Understanding when to use each prevents redundancy and gaps.

| Aspect | pytest Tests | Capability Experiments |
|--------|--------------|------------------------|
| **Purpose** | Validate function correctness | Validate end-to-end capability |
| **Scope** | Individual functions/classes | Workflow/feature as a whole |
| **Frequency** | Run on every commit (CI/CD) | Run at milestones/checkpoints |
| **Output** | Pass/Fail assertions | Metrics, findings, limitations |
| **Location** | `tests/` folder | `data/experiments/` |
| **DSM Reference** | Standard TDD practice | C.1.3 Capability Experiment |

**Guidelines:**

1. **Unit tests** validate that individual functions work correctly in isolation
2. **Capability experiments** validate that the feature achieves its intended goal in realistic scenarios
3. Tests should NOT duplicate experiment logic and vice versa
4. Experiments produce metrics for documentation; tests produce pass/fail for CI

**Example (Cross-Lingual Retrieval Feature):**

*pytest tests:*
- `test_huggingface_provider()` - HuggingFace settings configured correctly
- `test_detect_german()` - Language detection identifies German text
- `test_get_german_prompts()` - German prompts returned for "de" code

*Capability experiment (EXP-002):*
- Load multilingual documents
- Test German query → English document retrieval
- Measure cross-lingual retrieval accuracy
- Document findings and limitations

**Key principle:** Tests answer "Does this function work?" while experiments answer "Does this feature achieve its goal?"

**Experiment gate:** Every sprint that introduces a new user-facing capability
must have a defined experiment (EXP-XXX) before implementation begins. See
DSM 2.0 Template 8 (Experiment Gate section) for the sprint planning checklist.
Performance-only sprints may skip the experiment with a justified note.

**Experiment execution:** Once an experiment is defined, follow the Experiment
Execution Protocol in DSM_0.2 for the 9-step checklist (folder creation,
reproducible script, pre-registered criteria, results documentation, registry
update). See Appendix C.1.3 for the 7-element template and C.1.6 for artifact
organization.

**Experiment types:** Not all experiments require the same rigor:

- **Tuning experiments** select cutoff parameters for rule-based tools (thresholds,
  token minimums, scoring cutoffs). No model is trained; the parameter is applied at
  runtime. Grid search over candidate values with a representative sample is sufficient.
- **Model experiments** train ML models where learned weights can overfit. These require
  train/test splits, cross-validation, and hyperparameter search.

Apply the validation rigor that matches the experiment type. Applying model experiment
rigor (holdout sets, cross-validation) to tuning experiments adds complexity without
statistical benefit.

#### 4.4.1. Fixture Validation Principle

Before writing tests against synthetic fixtures, verify the fixture format matches actual production data. Synthetic fixtures that don't match reality cause tests to pass while the implementation is fundamentally broken. The bug compounds as more code is built on the flawed foundation.

**Requirements:**

1. **Inspect real data first** - Before creating fixtures, examine actual files/data the tool will process
2. **Extract, don't invent** - Derive fixture content from real examples rather than assumptions
3. **Early capability experiment** - Run at least one capability experiment on real data in Sprint 1 to validate assumptions before the design is locked in
4. **Format spot-check** - When creating synthetic data that mimics a format (e.g., markdown headings, JSON schemas), compare against 3+ real examples to catch variations

**Sprint 1 checklist addition:**
- [ ] Fixtures validated against real production data (if applicable)

**Why this matters:** Catching format mismatches early (Sprint 1) costs minutes; catching them late (Sprint 3) costs hours of rework. This principle is simple: look at real data before creating fake data.

**Origin:** Discovered during DSM Graph Explorer development where 145 tests passed against a wrong fixture format, causing 448 false errors on first real-world run.

#### 4.4.2. Post-Experiment Contribution Assessment

Capability experiments that validate external libraries routinely discover gaps:
undocumented APIs, missing testing guidance, incomplete examples. These findings
are documented internally (research files, experiment scripts, blog journal) but
represent upstream contribution opportunities if acted on systematically.

**Trigger:** After completing a capability experiment that validates an external
library or tool, assess whether the findings warrant upstream contribution.

**Assessment criteria:**

1. Would other users encounter the same gap?
2. Is the evidence sufficient (reproducible steps, clear description)?
3. Does the contribution align with project goals (visibility, community engagement)?

If all three are met, proceed through the pipeline:

**Pipeline:**

1. **Issue:** Open a GitHub issue on the upstream repo documenting the gap. Include
   experiment context (what was tested, how the gap was discovered). Gauge
   maintainer responsiveness before investing further.
2. **Blog post:** Write a post narrating the discovery process, showing how
   structured experiments surface gaps that ad-hoc usage misses. Follow the blog
   pipeline in DSM_0.1.
3. **PR:** If maintainers are responsive, contribute the fix. Follow the External
   Contribution governance in DSM_3 Section 6.6.

**Scaling:** This applies across all spoke projects. Any experiment validating an
external library is a potential pipeline trigger.

**Origin:** DSM Graph Explorer Sessions 33-34, EXP-005 (FalkorDBLite validation)
discovered 5 documentation gaps and led to FalkorDB/falkordblite#85.

### 4.5 Package Verification

When the agent suggests installing packages (`pip install`, `npm install`, or
equivalent), verify before installing. Supply chain attacks via typosquatting
(publishing malicious packages with names similar to popular ones) are a known
risk (OWASP LLM03).

**Verification steps:**

1. **Check the package name:** Verify spelling against the official package
   index (PyPI, npm). Common typosquatting targets: `requests` vs `request`,
   `python-dateutil` vs `dateutil`, `beautifulsoup4` vs `beautifulsoup`.
2. **Check package metadata:** For unfamiliar packages, verify:
   - Download count (low downloads on a supposedly popular package is a red flag)
   - Publication date (very recent packages with generic names warrant caution)
   - Maintainer identity (known maintainer or organization vs anonymous)
3. **Prefer pinned requirements:** Use `requirements.txt`, `pyproject.toml`, or
   lock files with pinned versions over ad-hoc `pip install` commands. Pinned
   dependencies are reproducible and auditable.
4. **Verify before upgrading:** When upgrading a dependency, check the changelog
   for breaking changes. Major version bumps (`1.x` to `2.x`) warrant reading
   the migration guide before upgrading.

**When this applies:**
- Any `pip install` or `npm install` for a package not already in the project's
  dependency files
- Adding new dependencies to requirements files
- Upgrading existing dependencies

**When this does not apply:**
- Installing packages already listed in the project's pinned requirements
- Standard library modules
- DSM setup scripts (`setup_base_environment_*.py`) which use curated package lists

**Anti-Patterns:**

**DO NOT:**
- Install packages from URLs or git repositories without user confirmation
- Add dependencies without checking if an existing dependency already provides
  the needed functionality
- Install packages with broad system-level permissions when a virtual environment
  is available

### 4.6 Bug Disambiguation

When a user reports "bug persists" or "still broken," re-verify that the current
symptoms match the previously identified bug before assuming the same root cause.
Symptoms that sound similar may stem from different issues, and conflating them
wastes debugging effort on the wrong path.

**Before resuming a fix:** Ask whether the symptoms are identical or whether the
behavior has changed. If the behavior has changed, treat it as a new issue and
investigate from scratch.

### 4.7 PR Description Maintenance

When a PR's scope expands during development (additional bugs found, scope creep,
new files added), update the PR title and body before the next commit push, not
at review time. Stale PR metadata misleads reviewers and makes the contribution
history harder to follow.

**Trigger:** Any commit that adds work outside the original PR description.

---

## 5. Decision Log Adaptation

### Standard DSM Decision Log (Analytical)
Focuses on: feature selection, model choice, hyperparameters, cohort definition

### Adapted Decision Log (Architectural)
Focuses on: design patterns, library choices, API design, trade-offs

**Template:**

```markdown
## DEC-XXX: [Decision Title]

**Category:** Architecture | Library Choice | API Design | Data Model

**Context:**
[What problem or choice prompted this decision?]

**Decision:**
[What was decided?]

**Alternatives Considered:**
1. [Alternative 1] - Rejected because [reason]
2. [Alternative 2] - Rejected because [reason]

**Rationale:**
[Why this choice?]

**Implications:**
- [What this enables]
- [What this constrains]
- [Future considerations]
```

**Example:**

```markdown
## DEC-001: Provider-Agnostic LLM Factory

**Category:** Architecture

**Context:**
Need to support multiple LLM providers (Anthropic, OpenAI, Ollama) with consistent interface.

**Decision:**
Factory pattern with `AVAILABLE_MODELS` registry and `create_llm()` function.

**Alternatives Considered:**
1. Direct instantiation per provider - Rejected: code duplication, harder to switch
2. Dependency injection container - Rejected: over-engineering for project scope
3. Abstract base class with implementations - Rejected: more boilerplate than needed

**Rationale:**
Factory pattern provides simple, extensible design. Adding new providers requires only:
1. Add entry to AVAILABLE_MODELS
2. Implement _create_[provider]() function

**Implications:**
- Enables runtime provider switching via config
- All providers must conform to LangChain BaseChatModel interface
- Cost tracking possible via ModelConfig dataclass
```

---

## 6. Success Criteria Adaptation

### Standard DSM Success Criteria (Analytical)
- Statistical validity of findings
- Business interpretability
- Stakeholder acceptance
- Reproducible analysis

### Adapted Success Criteria (Software Engineering)

**Functional:**
- [ ] End-to-end pipeline works (data → processing → output)
- [ ] All core features implemented per requirements
- [ ] Error handling for common failure modes

**Code Quality:**
- [ ] Modular, well-organized codebase
- [ ] Functions/classes have docstrings
- [ ] No hardcoded secrets or paths
- [ ] Type hints on public interfaces

**Testing:**
- [ ] Unit tests for core modules
- [ ] Integration test for full pipeline
- [ ] Tests pass in CI (if applicable)

**Documentation:**
- [ ] README with setup instructions
- [ ] Architecture overview
- [ ] API/usage examples
- [ ] Decision log for key choices

**Demo:**
- [ ] Working interactive demo (Streamlit/CLI)
- [ ] Sample data included
- [ ] Demo runs without external dependencies (or documents them)

---

## 7. Portfolio Project Checklist

For projects intended to demonstrate skills (job applications, portfolio):

### Repository Quality
- [ ] Clear, descriptive README
- [ ] Architecture diagram
- [ ] Setup instructions that work
- [ ] Sample data or instructions to obtain it
- [ ] License file

### Code Demonstrates
- [ ] Clean separation of concerns
- [ ] Design patterns where appropriate
- [ ] Error handling
- [ ] Configuration management (env vars, not hardcoded)
- [ ] Logging (not print statements in production code)

### ML/AI Specific
- [ ] Reproducible experiments (seed, logging)
- [ ] Evaluation metrics defined and tracked
- [ ] Model/prompt versioning
- [ ] Clear distinction between training and inference (if applicable)

### ML Engineer Portfolio
- [ ] Demonstrates ML system design from scratch
- [ ] Shows ability to apply and integrate existing models
- [ ] Includes evaluation pipeline with metrics
- [ ] Code is in Python with type hints
- [ ] Modern frameworks (LangChain, HuggingFace, PyTorch)
- [ ] Agentic patterns where applicable

---

## 8. Sprint Planning for SW Projects

### Example: 4-Day ML Application Project

**Day 1: Foundation**
- Phase 0: Environment setup
- Phase 1: Data pipeline
- Deliverable: Working data loading and basic analysis

**Day 2: Core Implementation**
- Phase 2: Core modules
- Deliverable: All main classes/functions implemented

**Day 3: Integration & Testing**
- Phase 3: Integration, evaluation, testing
- Deliverable: End-to-end flow works, tests pass

**Day 4: Polish & Documentation**
- Phase 4: Application, documentation
- Deliverable: Demo app, README, ready for showcase

### Time Allocation Guidance

| Phase | Typical Allocation | Notes |
|-------|-------------------|-------|
| Phase 0 | 5-10% | Should be quick if reusing setup scripts |
| Phase 1 | 15-20% | Depends on data complexity |
| Phase 2 | 30-40% | Core development work |
| Phase 3 | 20-25% | Integration often reveals issues |
| Phase 4 | 15-20% | Don't underestimate documentation |

---

## 9. Integration with Standard DSM

This adaptation **extends** DSM, it doesn't replace it.

**Continue using from standard DSM:**
- Section 1.3: Core Philosophy (communication style, factual accuracy)
- Section 3: Communication & Working Style
- Section 6: Tools & Best Practices (where applicable)
- Appendix A: Environment Setup Details
- Appendix E: Quick Reference (file naming, commands)

**Replace with this adaptation:**
- Section 2: Core Workflow (use adapted phases)
- Section 4.1: Decision Log (use architectural template)
- Section 2.5: Communication phase (use documentation focus)

**Reference as needed:**
- PM Guidelines: For sprint planning structure
- Appendix C: Advanced practices (experiment tracking, testing)
- Appendix C.1.3-C.1.5: Capability experiments, RAG evaluation metrics, limitation discovery (for software/RAG projects)

---

## 10. Streamlit Cloud Deployment Checklist

When deploying to Streamlit Community Cloud:

### Required Files

```
project/
├── app.py                    # Main Streamlit application
├── requirements.txt          # Python dependencies
├── packages.txt              # System dependencies (apt-get)
└── .streamlit/
    ├── config.toml           # Theme and server settings
    └── secrets.toml.example  # Template for secrets (DO NOT commit actual secrets)
```

### packages.txt

For system-level dependencies (e.g., graphviz):

```
graphviz
```

### .streamlit/config.toml

```toml
[theme]
primaryColor = "#FF6B6B"
backgroundColor = "#FFFFFF"
secondaryBackgroundColor = "#F0F2F6"
textColor = "#262730"

[server]
headless = true
```

### Secrets Handling Pattern

Support both local development and cloud deployment:

```python
# Load API keys - handle both local (.env) and cloud (secrets.toml)
try:
    # Try Streamlit Cloud secrets first
    api_key = st.secrets["OPENAI_API_KEY"]
except (FileNotFoundError, KeyError):
    # Fall back to environment variables for local dev
    from dotenv import load_dotenv
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
```

### Common Deployment Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `StreamlitSecretNotFoundError` | Missing secrets.toml | Add try/except pattern above |
| `ExecutableNotFound: graphviz` | Missing system dependency | Add `packages.txt` with `graphviz` |
| `ModuleNotFoundError` | Missing Python package | Add to `requirements.txt` |

---

## 11. Session State Patterns for Multi-Tab Apps

### Cross-Tab Data Sharing

Use `st.session_state` to share data between tabs:

```python
# Initialize session state
if "run_history" not in st.session_state:
    st.session_state.run_history = []

if "analysis_result" not in st.session_state:
    st.session_state.analysis_result = None
```

### Run Tracking Pattern

Auto-log metrics after each LLM operation:

```python
def log_run(question, response, model, latency_ms, cost_usd, input_tokens, output_tokens):
    run = {
        "run_id": str(uuid.uuid4())[:8],
        "timestamp": datetime.now().strftime("%H:%M:%S"),
        "question": question,
        "response": response,
        "model": model,
        "latency_ms": latency_ms,
        "cost_usd": cost_usd,
        "input_tokens": input_tokens,
        "output_tokens": output_tokens,
        # Auto-calculated metrics
        "tokens_per_second": output_tokens / (latency_ms / 1000) if latency_ms > 0 else 0,
        "response_length": len(response),
    }
    st.session_state.run_history.append(run)
```

### Data Fingerprinting for Valid Comparisons

Generate a hash of loaded data to ensure comparisons are valid:

```python
import hashlib

def compute_dataset_hash(df: pd.DataFrame) -> str:
    """Create fingerprint of dataset for tracking."""
    content = f"{len(df)}_{list(df.columns)}_{df.iloc[0].to_dict() if len(df) > 0 else ''}"
    return hashlib.md5(content.encode()).hexdigest()[:8]
```

Display in UI:
```python
st.sidebar.caption(f"📊 Data fingerprint: `{dataset_hash}`")
```

---

## 12. A/B Testing UX Guidelines

### Terminology Matters

| Avoid | Use Instead | Why |
|-------|-------------|-----|
| "Experiment Group" | "Label" | More intuitive for users |
| "Group Comparison" | "Compare by Label" | Clearer action |
| "Dataset Hash" | "Data fingerprint" | Less technical |

### Sidebar Configuration

```python
st.sidebar.markdown("### 🧪 A/B Testing")
st.sidebar.markdown("<small>Compare configurations by labeling runs:</small>", unsafe_allow_html=True)

label = st.sidebar.text_input(
    "Label this run",
    placeholder="e.g., gpt4o-mini-test",
    help="Label runs to compare them in the Evaluation tab"
)

if label:
    st.sidebar.success(f"✓ Runs will be tagged: **{label}**")
else:
    st.sidebar.caption("💡 Leave blank for one-off queries")
```

### Empty State Instructions

Provide step-by-step guidance when no data exists:

```python
if not st.session_state.run_history:
    st.info("📭 **No runs yet.** Go to the **Agent** tab to get started.")

    st.markdown("### 🧪 How to Compare Models")
    st.markdown("""
    | Step | Action |
    |------|--------|
    | 1 | Go to **Agent** tab |
    | 2 | Set sidebar label to `gpt4o-mini` |
    | 3 | Ask a question |
    | 4 | Change model to **GPT-4o** |
    | 5 | Set label to `gpt4o` |
    | 6 | Ask the **same question** |
    | 7 | Return here to compare |
    """)
```

---

## 13. LLM Cost Tracking Pattern

### Model Pricing Registry

```python
MODEL_COSTS = {
    "gpt-4o-mini": {"input": 0.15 / 1_000_000, "output": 0.60 / 1_000_000},
    "gpt-4o": {"input": 5.00 / 1_000_000, "output": 15.00 / 1_000_000},
}

def calculate_cost(model: str, input_tokens: int, output_tokens: int) -> float:
    costs = MODEL_COSTS.get(model, {"input": 0, "output": 0})
    return (input_tokens * costs["input"]) + (output_tokens * costs["output"])
```

### Display Running Totals

```python
total_cost = sum(r["cost_usd"] for r in st.session_state.run_history)
st.metric("Total Cost", f"${total_cost:.4f}")
```

### Per-Run Cost Display

```python
st.caption(f"⏱️ {latency/1000:.1f}s | 💰 ${cost:.4f}")
```

---

## 14. Sprint Planning Template

### BACKLOG.md Structure

```markdown
# Product Backlog

## Priority Definitions
- **P0**: Critical for MVP
- **P1**: Important, next sprint
- **P2**: Nice to have
- **P3**: Future consideration

## Backlog Items

### P0 - Critical
- [ ] Item 1: Description

### P1 - Important
- [ ] Item 2: Description

### P2 - Nice to Have
- [ ] Item 3: Description

### P3 - Future
- [ ] Item 4: Description
```

### SPRINT_X.md Structure

```markdown
# Sprint X: [Theme]

**Duration:** X days
**Goal:** [One sentence]

## Day 1: [Focus]
- [ ] Task 1
- [ ] Task 2

## Day 2: [Focus]
- [ ] Task 3
- [ ] Task 4

## Success Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Risks
- Risk 1: [Mitigation]
```

---

## 15. GitHub Repository Setup Checklist

### Repository Settings

| Field | Guidelines | Example |
|-------|------------|---------|
| **Description** | Under 100 chars, action-oriented | "Agentic ML system for CI/CD analysis using process mining and LLMs" |
| **Website** | Link to live demo | `https://your-app.streamlit.app/` |
| **Topics** | 8-12 keywords for discoverability | `process-mining ci-cd llm langchain streamlit openai python` |

### README Essentials

- [ ] One-sentence description
- [ ] Live demo link (if deployed)
- [ ] Architecture diagram
- [ ] Features list
- [ ] Installation instructions
- [ ] Usage examples
- [ ] Development progress/roadmap
- [ ] License
- [ ] Author info

### IDE Configuration (VS Code)

Auto-configure the Python environment so developers do not need to manually
select the interpreter each time they open the project.

**`.vscode/settings.json`:**

```json
{
    "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
    "python.testing.pytestArgs": ["tests"],
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true
}
```

| Setting | Purpose |
|---------|---------|
| `python.defaultInterpreterPath` | Auto-select project virtual environment |
| `python.testing.pytestArgs` | Configure test discovery directory |
| `python.testing.pytestEnabled` | Enable pytest integration in VS Code |

**Cross-platform note:** The path `.venv/bin/python` works on Linux/Mac.
On Windows, the actual path is `.venv\Scripts\python.exe`, but VS Code resolves
`${workspaceFolder}/.venv/bin/python` correctly on all platforms.

**Optional: `.vscode/extensions.json`:**

```json
{
    "recommendations": [
        "ms-python.python",
        "ms-python.vscode-pylance"
    ]
}
```

This prompts collaborators to install recommended extensions when opening the project.

**Claude Code Permission Mode:**

When using Claude Code (CLI or VS Code extension), verify the permission mode
preserves human-in-the-loop review. The default mode may auto-accept file edits
without showing a diff approval dialog.

```json
{
    "claudeCode.initialPermissionMode": "default"
}
```

Set this in VS Code user or workspace settings. The `default` mode requires
explicit approval for file writes, maintaining the Pre-Generation Brief Protocol
and human review of all changes. Without this, the agent may write multiple files
before the user notices changes were auto-applied.

Cross-reference: Section 3 (Development Protocol), Appendix A.7 (Environment Tool Selection)

---

## 16. Beyond DSM: Production & MLOps

DSM focuses on building ML applications through the 4-phase workflow. For production deployment and operations, these established frameworks and resources are recommended:

### MLOps Maturity Models
- **Google MLOps Maturity Model** (Levels 0-2): Progression from manual ML to full CI/CD for ML
- **Microsoft ML Maturity Model**: Enterprise-focused maturity assessment

### Model & Data Documentation
- **Model Cards** (Mitchell et al., 2019): Standardized model documentation
- **Data Cards** (Google, 2022): Dataset documentation standards

### Deployment Patterns
- **Shadow Mode**: New model runs parallel, predictions logged but not served
- **Canary Deployment**: Gradual traffic shift (5% → 100%)
- **Blue/Green**: Instant switchover with easy rollback
- **Champion/Challenger**: Statistical testing for model promotion

### Data Quality & Monitoring
- **Great Expectations**: Data validation framework
- **dbt**: Data transformation and testing
- **Model drift detection**: Performance degradation monitoring
- **Data drift detection**: Feature distribution monitoring

These topics are outside DSM scope but are important for production ML systems. DSM provides the foundation for building working ML applications; these resources extend into production operations.

---

## 17. Version History

**v1.3 (January 2026):**
- Added Section 2: Project Structure Patterns (BACKLOG-038)
  - Unified in-repo `docs/` pattern for both DSM 1.0 and 4.0
  - CLAUDE.md `@` reference for methodology context
  - Migration guidance for legacy `_Project_Knowledge/` repos
  - Renumbered all subsequent sections (old Section 2 → Section 3, etc.)

**v1.2 (January 2026):**
- Added Beyond DSM: Production & MLOps section (Section 16) - lightweight references to MLOps resources

**v1.1 (January 2026):**
- Added Streamlit Cloud deployment checklist (Section 9)
- Added session state patterns (Section 10)
- Added A/B testing UX guidelines (Section 11)
- Added LLM cost tracking pattern (Section 12)
- Added sprint planning templates (Section 13)
- Added GitHub repository setup checklist (Section 14)

**v1.0 (January 2026):**
- Initial release
- Created for DevFlow Analyzer project (ML application portfolio)
- Adapted from DSM 1.1 for software engineering context

---

## References

- Beck, K. (2003). *Test-Driven Development: By Example*. Addison-Wesley.
- Nygard, M. (2011). [Documenting Architecture Decisions](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions). Cognitect Blog.
