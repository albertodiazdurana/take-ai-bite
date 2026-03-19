# DSM_0.2 Module B: Artifact Creation

**Parent:** DSM_0.2_Custom_Instructions_v1.1.md
**Loaded:** On demand, when the agent needs a protocol from this module
**Reference:** Module Dispatch Table in DSM_0.2 core

This module contains artifact creation protocols: composition reasoning,
edit granularity, enabling file constraints, notebook collaboration,
app development workflow, and revert safeguards. The agent reads this file
via the Read tool when a protocol listed in the dispatch table is needed.

---

## 1. Composition Challenge Protocol

When the agent produces a multi-item artifact (a test suite, a set of backlog
items, a batch of configuration entries, a multi-section document), it must
present a composition justification before generating any item. This is a Gate 0
that precedes the Pre-Generation Brief's Gate 1.

**Trigger:** Any time the agent composes a collection of two or more discrete
items. A single artifact is already covered by the Pre-Generation Brief; the
moment there are two or more, there is a composition decision that needs
justification: why these N items, not more or fewer?

**Composition justification format:**

| Dimension | Question the agent answers |
|-----------|---------------------------|
| **Why** | What requirement or goal does this collection serve? |
| **What** | Index of all items (one line each, high-level) |
| **Why not more/less** | Trace each item to a requirement; list candidates that were considered and excluded, with the reason for exclusion |
| **How** | Key decisions, structure, execution approach |
| **When** | Is this the right next step in the sequence? |

**Stop:** After presenting the composition justification, the agent stops and
waits for the human's response. The human may approve, adjust the composition
(add, remove, reorder items), or reject entirely.

**After approval:** Each individual item in the collection still goes through
the Pre-Generation Brief's Gate 1/Gate 2 cycle. Composition approval authorizes
the collection; it does not authorize the implementation of each item.

**Relationship to Pre-Generation Brief:** The Pre-Generation Brief covers
artifact-level context (What/Why/Key Decisions/Structure for a single artifact).
The Composition Challenge covers collection-level reasoning (why these N items,
not more or fewer). Both are required when the artifact is a collection.

**Implements:** DSM_6.0 Principle 1.4.2 (Challenge Myself to Reason).

**Anti-Patterns:**

**DO NOT:**
- Skip composition justification for "obvious" collections; the reasoning may
  be obvious to the agent but not to the human
- Present the justification as a formality after the items are already designed;
  the human must be able to redirect the composition before detailed work begins
- Combine composition justification with Gate 1 of the first item; they are
  separate stops

---

## 2. Edit Explanation Stop Protocol

When an implementation involves multiple distinct edits within a single file, the
agent must explain and execute each edit individually, stopping for human review
between edits.

**Trigger:** Two or more logically distinct edits to the same file in a single
implementation step. A "logically distinct edit" is one that addresses a different
concern, modifies a different code path, or makes a different design decision.

**Per-edit cycle:**

1. **Explain:** Agent describes the edit: what will change, where in the file,
   and why this change is needed
2. **Stop:** Agent waits for the human's response
3. **Approve:** Human reads the explanation, asks questions if needed, approves
4. **Execute:** Agent performs the edit; the human reviews the diff in the
   permission window

**Grouping rule:** Trivial edits may be grouped into a single cycle when they
share the same logical purpose and require no independent judgment:
- A typo fix alongside a related import addition
- Multiple instances of the same mechanical rename
- Formatting changes that accompany a substantive edit

Distinct edits, those involving different design decisions, different code paths,
or different logical concerns, always get separate cycles.

**Relationship to Pre-Generation Brief:** The Pre-Generation Brief authorizes the
artifact (Gate 1: concept, Gate 2: implementation). The Edit Explanation Stop
operates within Gate 2, ensuring that the human can review each logical change
before it is applied. Gate 2 approval for an edit does not grant approval for the
next edit.

**Implements:** DSM_6.0 Principle 1.4.2 (Challenge Myself to Reason).

**Anti-Patterns:**

**DO NOT:**
- Explain all edits at once and then execute them as a batch; the human cannot
  redirect between edits if they are presented as a monolith
- Classify substantive changes as "trivial" to group them; when in doubt, give
  the edit its own cycle
- Skip the explanation for "small" edits that involve design decisions; the size
  of the diff does not determine whether the human needs to understand the choice

---

## 3. Enabling File Content Protocol

Enabling files are scope-definition and tracking artifacts. They define *what*
should be built and track *whether* it was built. They are never the target of
implementation. Implementation content belongs in the DSM body (DSM_0 through
DSM_6, DSM_0.1, DSM_0.2) or in project deliverables.

**Enabling file types:**

| Artifact | Role | Lives in |
|----------|------|----------|
| Backlog item | Defines scope, success criteria, priority | `plan/backlog/` |
| Checkpoint | Snapshots milestone state, next steps | `dsm-docs/checkpoints/` |
| Decision record | Records a decision and its rationale | `dsm-docs/decisions/` |
| Plan | Structures phases, deliverables, timelines | `dsm-docs/plans/` |
| Epoch/sprint log | Tracks sprint progress and boundaries | `dsm-docs/plans/` or project-specific |
| Handoff | Enables session continuity | `dsm-docs/handoffs/` |
| Blog artifact | Drafts, seeds, publication materials | `dsm-docs/blog/` |

**Detection rule:** When the agent encounters any of these patterns in an
enabling file, it must flag the issue and surface it to the user before
proceeding:

- "Document X in this file"
- "The implementation is described above" (self-referential implementation)
- Substantive templates, protocols, or reusable patterns defined only within
  the enabling file, with no corresponding section in the DSM body

**Agent action when flagged:**

1. Stop and alert: "This enabling file contains implementation content that
   should live in the DSM body (or project deliverables). Enabling files
   define scope; they do not hold the implementation."
2. Propose the correct target: which DSM document or project artifact should
   hold the content
3. Wait for user confirmation before proceeding

**Why this matters:** When implementation lives inside a backlog item, it
becomes invisible to the methodology. The backlog item moves to `done/` and
the pattern is effectively archived rather than promoted. Future sessions
cannot discover the pattern through the DSM body; they would need to search
completed backlog items, which are not part of the active methodology surface.

**Anti-Patterns:**

**DO NOT:**
- Write reusable templates, protocols, or patterns inside backlog items; the
  BL item defines what to build, the DSM body holds the result
- Mark a backlog item as "Implemented" when the output is the backlog file
  itself; implementation means the content exists in its target location
- Skip the flag for "small" patterns; even a short template inside a BL item
  will be lost once the item moves to done/

---

## 4. Notebook Collaboration Protocol (DSM 1.0 Projects)

When working on Jupyter notebook cells:

1. **Agent generates one cell** -- via NotebookEdit tool or as code block in conversation
2. **User runs the cell** -- executes in notebook, observes output
3. **User shares output back** -- copies cell output into conversation
4. **Agent reads and validates output** -- checks for expected results, data shapes, errors
5. **Agent generates next cell** -- only after validating previous output

**Cell delivery method:**
- Present cells as markdown code blocks in conversation (with copy button), not via
  NotebookEdit. This lets the user paste cells into the notebook manually, maintaining
  control over cell placement. NotebookEdit insert can misplace cells and bypasses
  the user's review of where the cell goes.
- Exception: NotebookEdit is acceptable when the user explicitly requests it or when
  editing an existing cell in place.

**Cell generation rules:**
- Generate ONE cell at a time (unless first cell is markdown-only, then up to TWO)
- Number cells with comments (`# Cell 1`, `# Cell 2`) for reference
- Use `print()` for DataFrame output (e.g., `print(df.head(3))` instead of bare
  `df.head(3)`). Bare expressions produce rich HTML in Jupyter that is not
  copy/paste friendly when the user needs to share output back in conversation.
- Wait for execution output before generating next cell
- "Continue" or "yes" = generate next cell
- "Generate all cells" = explicit batch override (user must request)
- **Every cell must produce output** that validates its correctness. A cell that
  runs without error but produces no output cannot be validated until a later cell
  reveals a problem. Include at least one `print()` statement per cell:
  - Imports: print library versions (`print(f"pandas {pd.__version__}")`)
  - Data loading: print shape and dtypes (`print(df.shape)`, `print(df.dtypes)`)
  - Feature engineering: print resulting shapes (`print(X.shape, y.shape)`)
  - Model fitting: print score or summary metric
  - Configuration/setup: print the configured values

**Why one cell at a time:** Each cell's output informs the next cell's design. Batch
generation skips this validation loop and prevents iterative adaptation based on actual
data shapes, distributions, and errors.

**Anti-Patterns:**

**DO NOT:**
- Generate multiple cells at once without waiting for output between each
- Skip output validation before generating the next cell
- Assume cell output matches expectations without checking actual values
- Generate "all remaining cells" unless the user explicitly requests batch override with "Generate all cells"
- Generate cells without output validation; silent cells defer error detection and break the incremental feedback loop

---

## 5. Notebook-to-Script Transition

When working in notebooks, extract code to standalone scripts when:
- The next step involves long-running computation (>2 minutes)
- Batch processing or generating results that must persist independently
- Code exceeds ~100 lines of non-exploratory logic
- Namespace issues arise from notebook variable scope

The notebook should import from or call the script, not replicate the
computation inline. Place scripts in `src/` (DSM 4.0) or project root.

Reference: PM Guidelines Template 8 (Execution Mode)

---

## 6. App Development Protocol (DSM 4.0 Projects)

When building application code (packages, modules, scripts), follow the File Creation
Loop below. This replaces vague "wait for confirmation" language with a mechanical,
predictable rhythm.

### 6.1. File Creation Loop

For each file to be created or modified:

1. **Show todo list:** Display the full task list with the current file marked as in_progress
2. **Show description, stop:** Explain what the file does, why it's needed, and key design decisions. Then stop and wait. *(Gate 1)*
3. **Ask to proceed, stop:** Ask "Proceed? (Y/N)" as plain text. Wait for the user's short answer. Do not use AskUserQuestion.
4. **If yes, create file, stop:** Use Write/Edit tool. The user reviews via the diff approval window. Wait for approval. *(Gate 2)*
5. **If file needs execution, apply Gate 3:** Explain what will be run (command, target, expected behavior). Wait for explicit "y" before executing. See Pre-Generation Brief Protocol for full gate definitions.
6. **Show updated todo list:** Mark the completed file, show the next file as in_progress.
7. **Repeat from step 2** for the next file.

**Build order:** imports, constants, one function, test, next function.
**TDD:** Write tests in `tests/` alongside code.

### 6.2. Write Call Size Rule

When an initial Write call would produce more than ~150 lines, do not generate the
entire file at once. Instead, build incrementally:

1. Create the file with imports, constants, and a skeleton (class/function signatures)
2. Add one function or class body at a time via Edit calls
3. Each increment goes through Gate 2 (diff review in the permission window)

The ~150-line threshold is a reviewability heuristic, not a hard cap. The principle:
the human must be able to engage with the diff and respond with substance. A 365-line
diff in one approval window degrades oversight to passive approval.

This operationalizes the Build order guidance above as a constraint on Write call
size. The File Creation Loop controls file-level granularity (one file at a time);
this rule controls within-file granularity (one logical unit at a time).

### 6.3. Anti-Patterns

**DO NOT:**
- Batch-generate multiple files without stopping between each, user cannot review
- Use AskUserQuestion for approval flows, the modal darkens background content and blocks readability
- Skip the todo list update between files, user loses progress context
- Proceed after diff approval without showing the updated todo list, breaks the rhythm
- Combine description + file creation in one step, user must review the explanation before the file is created
- Generate a 300+ line file in a single Write call; build incrementally per the Write Call Size Rule

### 6.4. User Shortcuts

- "Y" or "yes" = proceed to create the file
- "N" or "no" = stop, discuss, adjust
- "Done" or "next" = skip description, proceed to file creation
- "Explain more" = deeper explanation before proceeding

---

## 7. Revert Safeguards Protocol

DSM changes often span multiple file categories with different reversibility
characteristics. Git-tracked files have `git revert`; untracked files (user-level
commands, gitignored artifacts, cross-repo entries) do not. This protocol ensures
every change has a documented undo path before implementation begins.

**Applies to:** All backlog implementations that touch untracked files, experimental
changes with a defined trial period.

**Does NOT apply to:** Changes that only touch git-tracked files (git provides the
safety net), session-scoped artifacts (transcript, baseline) that are ephemeral by
design, routine mechanical edits (version bumps, date updates).

### 7.1. Pre-Implementation Snapshot

Before modifying any untracked file, create a snapshot:

- **User-level commands (`~/.claude/commands/`):** Copy originals to
  `plan/archive/{BL-NNN}_pre-edit-snapshots.md` (version-controlled, recoverable)
- **Gitignored local files (`.claude/`):** Document the file's existence and purpose
  in the snapshot; content is recreatable from the backlog item
- **Cross-repo artifacts:** Note which repos and files will be touched

The snapshot file uses this format:

```markdown
# Pre-Edit Snapshots for BACKLOG-NNN

**Date:** YYYY-MM-DD
**Session:** N

## {filename}

**Path:** {full path}
**Tracking status:** user-level untracked | gitignored | cross-repo

\`\`\`markdown
{original file content}
\`\`\`
```

### 7.2. Backlog Item Revert Section

Every backlog item that modifies untracked files MUST include a **Revert Procedure**
section with:

- Numbered steps to undo each change, grouped by file category
- File paths for pre-edit snapshots
- Verification checklist to confirm clean revert
- Order of operations (e.g., restore commands before reverting git changes)

The `/dsm-backlog` command prompts for this section when untracked files are
identified in the scope.

### 7.3. Feature Branch for Experimental Changes

When a change is explicitly experimental (trial period, evaluation planned):

- Implement tracked changes on a feature branch
- Merge to main only if the experiment succeeds
- If dropped, delete the branch (clean history)
- Untracked file changes still need snapshots (branches do not help there)

**Anti-Patterns:**

**DO NOT:**
- Modify untracked files without creating a snapshot first; reconstruction from
  memory or context is fragile and may be impossible after session end
- Omit the Revert Procedure from backlog items that touch untracked files; the
  procedure is the safety net that replaces git's role for these artifacts
- Assume cross-repo changes are self-reverting; inbox entries and feedback pushes
  persist until explicitly processed or removed
