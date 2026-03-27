# DSM 4.0 Module A: Development Quality and Verification

**Parent document:** [DSM 4.0 Software Engineering Adaptation](DSM_4.0_Software_Engineering_Adaptation_v1.0.md)
**Purpose:** Testing strategies, verification protocols, decision logging, and success criteria for software engineering projects.

This module contains the quality and verification protocols that complement the
core development workflow in DSM 4.0. Load this module when writing tests,
verifying packages, recording architectural decisions, or defining success
criteria.

## Contents

1. [Tests and Capability Experiments Distinction](#1-tests-and-capability-experiments-distinction)
2. [Package Verification Protocol for Dependencies](#2-package-verification-protocol-for-dependencies)
3. [Bug Disambiguation Protocol for Recurring Issues](#3-bug-disambiguation-protocol-for-recurring-issues)
4. [PR Description Maintenance Protocol](#4-pr-description-maintenance-protocol)
5. [Decision Log Adaptation for Software Projects](#5-decision-log-adaptation-for-software-projects)
6. [Success Criteria Adaptation for Software Projects](#6-success-criteria-adaptation-for-software-projects)

## Document Structure Index

| § | Section | Description |
|---|---------|-------------|
| 1 | Tests and Capability Experiments Distinction | When to use pytest vs capability experiments, fixture validation |
| 2 | Package Verification Protocol for Dependencies | Supply chain safety checks before installing dependencies |
| 3 | Bug Disambiguation Protocol for Recurring Issues | Re-verifying symptoms before resuming a fix |
| 4 | PR Description Maintenance Protocol | Keeping PR metadata current as scope expands |
| 5 | Decision Log Adaptation for Software Projects | Architectural decision template for software projects |
| 6 | Success Criteria Adaptation for Software Projects | Functional, code quality, testing, and documentation checklists |

---

## 1. Tests and Capability Experiments Distinction

Software projects use two distinct validation approaches. Understanding when to
use each prevents redundancy and gaps.

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

**Example (Search Relevance Feature):**

*pytest tests:*
- `test_search_provider()` - Search backend settings configured correctly
- `test_query_parsing()` - Query parser handles edge cases
- `test_result_ranking()` - Results ranked by relevance score

*Capability experiment (EXP-002):*
- Load representative document corpus
- Test queries across multiple categories
- Measure retrieval precision and recall
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

### 1.1. Fixture Validation Principle for Tests

Before writing tests against synthetic fixtures, verify the fixture format
matches actual production data. Synthetic fixtures that don't match reality
cause tests to pass while the implementation is fundamentally broken. The bug
compounds as more code is built on the flawed foundation.

**Requirements:**

1. **Inspect real data first** - Before creating fixtures, examine actual files/data the tool will process
2. **Extract, don't invent** - Derive fixture content from real examples rather than assumptions
3. **Early capability experiment** - Run at least one capability experiment on real data in Sprint 1 to validate assumptions before the design is locked in
4. **Format spot-check** - When creating synthetic data that mimics a format (e.g., markdown headings, JSON schemas), compare against 3+ real examples to catch variations

**Sprint 1 checklist addition:**
- [ ] Fixtures validated against real production data (if applicable)

**Why this matters:** Catching format mismatches early (Sprint 1) costs minutes; catching them late (Sprint 3) costs hours of rework. This principle is simple: look at real data before creating fake data.

**Origin:** Discovered during DSM Graph Explorer development where 145 tests passed against a wrong fixture format, causing 448 false errors on first real-world run.

### 1.2. Post-Experiment Upstream Contribution Assessment

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

---

## 2. Package Verification Protocol for Dependencies

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

---

## 3. Bug Disambiguation Protocol for Recurring Issues

When a user reports "bug persists" or "still broken," re-verify that the current
symptoms match the previously identified bug before assuming the same root cause.
Symptoms that sound similar may stem from different issues, and conflating them
wastes debugging effort on the wrong path.

**Before resuming a fix:** Ask whether the symptoms are identical or whether the
behavior has changed. If the behavior has changed, treat it as a new issue and
investigate from scratch.

---

## 4. PR Description Maintenance Protocol

When a PR's scope expands during development (additional bugs found, scope creep,
new files added), update the PR title and body before the next commit push, not
at review time. Stale PR metadata misleads reviewers and makes the contribution
history harder to follow.

**Trigger:** Any commit that adds work outside the original PR description.

---

## 5. Decision Log Adaptation for Software Projects

Software engineering projects use architectural decision records instead of the
standard DSM analytical decision log. This section provides the adapted template
and an example.

### 5.1. Standard vs Adapted Decision Log Focus

**Standard DSM Decision Log (Analytical):**
Focuses on feature selection, model choice, hyperparameters, cohort definition.

**Adapted Decision Log (Architectural):**
Focuses on design patterns, library choices, API design, trade-offs.

### 5.2. Architectural Decision Record Template

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

### 5.3. Decision Record Usage Example

```markdown
## DEC-001: Provider-Agnostic Service Factory

**Category:** Architecture

**Context:**
Need to support multiple service backends (cloud, on-premise, local) with consistent interface.

**Decision:**
Factory pattern with `AVAILABLE_PROVIDERS` registry and `create_service()` function.

**Alternatives Considered:**
1. Direct instantiation per provider - Rejected: code duplication, harder to switch
2. Dependency injection container - Rejected: over-engineering for project scope
3. Abstract base class with implementations - Rejected: more boilerplate than needed

**Rationale:**
Factory pattern provides simple, extensible design. Adding new providers requires only:
1. Add entry to AVAILABLE_PROVIDERS
2. Implement _create_[provider]() function

**Implications:**
- Enables runtime provider switching via config
- All providers must conform to a common interface
- Usage tracking possible via ProviderConfig dataclass
```

---

## 6. Success Criteria Adaptation for Software Projects

Software engineering projects evaluate success differently from analytical
projects. This section provides both the standard DSM criteria (for reference)
and the adapted criteria for application deliverables.

### 6.1. Standard DSM Success Criteria (Analytical)

- Statistical validity of findings
- Business interpretability
- Stakeholder acceptance
- Reproducible analysis

### 6.2. Adapted Success Criteria (Software Engineering)

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
- [ ] Working interactive demo (web UI/CLI)
- [ ] Sample data included
- [ ] Demo runs without external dependencies (or documents them)
