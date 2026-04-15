# Communication Channel Framework

DSM projects produce insights, techniques, and results that serve different
audiences through different formats. "Blog post" is one channel; this framework
defines the full set and guides channel selection at generation time.

## Channel Types

| Channel | Audience | Format | Tone | Length |
|---------|----------|--------|------|--------|
| **Blog post** | Technical practitioners, data scientists | Long-form, educational, code examples | Technical, explanatory | 800-2,000 words |
| **LinkedIn post** | Professional network, peers, recruiters | Concise, impact-focused, narrative hook | Professional, accessible | 150-300 words |
| **Stakeholder report** | Decision-makers, managers, clients | Results-focused, minimal technical detail | Business, outcome-oriented | 1-2 pages |
| **Conference abstract** | Academic/professional reviewers | Structured (motivation, method, results, contribution) | Academic, precise | 250-500 words |
| **Portfolio entry** | Recruiters, hiring managers | Outcome-focused, skill demonstration | Professional, concise | 200-500 words |
| **README update** | Project users, contributors | Feature/capability announcements | Neutral, factual | Variable |

## Selection Workflow

When generating communication material from session artifacts:

1. **Identify source material:** checkpoints, technical reports, decision logs,
   blog seeds (`docs/blog/`), experiment results
2. **Select channel:** Which audience benefits most from this content?
3. **Apply format:** Use the channel's tone and length guidelines
4. **Draft:** Generate content tailored to the channel
5. **Review:** Human reviews and adjusts before publication

Multiple channels can be generated from the same source material. A sprint
completion might produce a blog post (detailed technique), a LinkedIn post
(impact summary), and a portfolio entry (skill demonstration).

## Relationship to Existing Artifacts

- **docs/blog/:** Blog seeds and materials feed the "Blog post" channel.
  The blog pipeline (DSM_0.1 Blog Artifacts) is unchanged; this framework
  sits above it.
- **DSM Section 2.5:** Communication standards apply to all channels. The
  Blog Style Guide (Section 2.5.9) is channel-specific guidance for the
  blog channel.
- **BL-055 (blog platform):** Implements the blog channel's publication
  infrastructure. Other channels use their own platforms (LinkedIn, portfolio
  site, conference submission systems).

## Tone Transformation

The same insight can be expressed differently per channel:

- **Technical (blog):** "We implemented a tiered research pattern where broad
  research produces a decision, then an assessment gate determines whether
  deep-dive research is needed before planning."
- **Professional (LinkedIn):** "One insight from building a methodology
  framework: research naturally tiers. A quick survey gets you to a decision,
  but sometimes the decision reveals unknowns that need deeper investigation
  before you can plan concretely."
- **Business (stakeholder):** "The research phase now scales to project size,
  reducing time spent on unnecessary deep dives while ensuring critical
  unknowns are resolved before planning begins."
