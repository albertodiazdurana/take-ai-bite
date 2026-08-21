# Guides

Companion documents referenced from the methodology files. Guides hold material
that is too operational for a methodology section and too durable for a research
file. Mirrored to public mirrors as manifest category 2, so the `@` chain resolves
locally in every spoke.

## Two kinds of guide

**Unconditional** guides describe something every DSM project touches. Read them
when the subject comes up.

**Trigger-gated** guides describe a situation that is a landmine under one specific
setup and noise everywhere else. They open with an `**Applies when:**` block listing
conditions that must **all** hold, followed by an explicit instruction to stop reading
if they do not. The index carries the same conditions in abbreviated form, so a reader
can self-select from this page without opening the file.

The gate exists because the alternative shapes both fail. A lesson written as a
general rule gets applied where it does not belong; a lesson left unregistered gets
rediscovered the expensive way.

### The `**Applies when:**` block

```markdown
**Applies when:** all three hold.

1. [condition]
2. [condition]
3. [condition]

If any of the three does not hold, stop reading. This guide describes one specific
interaction and will not help with other [subject] problems.
```

Each condition must be **independently checkable without reading the body**. A
condition that requires the guide's own content to evaluate defeats the gating, since
the reader has already paid the cost the gate exists to avoid.

## Unconditional guides

| Guide | Subject |
|-------|---------|
| [communication-channels.md](communication-channels.md) | Which channel carries which kind of message across the ecosystem |
| [document-structure-metrics.md](document-structure-metrics.md) | Measured line and section budgets for methodology documents |
| [document-structure-standard.md](document-structure-standard.md) | Modularization triggers, line budgets, file indexes, intro paragraphs |
| [dsm-vocabulary.md](dsm-vocabulary.md) | Canonical terms and the distinctions they carry |
| [mirror-sync-manifest.md](mirror-sync-manifest.md) | Which file categories mirrors receive, and their mapping form |
| [readme-sections-guide.md](readme-sections-guide.md) | Section inventory and ordering for a project README |
| [skill-file-structural-standard.md](skill-file-structural-standard.md) | Required structure for a `scripts/commands/*.md` skill file |

## Trigger-gated guides

| Guide | Applies when all of these hold |
|-------|-------------------------------|
| [mcp-var-expansion.md](mcp-var-expansion.md) | (1) a Claude Code MCP server's credential is a `${VAR}` reference in `.mcp.json`; (2) the value comes from a gitignored `.env` rather than the shell profile; (3) the server rejects requests, or reports connected while calls fail |

## Adding a guide

Add the file, then add its row here. A gated guide needs its `**Applies when:**`
block in the file **and** its conditions abbreviated in the table above; the table
carries the trigger and the subject, never the lesson itself, so the content lives
in exactly one place (Present Once, Then Deepen, DSM_0.2 §8.10).

There is no `/dsm-guide-add` command. Whether guides should get the paired
add/done commands `dsm-docs/research/` has is a later question; manual maintenance
is the current convention, and drift between this index and the folder is a
protocol-violation signal under DSM_0.2 §22.
