# DSM Document Structure Standard

**Version:** 1.0
**Created:** 2026-03-24
**Origin:** BACKLOG-259
**Scope:** All DSM methodology documents (DSM_0 through DSM_6, modules, guides)

This guide defines the structural rules for DSM documents: when and how to
modularize, how to format headings and sections, and how to make documents
navigable. It extends DSM_0.2 §14 (Heading Parsability Convention) with
document-level structure standards.

## Document Structure Index and Sections

| § | Section | Description |
|---|---------|-------------|
| 1 | Modularization Triggers and Line Budgets | When to split a document and size constraints per file |
| 2 | File Structure Index Requirement | Navigable overview at the beginning of every document |
| 3 | Heading Structure and Formatting Standards | Heading levels, token counts, and intro paragraph rule |
| 4 | Naming Convention for Modular Files | File naming patterns for core and module documents |
| 5 | Evidence from Existing DSM Modularizations | Line counts and lessons from DSM_0.2 and DSM_1.0 |
| 6 | Retrofit Guidance for Existing DSM Files | How to bring existing documents into compliance |

---

## 1. Modularization Triggers and Line Budgets

This section defines when a DSM document should be split into a core file
plus modules, and the size constraints that apply to each component.

### 1.1. Modularization Trigger Threshold for Documents

A DSM document must be structured as core + modules when it exceeds or is
expected to exceed **400 lines**. This threshold applies both to new documents
(plan the split from the start) and to existing documents that grow beyond
the limit through incremental additions.

Documents under 400 lines may remain as single files unless the content has
clear thematic divisions that benefit from on-demand loading.

### 1.2. Line Budget Constraints per Component

| Component | Maximum lines | Rationale |
|-----------|--------------|-----------|
| Core file | 400 | Fits in a single focused context read without triggering Context Budget Protocol |
| Module file | 400 | Same constraint; keeps each unit independently manageable |
| Total budget | Defined at BL creation | Sum of core + planned modules; declared upfront in the BL |

The total budget is a planning tool, not a hard limit. It ensures the scope
of a new document is estimated before writing begins, preventing unbounded
growth that forces reactive modularization later.

### 1.3. Core File Content Criteria

The core file contains content that is always needed when working with the
document. For DSM_0.2, this means protocols that run every session. For a
chapter like DSM_6.1, this means framing, definitions, and the dispatch table.

Content that is needed only in specific situations belongs in modules, loaded
on demand via the dispatch table.

---

## 2. File Structure Index Requirement

Every DSM document (core or module) must begin with a structure index after
the title and metadata. The index provides a navigable overview of the file's
contents before the reader encounters any section content.

### 2.1. Index Format for Core Files

Core files use a table mapping section numbers to titles and descriptions:

```markdown
## Document Structure Index

| § | Section | Description |
|---|---------|-------------|
| 1 | Section Title Here | One-line summary of what this section covers |
| 2 | Another Section Title | One-line summary |
```

When the core file has a dispatch table to modules, the dispatch table
appears as a section in the index and includes module references.

### 2.2. Index Format for Module Files

Module files use the same table format. The index covers only the sections
within that module, not the entire document suite.

### 2.3. Index Placement Convention in Documents

The index is the first substantive section after the document title, version
metadata, and introductory paragraph. It appears before the `---` separator
that begins the first content section.

### 2.4. Structure Index Maintenance Rule

When adding, removing, or renaming a top-level section heading (## level) in
a DSM document, update the file's structure index in the same commit.

**Behavioral trigger:** After any Edit or Write that creates, deletes, or
renames a `##`-level heading in a numbered DSM file (DSM_0 through DSM_6,
including modules), the agent updates the TOC/Contents section of that file
before committing. This is a mechanical edit, not a new artifact, so it does
not require a separate Gate 1 brief.

**Subsections (### level) are excluded:** TOC entries track top-level sections
only. Adding a subsection within an existing section does not trigger this rule.

---

## 3. Heading Structure and Formatting Standards

This section defines rules for heading levels, token counts, and the
relationship between headings and their content. It extends DSM_0.2 §14
(Heading Parsability Convention) with structural formatting requirements.

### 3.1. Heading Level Usage and Depth

Use three levels of headings for document structure:

| Level | Usage | Example |
|-------|-------|---------|
| `#` | Document title (one per file) | `# DSM Document Structure Standard` |
| `##` | Major sections | `## Modularization Triggers and Line Budgets` |
| `###` | Subsections within a major section | `### Core File Content Criteria` |

Use `####` sparingly and only when a subsection genuinely requires further
subdivision. If `####` headings proliferate, consider whether the parent
section should be its own module.

### 3.2. Minimum Token Count Reference

All headings must have at least 4 non-stopword tokens per DSM_0.2 §14.1.
This rule applies to all heading levels including `###` and `####`.

### 3.3. Mandatory Intro Paragraph Rule per Heading

Every heading at every level must be followed by at least one short paragraph
describing what the section contains before any subheadings appear. This
paragraph provides context, explains the section's purpose, and helps both
human readers and automated tools understand the document's information
architecture.

**Pattern (correct):**

```markdown
## Heading Structure Standards

This section defines rules for heading levels, token counts, and the
relationship between headings and their content.

### Heading Level Usage

Use three levels of headings for document structure:
```

**Anti-pattern (incorrect):**

```markdown
## Heading Structure Standards
### Heading Level Usage

Use three levels of headings for document structure:
```

**Why this matters:** Bare heading sequences (`#` → `##` without text between)
force readers to infer what a section contains from the subheading titles
alone. The intro paragraph provides a map of the section before the reader
enters it. For agents reading documents via the Two-Pass Reading Strategy
(DSM_0.2 §12), intro paragraphs improve the quality of structural scans
by providing semantic anchors alongside heading markers.

### 3.4. Section Separator Convention Between Sections

Use `---` (horizontal rule) between major `##` sections to visually separate
content blocks. Do not use separators between `###` subsections within a
major section.

---

## 4. Naming Convention for Modular Files

This section defines the file naming patterns for documents that have been
modularized into a core file plus modules.

### 4.1. Core and Module File Names

| Component | Pattern | Example |
|-----------|---------|---------|
| Core | `DSM_X.Y_Title_vN.M.md` | `DSM_6.1_Systems_Prompt_Engineering_v1.0.md` |
| Module A | `DSM_X.Y.A_Module_Title.md` | `DSM_6.1.A_Operational_Channels.md` |
| Module B | `DSM_X.Y.B_Module_Title.md` | `DSM_6.1.B_Instruction_Design.md` |

Module letters are assigned sequentially (A, B, C, D). Each module file name
includes a descriptive suffix that communicates the module's scope without
requiring the reader to open the file.

### 4.2. Dispatch Table as Discovery Mechanism

The core file must include a dispatch table that maps protocols or sections
to their module files. This table serves the same function as DSM_0.2 §24
(Module Dispatch Table): it tells agents and readers where to find content
that is not in the core file.

The dispatch table should appear in the Document Structure Index and as a
dedicated section near the end of the core file.

---

## 5. Evidence from Existing DSM Modularizations

This section documents the line counts and structural patterns from DSM
documents that have already been modularized, providing empirical support
for the thresholds defined in Section 1.

### 5.1. DSM_0.2 Modularization Data (Session 109)

| File | Lines | Assessment |
|------|------:|------------|
| Core (DSM_0.2) | 1,083 | Over threshold; contains §1-24 always-loaded protocols |
| Module A (Session Lifecycle) | 1,254 | Over threshold; candidate for further split |
| Module B (Artifact Creation) | 361 | Within budget |
| Module C (Security Safety) | 242 | Within budget |
| Module D (Research Onboarding) | 437 | Slightly over; acceptable |

**Lesson:** The core file at 1,083 lines predates this standard. Module A at
1,254 lines demonstrates the cost of not having a budget: it accumulated
protocols across multiple sessions without a split trigger.

### 5.2. DSM_1.0 Modularization Data (Session 146, BL-257)

| File | Lines | Assessment |
|------|------:|------------|
| Core (slim) | 348 | Within budget; good example of a focused core |
| Modules A-D | 242-437 | Within budget |

**Lesson:** DSM_1.0's modularization followed the DSM_0.2 pattern and
produced well-sized modules. The slim core at 348 lines is the target
model for new documents.

### 5.3. Unmodularized DSM Files for Reference

| File | Lines | Status |
|------|------:|--------|
| DSM_6.0 | 589 | Over threshold; single-file, could benefit from modularization |
| DSM_0.0 | 1,030 | Over threshold; single-file reference guide |
| DSM_2.0 | 1,493 | Over threshold; candidate for modularization |

---

## 6. Retrofit Guidance for Existing DSM Files

This section provides guidance for bringing existing DSM documents into
compliance with this standard. Retrofit is a gradual process, not a
single-session effort.

### 6.1. Retrofit Priority Order for Documents

1. **New documents:** Apply this standard from creation (mandatory)
2. **Documents being edited:** Add index and intro paragraphs during the edit
   session (opportunistic)
3. **Documents over threshold:** Plan modularization as a dedicated BL when
   the document is next modified substantially

### 6.2. Retrofit Scope Limits per Session

When retrofitting an existing document, limit changes to structural additions
(index, intro paragraphs) and do not combine with content changes. This keeps
the diff reviewable and avoids conflating structural and semantic edits.

### 6.3. Compliance Tracking and Metrics Integration

The `dsm-docs/guides/document-structure-metrics.md` file tracks line counts
and heading distributions. Future updates to this file should include a
compliance column indicating whether each document follows this standard.
