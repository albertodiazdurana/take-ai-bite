### [2026-04-01] Blog idea: collaborating with a stubborn agent

**Type:** Notification
**Priority:** Medium
**Source:** DSM Central (Session 161)

Blog post idea from Alberto: "Collaborating with a stubborn agent." The story:
a recurring protocol violation (session transcript mid-file insertions) persisted
across 3+ sessions despite being documented in 3 separate places (CLAUDE.md,
reasoning lessons, DSM_0.2 §7). Text-based instructions proved insufficient
under cognitive load. The resolution: implementing a Claude Code PreToolUse hook
that mechanically enforces the rule, making it physically impossible for the
agent to violate.

**Key themes:**
- Text-based rules vs mechanical enforcement in AI collaboration
- When the agent "knows" the rule but still violates it
- Claude Code hooks as a governance mechanism
- The human's role in escalating from "remind the agent" to "make it impossible"
- Defense-in-depth: instructions → reasoning lessons → hooks

**Plot twist: the stubborn agent improved the protocol.**

BL-291's hook enforces three checks on every transcript edit. Check 3 requires a
timestamped delimiter (`<------------Start {type} / HH:MM------------>`) on every
appended block. This meant Output and User blocks, which previously used plain
`**bold:**` markdown, now needed proper delimiters too. The hook refused to let
the agent append without one.

This forced the question: if all three block types need delimiters, why do they
use different formats? The answer was BL-292 (same session): universal typed
delimiters for all transcript entries. Three types (Thinking, Output, User),
same format, all timestamped. The transcript became a structured event log,
enabling programmatic analysis (thinking-to-output ratios, phase durations,
steering patterns).

The stubborn agent that kept inserting mid-file didn't just get corrected, it
drove a protocol improvement. The enforcement mechanism designed to stop bad
behavior revealed a design inconsistency that had been invisible when the rules
were just text.

**Additional themes:**
- Enforcement as design feedback: constraints reveal inconsistencies
- The hook that was built to stop violations ended up improving the protocol
- From "make the agent follow the rules" to "the rules weren't good enough"

**Source material:**
- Reasoning lessons S102, S140 (documenting the violation pattern)
- Session 161 transcript (the violation + fix + protocol improvement in one session)
- BL-291 (the hook implementation)
- BL-292 (universal typed delimiters, the protocol improvement the hook revealed)
- `.claude/hooks/validate-transcript-edit.sh` (the enforcement mechanism)
- Two bonus hook bugs found during BL-292: grep failing on dash-prefixed patterns,
  file path regex matching unrelated filenames ending in "session-transcript.md"
