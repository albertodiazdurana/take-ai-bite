# README Required Sections Guide by Project Type

**Version:** 1.0
**Created:** 2026-03-30
**Origin:** BACKLOG-279
**Scope:** All DSM project types (DSM_0.2 §1)

This guide defines which sections a DSM project's root README should contain.
It provides structure without forcing uniformity: required sections ensure
consistency across the ecosystem, recommended sections address needs that
vary by project type.

The guide covers the project root README only. Directory-level READMEs
(backlog indexes, inbox templates, dsm-docs structure) are managed by
`/dsm-align` and are not in scope here.

## Contents

| § | Section |
|---|---------|
| 1 | Universal Required Sections |
| 2 | Data Science Projects (DSM 1.0) |
| 3 | Application Projects (DSM 4.0) |
| 4 | Hybrid Projects (DSM 1.0 + 4.0) |
| 5 | Documentation Projects (DSM 5.0) |
| 6 | External Contribution Projects |
| 7 | Common README Anti-Patterns |

---

## 1. Universal Required Sections

Every DSM project README must include these sections regardless of project type.

| Section | Rationale |
|---------|-----------|
| **Title + one-line description** | The reader knows what this project is within 5 seconds |
| **Purpose / What this project does** | Explains the problem being solved or the value delivered |
| **Getting Started** | A new reader can set up and run the project without asking questions |
| **Author** | Attribution and contact point for the maintainer |
| **License** | Legal clarity for anyone who encounters the repository |

**Title convention:** Use a human-readable project name as the H1 heading,
not the repository slug. A one-line description (tagline or subtitle)
follows immediately after the title.

**Getting Started minimum:** At least the prerequisites and the first
command to run. For projects with no executable code (documentation
projects), this section covers how to navigate the repository.

---

## 2. Data Science Projects (DSM 1.0)

Projects with `notebooks/` and no `src/`. The README introduces the analysis
and guides the reader to the notebooks.

| Section | Required | Rationale |
|---------|----------|-----------|
| Universal sections (§1) | Yes | Baseline for all projects |
| **Data** | Yes | What data is used, where it comes from, how to obtain it |
| **Project Structure** | Yes | Maps the reader to notebooks, data folders, outputs |
| **Key Findings / Results** | Recommended | Surfaces conclusions without requiring notebook execution |
| **Methodology** | Recommended | Brief description of analytical approach (links to notebooks for detail) |
| **Environment Setup** | Recommended | Python version, key packages, environment file reference |

**Data section note:** If data cannot be shared (licensing, privacy), state
this explicitly and describe the expected schema so the reader understands
what the notebooks operate on.

---

## 3. Application Projects (DSM 4.0)

Projects with `src/`, `tests/`, and typically an entry point (`app.py`,
`main.py`, CLI).

| Section | Required | Rationale |
|---------|----------|-----------|
| Universal sections (§1) | Yes | Baseline for all projects |
| **Tech Stack** | Yes | Languages, frameworks, key dependencies at a glance |
| **Project Structure** | Yes | Maps source, tests, config, and entry points |
| **Usage** | Yes | How to run the application after setup |
| **Testing** | Recommended | How to run the test suite, expected coverage |
| **Architecture** | Recommended | High-level design for contributors or future maintainers |
| **Deployment** | Recommended | Production setup if the project is deployable |

---

## 4. Hybrid Projects (DSM 1.0 + DSM 4.0)

Projects with both `notebooks/` and `src/`. The README must clarify which
parts are exploratory analysis and which are application code.

| Section | Required | Rationale |
|---------|----------|-----------|
| Universal sections (§1) | Yes | Baseline for all projects |
| **Tech Stack** | Yes | Covers both notebook and application dependencies |
| **Project Structure** | Yes | Critical: reader must understand the notebook/src boundary |
| **Usage** | Yes | How to run the application components |
| **Data** | Recommended | If notebooks perform analysis on external data |
| **Key Findings / Results** | Recommended | For the analysis side of the project |
| **Testing** | Recommended | For the application side of the project |

**Structure clarity:** The project structure section is especially important
for hybrid projects. Clearly separate notebook-based exploration from
application code, and explain how they relate (e.g., "notebooks explore
the data, src/ implements the pipeline discovered in exploration").

---

## 5. Documentation Projects (DSM 5.0)

Markdown-only projects with `dsm-docs/` and no `notebooks/` or `src/`.
The README orients the reader to the document set.

| Section | Required | Rationale |
|---------|----------|-----------|
| Universal sections (§1) | Yes | Baseline for all projects |
| **Document Overview** | Yes | What documents exist and what each covers |
| **How to Navigate** | Yes | Replaces "Getting Started" for non-executable projects |
| **Principles / Core Ideas** | Recommended | The conceptual foundation, if the project has one |
| **Contributing** | Recommended | How others can propose changes or provide feedback |
| **Changelog / Version History** | Recommended | If the documentation is versioned |

**Getting Started adaptation:** For documentation projects, "Getting Started"
becomes "How to Navigate": where to start reading, what order to follow,
which document is the entry point.

---

## 6. External Contribution Projects

Projects where the repository belongs to an upstream maintainer. The README
is not under DSM governance; it follows the upstream project's conventions.

| Section | Required | Rationale |
|---------|----------|-----------|
| **Upstream README conventions** | Yes | The README belongs to the upstream project, not DSM |

**DSM governance note:** External contribution projects do not modify the
upstream README to match DSM conventions. If the contribution includes
README changes (e.g., documenting a new feature), follow the upstream
project's existing README style.

The contributor's governance artifacts (contribution plan, feedback files,
decision records) live in `{contributions-docs-path}/{project}/`, not in the
upstream repository.

---

## 7. Common README Anti-Patterns

| Anti-pattern | Why it fails | Better approach |
|--------------|-------------|-----------------|
| No "Getting Started" section | New readers cannot use the project without asking the author | Always include setup steps, even if minimal |
| Giant wall of text with no structure | Readers scan, they do not read top-to-bottom | Use headings, tables, and short paragraphs |
| Listing every file in project structure | Becomes stale as the project evolves | Show the top-level structure with brief descriptions |
| Badge overload | Badges add noise if the project has no CI, no published package, no coverage | Only include badges that convey meaningful, current status |
| "TODO" placeholders left in published README | Signals an unfinished project | Remove or fill placeholders before publishing |
| Duplicating documentation in the README | Creates maintenance burden, content drifts | Link to the canonical source instead of copying |