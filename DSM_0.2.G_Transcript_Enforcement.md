# DSM_0.2 Session Transcript Enforcement Detail

The enforcement mechanism, turn-boundary self-check, and retroactive-recovery
detail for the Session Transcript Protocol (DSM_0.2 §7), extracted from §7.
Read on demand; NOT part of the `@` import chain. §7 keeps the operational rules
always-loaded and points here for the origins, rationale, and worked examples.

---

**Per-Turn Transcript Append Enforcement Mechanism:**

Static rules and operator discipline are insufficient to keep this protocol
active across long sessions; in S171 the agent skipped appends for 7
consecutive turns despite both §7 and `/dsm-go` step 6 telling it not to.
The reliable enforcement layer is a `UserPromptSubmit` hook in
`.claude/settings.json` that injects a per-turn reminder. Two hooks form a
complementary pair: the `UserPromptSubmit` hook enforces *occurrence* (an
append must happen this turn), and `validate-transcript-edit.sh` (PreToolUse
on Edit) enforces *shape* (anchor, append-only, delimiter) and, since BL-517,
*value* , check 4/4 compares the delimiter's `HH:MM` against the wall clock and
**warns** above a 5-minute tolerance.

Check 4 warns rather than blocks, and the asymmetry is deliberate. Checks 0-3
guard against an append that would damage the file, so vetoing them is
proportionate. A drifted timestamp damages nothing; it mislabels a log entry.
Blocking an append over it would wedge the protocol the hook exists to keep
running, and a gate the user learns to dismiss is worse than no gate. The
non-blocking channel is exit 1, the same convention
`validate-cross-repo-write.sh` uses. `[RETROACTIVE]` delimiters get **no**
exemption: §7 requires them to carry the current time, so they are checked like
any other. Origin: three recorded drift incidents , roughly 13 hours, 8 hours
27 minutes, and a non-monotone 132-minute swing in both directions , none of
which any check detected, because until BL-517 nothing read the number.

Neither IDE
monitoring nor session-start "behavioral activation" is the enforcement
mechanism; both are user-facing affordances that document intent without
requiring it. The hook is the mechanism.

**Turn-Boundary Transcript Append Self-Check:**

Every turn begins with a transcript append. Every turn. At the start of
every turn, before composing a response, the agent must ask: "Was my
first tool call this turn an append to `.claude/session-transcript.md`?"
If the answer is no, the protocol has been violated. The check is binary;
no "I planned to" or "the next call would have been" answers count.

This rule applies to turns that produce reasoning, recommendations, or
decisions **without touching any files**. Pure-reasoning turns are
explicitly covered: a turn whose response is a multi-paragraph decision
analysis, trade-off comparison, or recommendation requires the same
first-tool-call transcript append as a turn that edits code. The
pure-reasoning-turn failure mode is the most damaging variant because
pure-reasoning turns contain the highest-value reasoning (decision
rationale, considered-and-rejected paths, risk framing) and losing that
content inverts the transcript's stated purpose as a reasoning log.

**Example of the pure-reasoning-turn failure mode:** a turn in which the
user asks "which of these two options should we pick?" and the agent
responds with a multi-paragraph comparison (five-question gate
evaluation, Option A vs Option B analysis, recommendation, proposed
next steps) as a pure-text response with zero tool calls. This is a
protocol violation. The agent must append the plan entry to the transcript as
the first tool call of that turn, even though the turn would otherwise
have none. The transcript append is the one required tool call.

**The only exemption is content-trivial turns:** one-word
acknowledgments ("Understood", "OK"), single-fact confirmations ("Yes",
"No"), and responses with no new reasoning. The exemption is content-
based, not tool-call-count-based. A turn that produces substantive new
reasoning of any length is never content-trivial, regardless of whether
it touches files. If there is new reasoning, there is a transcript
append.

**[RETROACTIVE] Transcript Append Self-Detection Rule:**

If the agent detects mid-turn or at the start of a later turn that it
missed an earlier append, it must:

1. Append a recovery entry to the transcript labeled
   `<------------Start Plan [RETROACTIVE] / HH:MM------------>` where
   HH:MM is the *current* time, not a fabricated earlier time.
2. State which turn(s) were missed and a brief reconstruction of the
   reasoning that would have been recorded.
3. Note the gap explicitly; never edit history or insert mid-file to make
   it look like the appends happened on time.

Retroactive entries are evidence the protocol failed and recovered, not a
workaround that makes the failure invisible.
