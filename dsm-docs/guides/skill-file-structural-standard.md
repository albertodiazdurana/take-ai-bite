# Skill File Structural Standard

**Version:** 1.0
**Created:** 2026-04-13
**Scope:** All DSM skill definitions, command files, and hook scripts
**Companion:** DSM_0.2 Module B §8 (Infrastructure File Collaboration Protocol)

This guide defines the structural rules for DSM infrastructure files: skill
definitions (SKILL.md), command files (legacy), and hook scripts. It parallels
the Document Structure Standard for methodology files and is grounded in
Claude Code platform research findings.

## Section Index

| § | Section | Description |
|---|---------|-------------|
| 1 | SKILL.md Format and Frontmatter | Canonical format for skill definitions |
| 2 | Command File Format (Legacy) | Format for scripts/commands/*.md files |
| 3 | Hook Script Conventions | Shell script standards for .claude/hooks/ |
| 4 | Line Budgets and Readability | Size constraints and formatting rules |
| 5 | Migration Path from Commands to Skills | When and how to migrate |

---

## 1. SKILL.md Format and Frontmatter

The canonical format for new skill definitions is `.claude/skills/<name>/SKILL.md`
with YAML frontmatter. This format supports metadata that bare command files
do not.

### 1.1. SKILL.md Template

```markdown
---
name: skill-name
description: One-line description shown in skill listings
user-invocable: true
allowed-tools: []
# Optional fields (include only when needed):
# argument-hint: "description of expected arguments"
# model: sonnet | opus | haiku
# effort: low | medium | high | max
# context: fork
# paths: ["src/**/*.rs"]
# hooks:
#   PreToolUse:
#     - matcher: "Edit"
#       hooks:
#         - type: command
#           command: ".claude/hooks/my-validator.sh"
---

[Skill prompt content here]

## Steps

1. First step
2. Second step

## Notes

- Additional context or constraints
```

### 1.2. Frontmatter Field Reference

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Skill identifier, used in `/skill-name` invocation |
| `description` | Yes | One-line description for skill listings |
| `user-invocable` | Yes | `true` if the user can invoke via `/name` |
| `allowed-tools` | No | Tools pre-approved while skill runs. **Requires explicit user approval per DSM_0.2.B §8.3** |
| `argument-hint` | No | Describes expected `$ARGUMENTS` for user guidance |
| `model` | No | Override model for this skill |
| `effort` | No | Override effort level |
| `context` | No | `fork` runs in isolated subagent context |
| `paths` | No | File globs that trigger automatic skill loading |
| `hooks` | No | Skill-scoped hooks (see DSM_0.2.B §8.5) |
| `shell` | No | Shell override for Bash commands |
| `disable-model-invocation` | No | Prevents model from auto-invoking |

### 1.3. Content Structure Conventions

After frontmatter, skill content follows this structure:

1. **Context paragraph** (1-3 sentences): What this skill does and when to use it
2. **Prerequisites** (if any): What must be true before running
3. **Steps** (numbered): The execution sequence
4. **Templates** (if any): File templates the skill creates
5. **Notes** (if any): Constraints, edge cases, anti-patterns

Each step should be self-contained: a reader should understand what the step
does without reading other steps. Cross-references between steps use
"Step N" format.

---

## 2. Command File Format (Legacy)

Files in `scripts/commands/*.md` and `.claude/commands/*.md` are the legacy
format. They work identically to SKILL.md content but lack frontmatter
support.

### 2.1. When to Use Command Files

- **Existing commands:** Keep in command format until migration (see §5)
- **New definitions:** Use SKILL.md format (§1) for all new work
- **DSM Central:** Central still uses commands/ because `sync-commands.sh`
  deploys to `~/.claude/commands/`, which is the current runtime path for
  all spoke projects. Migration to skills/ requires updating the deploy
  pipeline.

### 2.2. Command File Template

```markdown
[Skill prompt content, same structure as SKILL.md but without frontmatter]

## Steps

1. First step
2. Second step

## Notes

- Additional context or constraints
```

---

## 3. Hook Script Conventions

Hook scripts live in `.claude/hooks/` and are shell scripts executed by
Claude Code's hook subsystem.

### 3.1. Hook Script Template

```bash
#!/usr/bin/env bash
# Hook: [event type] - [brief description]
# Origin: [BL number or "core"]
# Installed by: /dsm-align step 10b

set -euo pipefail

# [Implementation]
```

### 3.2. Hook Script Rules

- **Shebang:** Always `#!/usr/bin/env bash`
- **Strict mode:** Always `set -euo pipefail`
- **Exit codes:** 0 = pass, non-zero = block the action
- **Output:** `BLOCKED:` prefix on stderr triggers visible error in IDE
- **Executable bit:** Must be `chmod +x`. /dsm-align step 10b enforces this
  on every run because Edit/Write tools strip the executable bit.
- **Idempotent:** Running the hook multiple times on the same input produces
  the same result
- **No side effects:** Hooks validate, they do not modify files

---

## 4. Line Budgets and Readability

### 4.1. Size Constraints

| File type | Target | Hard limit | Notes |
|-----------|--------|------------|-------|
| SKILL.md | ≤ 200 lines | 300 lines | First 5,000 tokens survive compaction |
| Command file | ≤ 200 lines | 300 lines | Same compaction budget applies |
| Hook script | ≤ 50 lines | 100 lines | Hooks should be focused and fast |

**Compaction note (per Claude Code platform assessment):** Claude Code's skill compaction budget
is 5,000 tokens per skill and 25,000 tokens combined across all loaded
skills. Skills exceeding ~200 lines risk truncation in extended sessions.
Keep core logic in the first 200 lines; move templates and reference material
to the end.

### 4.2. Readability Rules

- **Section headings:** Use `##` for top-level sections within the skill
- **Step numbering:** Sequential integers, no sub-numbering (use a/b/c
  for sub-steps within a step)
- **Code blocks:** Use fenced code blocks for templates and examples
- **Tables:** Use markdown tables for structured reference data
- **Bold for keywords:** Use bold for key terms on first use in each section

---

## 5. Migration Path from Commands to Skills

### 5.1. Current State

DSM Central uses `scripts/commands/*.md` as the source of truth, deployed
to `~/.claude/commands/` via `sync-commands.sh`. This pipeline works but
does not support SKILL.md frontmatter.

### 5.2. Migration Criteria

Migrate a command to SKILL.md format when:
- The command needs frontmatter features (allowed-tools, paths, scoped hooks)
- The command is being significantly rewritten
- The deploy pipeline supports skills/ as a target

### 5.3. Migration Steps (per command)

1. Create `.claude/skills/{name}/SKILL.md` with frontmatter
2. Copy command content into the SKILL.md body
3. Add appropriate frontmatter fields
4. Test the skill invocation
5. Update `sync-commands.sh` to deploy skills (one-time pipeline change)
6. Remove the old command file after confirming the skill works

### 5.4. Pipeline Migration (one-time)

The deploy pipeline (`sync-commands.sh`) currently targets commands/.
A future BL should update it to:
1. Deploy SKILL.md files to `.claude/skills/` in spoke projects
2. Maintain backwards compatibility with commands/ during transition
3. Update /dsm-align step 10b to install skill-format hooks

This pipeline change is outside the Skill File Structural Standard scope.
Track as a separate item when the first skill migration is needed.
