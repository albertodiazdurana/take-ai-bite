# DSM: AI Collaboration Principles

**Version:** 1.0
**Date:** February 2026
**Purpose:** Define the principles that govern human-AI collaboration in DSM projects.

---

AI can write faster than any human can read. That asymmetry is the central
challenge of human-AI collaboration: not whether the AI can produce, but
whether the human can keep up.

DSM's position is that the human must always keep up. Not because AI output
is untrustworthy, but because the human contributes something the AI cannot
generate on its own: direction, experience, intuition, aesthetic judgment,
and the sense of when something is right. The human provides the spark of the
work. AI magnifies, amplifies, and expands. It is a productive dichotomy, but
only when balanced. It feeds and nurtures when the proportions are right. It
controls and chokes in excess.

The principles below exist to maintain that balance.

---

## 1. Take a Bite

**Deliver only what the reviewer can chew.**

The amount of work an agent produces in a single delivery, whether a notebook
cell, a file, a PR, or a session's worth of artifacts, must not exceed what
the reviewer can engage with and respond to with substance. If the best the
reviewer can say is "oh wow, impressive... but ok, I trust you," the delivery
was too large.

The test is not about counting artifacts. A single file can be too much if
it's 500 lines of dense logic. Three files can be fine if they're small and
self-explanatory. The test is cognitive: can the reviewer read it, understand
it, form an opinion, and redirect if needed?

When the delivery exceeds that threshold, the collaboration silently degrades.
The human stops reviewing and starts approving. The "human in the loop"
becomes decorative. The spark goes missing from the work.

This principle applies to tool output too, not just deliverables. Automated
tools (profiling reports, linting summaries, test suites) can generate hundreds
of data points in seconds. When the agent runs every available tool because it
can, not because the output serves the next step, the result is info-dumping:
the human scrolls instead of analyzing. Generate only what you can meaningfully
process in the next step. Comprehensive reports serve as reference material and
safety nets ("did we miss anything?"), not as the analysis itself.

See `TAKE-AI-BITE.md` for the short version.

## 2. The Human Brings the Spark

**AI amplifies. The human directs.**

The human plans, perceives, senses when something is off, guides the work,
and provides what no model can generate: the lightness, the aesthetic, the
style, the tone. These are not nice-to-haves; they are the difference between
work that is correct and work that is right.

AI is exceptionally good at producing volume, finding patterns, and executing
known procedures. It is not good at knowing when to stop, when the tone is
wrong, or when the technically correct answer misses the point. Those
judgments require the human to be present, not just in the loop but actively
engaged with the material.

This principle is why "Take a Bite" matters: if the delivery is too large for
the human to engage with, the human's unique contribution, the spark, gets
bypassed.

## 3. Earn Your Assertions

**Investigate before you claim. Verify before you act.**

Neither the human nor the agent gets to assume. Every assertion should be grounded
in context that was actually built, not borrowed from intuition alone. When the agent
presents a fact, it should be something it checked. When the human approves a
delivery, it should be because they reviewed it. When either side says "this is how
it works," they should have looked.

Context is the foundation for both sides. The agent builds context by reading the
codebase, researching the domain, and checking actual outputs. The human builds
context by reviewing prior art, understanding the problem space, and verifying
results. Neither should act from a vacuum.

This means:
- Research state of the art before assuming novelty; someone likely solved a
  similar problem, and their experience shortens the path
- Cite sources and references; assertions that trace back to evidence are
  stronger than assertions that trace back to confidence
- Explore the codebase before proposing changes
- Research the domain before building
- Verify consequences before executing destructive commands
- Report actual values, never estimates
- Test, experiment, and validate with real data, not just read the summary

The alternative, asserting without checking, compounds silently. One unchecked
assumption becomes the foundation for the next, until the work looks solid but rests
on nothing verified.

**Accountability corollary:** The human who submits the work is the author of
record, regardless of which tools produced it. AI is an instrument; the human
bears responsibility for correctness, completeness, style, and impact. "The AI
wrote it" is not a defense for errors, omissions, or harm. This responsibility
is not diminished by the quality of the AI's output; it is established by the
act of submitting the work under your name. Review is not optional when the
stakes include your professional credibility.

## 4. Understand, Review, Decide

**The user understands first, reviews second, and decides third.**

This is DSM's core interaction loop. Before any approval, the user must
understand what was done and why. Before any decision, the user must have
reviewed the actual output. Skipping steps, approving without understanding,
deciding without reviewing, breaks the collaboration even when the output
happens to be correct.

In practice this means:
- The agent explains before it acts
- The agent delivers in reviewable increments (Take a Bite)
- The agent waits for the human's substantive response before continuing
- "Continue" is a valid response only when the human has seen and understood
  the previous output

## 5. Know Your Context

**The agent is responsible for its own resource consumption.**

An AI agent operates within constraints: context window size, session
duration, the user's available review time. A responsible agent is aware of
these constraints and manages them proactively rather than consuming resources
until they run out.

This means:
- Estimating context impact before reading large files
- Warning when context is running low, with options to scope down or wrap up
- Splitting large reference material into manageable pieces
- Planning session scope proportional to available resources

The alternative, charging ahead until the context overflows and hoping the
recovery mechanism works, is reactive. It wastes the user's time and
degrades the quality of the session's second half.

## 6. Match the Room

**Contribute proportionally to the project's culture and scale.**

When collaborating with an external project, the contribution should match
the project's existing style, conventions, and pace. A project that reviews
30-line PRs should not receive a 500-line PR. A project with a minimalist
README should not receive a verbose policy document. A project that values
concise commit messages should not get essays.

This principle extends "Take a Bite" to the social dimension: the "reviewer"
is not just the DSM user, but the upstream maintainer, the community, and
anyone who encounters the contribution.

## 7. Own Your Process

**Disclose how the work was produced. The human decides the level of detail.**

When AI contributes to a deliverable, the people who receive that deliverable
deserve to know. Not because AI involvement is a deficiency, but because
transparency about production methods is a professional obligation. A reviewer
who knows AI was involved reviews differently than one who assumes manual work.
A maintainer who knows a PR was AI-assisted can calibrate their expectations.
Concealing the method undermines trust even when the output is flawless.

DSM's position: default to disclosure. The question is not whether to disclose,
but how much detail the context requires.

**What to disclose:**
- Which tool was used (model name, not version unless relevant)
- The nature of AI involvement (generation, review, editing, research)
- What the human contributed (direction, review, domain judgment, testing)

**What NOT to disclose:**
- Exact prompts or conversation transcripts (these are process artifacts, not
  deliverables; sharing them may expose proprietary methods or internal context)
- Token counts or cost metrics (irrelevant to the recipient)

---

## Applying the Principles

When in doubt about whether a delivery is the right size, apply this
sequence:

1. **Can the reviewer read all of it?** If not, split it.
2. **Can the reviewer form an opinion on it?** If not, it needs more
   explanation or less volume.
3. **Can the reviewer redirect it?** If the cost of "actually, let's try
   this differently" feels prohibitive because too much work has been done,
   the delivery was too large.

---

## Environmental Awareness

AI collaboration has an environmental cost. Every prompt, every context window,
every regenerated response consumes compute resources with real energy and
carbon implications.

DSM does not prescribe model selection or usage limits; those decisions depend
on task requirements, budget, and availability. Instead, DSM encourages
awareness:

- **Prefer sufficient over maximal.** When a smaller or faster model handles
  the task adequately, use it. Reserve larger models for tasks that genuinely
  benefit from their capabilities.
- **Avoid unnecessary regeneration.** Refine prompts rather than requesting
  multiple full outputs to pick the best one.
- **Be intentional about context.** Reading a 2,000-line file "just in case"
  has a cost.

This is an awareness principle, not a compliance requirement. The individual
practitioner's choices are small relative to infrastructure-level decisions,
but awareness is the prerequisite for better choices at every scale.
