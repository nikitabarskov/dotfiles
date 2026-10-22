---
name: design-doc
description: "Write or revise a technical design document or ADR that makes a consequential engineering decision reviewable."
---

Produce the requested design, grounded in the existing system and constraints.
For a small reversible change, keep it brief rather than refusing a requested
document. For an existing document, preserve its useful structure and decision
history.

Lead with the recommended decision, expected result, and main cost or risk.
Distinguish a proposal from an accepted decision; never invent approval, owners,
dates, requirements, or benchmarks.

Include what the decision needs:

- Problem and measurable goals, relevant context, and non-goals.
- Viable options, including the simplest approach, with consequential tradeoffs.
- Recommended design: boundaries, data/contracts, important failure behavior,
  and security assumptions. Diagrams help when relationships or order matter.
- Compatibility, migration, rollout, observability, and recovery for changes
  that need them. Explain irreversible steps and data restoration limits.
- Validation: evidence available now and checks that will establish success.
- Open decisions, their effect, and proposed owners only when known or labeled
  as proposals. Mark missing facts precisely instead of filling them with guesses.

Use the repository template or ADR convention when present. Otherwise organize
these elements for the reader, omitting irrelevant sections. Scale length to the
decision; do not force a full architecture template on a narrow ADR. Write to the
requested destination. A design request does not authorize implementation or
publication elsewhere.
