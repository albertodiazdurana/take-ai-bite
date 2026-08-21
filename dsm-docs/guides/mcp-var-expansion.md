# MCP `${VAR}` expansion in `.mcp.json`

**Applies when:** all three hold.

1. You are configuring a Claude Code MCP server whose credential is written as a
   `${VAR}` reference inside `.mcp.json` (for example `N8N_API_KEY=${N8N_API_KEY}`).
2. The value of that variable comes from a gitignored `.env` file rather than from
   your shell profile.
3. The server is rejecting requests (401 or similar), **or** a health check reports
   the server as connected while real calls fail.

If any of the three does not hold, stop reading. This guide describes one specific
interaction and will not help with other MCP problems.

---

## What happens

A `${VAR}` reference in `.mcp.json` is expanded **once, at Claude Code startup, from
the environment of the shell that launched `claude`**. Claude Code does not auto-load
a project `.env`, and it does not re-read the value later.

If the variable is unset at launch, the **literal string `${VAR}`** is forwarded to
the MCP server. The server then rejects it as an invalid credential.

## Why a health check does not catch it

A "connected" status is not evidence the credential is valid. Many health checks only
ping an unauthenticated endpoint, so they succeed with a literal `${VAR}` in place of
a key. This is the property that makes the failure expensive: the configuration reports
healthy and the calls fail, and those look like two unrelated problems.

## Launch deterministically

When the value comes from a gitignored `.env` bridged by direnv, do not rely on the
interactive shell hook having run:

```
direnv exec <project-dir> claude
```

Or verify before launching, without printing the secret:

```
printf '%s' "$VAR" | wc -c
```

A large number, not `0`.

## Diagnose at the process, not at the config

Reading `.mcp.json` again tells you nothing, because the file is correct , the
expansion is what failed. Inspect the environment of the running MCP server process:

```
tr '\0' '\n' </proc/<mcp-pid>/environ | grep ^VAR=
```

Two readings, neither of which is a wrong-key problem:

| What you see | What it means |
|---|---|
| A value whose length equals the literal `${VAR}` string's length | The variable was never expanded |
| Length `0` | The variable was expanded and was empty |

## Origin

A spoke project lost two Claude Code restart cycles to this. Registered as the first
trigger-gated entry in `dsm-docs/guides/README.md` under BL-522.
