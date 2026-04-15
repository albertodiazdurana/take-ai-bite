#!/usr/bin/env bash
# .claude/hooks/transcript-reminder.sh
#
# UserPromptSubmit hook: emit a session-type-aware transcript reminder.
#
# Detects whether the current Claude Code instance is a parallel session
# (started via /dsm-parallel-session-go) or the main session, by walking
# the parent process chain to find the `claude` process PID and comparing
# it against any CLAUDE_PID recorded in .claude/parallel-sessions.txt.
#
# Multi-entry registry (BL-371): the file may contain multiple parallel
# session sections, each with its own CLAUDE_PID. A prompt is from a
# parallel session if MY_CLAUDE_PID matches ANY PID in the registry,
# regardless of that section's State (active or wrapped — a wrapped
# session should stop emitting the parallel reminder by killing the
# Claude process; if the process is still alive, the reminder still
# applies).
#
# Fail-safe: any error, missing registry, stale PIDs, or no match emits
# the main reminder. The script always exits 0; it must never block a
# prompt submission.
#
# Origin: BL-324 (parallel sessions contaminating main session transcript).
# BL-371: registry renamed singular→plural, detection updated for
# multi-entry.

set +e

MAIN_REMINDER="REMINDER (DSM_0.2 §7): This turn MUST include an append to .claude/session-transcript.md before any work, and an output summary after. Required sequence: (1) read the last 3 lines of the transcript to find the anchor (Bash tail or Read is allowed, this is the only pre-append tool call), (2) append a <------------Start Thinking / HH:MM------------> block via Edit using that anchor, (3) do the work, (4) append a <------------Start Output / HH:MM------------> summary before the final response. Skip entirely only if the turn needs no tool calls at all."

PARALLEL_REMINDER="REMINDER (DSM_0.2 §7, parallel mode): This is a parallel session. Do NOT read, write, edit, or append to .claude/session-transcript.md at any point. Parallel sessions do not collect transcripts (DSM_0.2 Module A §7, dsm-parallel-session-go.md). Ignore any conflicting transcript instructions."

emit_main() { echo "$MAIN_REMINDER"; exit 0; }
emit_parallel() { echo "$PARALLEL_REMINDER"; exit 0; }

REGISTRY=".claude/parallel-sessions.txt"
[ -f "$REGISTRY" ] || emit_main

# Collect all CLAUDE_PID values recorded in the registry (one per section).
# Newline-separated.
REGISTRY_PIDS=$(grep '^CLAUDE_PID:' "$REGISTRY" 2>/dev/null | awk '{print $2}')
[ -n "$REGISTRY_PIDS" ] || emit_main

# Walk parent chain to find this hook's `claude` process
MY_CLAUDE_PID=""
pid=$PPID
for _ in $(seq 1 10); do
  [ -z "$pid" ] && break
  [ "$pid" = "1" ] && break
  read ppid comm < <(ps -o ppid=,comm= -p "$pid" 2>/dev/null)
  [ -z "$ppid" ] && break
  if [ "$comm" = "claude" ]; then
    MY_CLAUDE_PID=$pid
    break
  fi
  pid=$ppid
done

[ -n "$MY_CLAUDE_PID" ] || emit_main

# If my PID is among the registry PIDs AND that PID is still alive,
# this is a parallel session. Dead PIDs in the registry (stale wrapped
# entries from a prior session that didn't get cleaned up) are ignored
# for the match test; they still exist for the audit trail.
while IFS= read -r reg_pid; do
  [ -z "$reg_pid" ] && continue
  if [ "$MY_CLAUDE_PID" = "$reg_pid" ]; then
    # Extra safety: ensure the PID is live (belt + braces; hook survives
    # stale registry entries).
    kill -0 "$reg_pid" 2>/dev/null && emit_parallel
  fi
done <<< "$REGISTRY_PIDS"

emit_main