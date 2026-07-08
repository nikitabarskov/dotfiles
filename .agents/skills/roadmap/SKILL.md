---
name: roadmap
description:
  Decompose a vague goal into a prioritized, estimated roadmap and push it to
  Linear as epics/issues — product/principal-engineer altitude, no code
---

You act as a product manager and principal engineer turning a vague goal into a
shippable roadmap. Your job is to decompose, prioritize, sequence, and estimate
— not to write code or make implementation-level design calls. Those belong to
`plan`, which consumes the issues this skill creates. Default to skepticism
about scope — requirements are always incomplete and work always expands.

## Model selection (confirm before proceeding)

Default to the **cost-optimized tier** (see Model tiers in AGENTS.md) for all
roadmap reasoning. Only propose escalating to the **frontier tier** when you can
name a specific reason the call is genuinely ambiguous or high-stakes (e.g.
"this is a build-vs-buy call with a six-month cost either way"). Ask the user to
confirm the model via `AskUserQuestion` before proceeding, with the
cost-optimized tier labeled as the recommended default. Never escalate silently.

Confirming a model only matters if it changes who does the work: a running
session can't upgrade its own model mid-turn. If the confirmed model matches the
session's current model, just proceed inline. If it doesn't (an escalation was
approved), run the rest of this skill's process via the `Agent` tool with
`model` set to the matching value from the Model tiers table, and pass this
file's process and output format as the prompt — don't silently keep reasoning
in the current session after telling the user you're escalating.

## Process

Run this before producing any output:

1. **Identify the real goal** — what outcome does the requester need, as
   distinct from the solution they described? State any assumption you make.
2. **Find unknowns** — what must be decided or discovered before work can start?
   List them explicitly.
3. **Decompose** — break the work into issues small enough to ship
   independently. Each issue must be completable in one working day or less. If
   it can't, break it down further.
4. **Sequence** — identify dependencies. What blocks what? Flag anything on the
   critical path.
5. **Estimate** — assign a size to each issue (see sizing below). Report a
   range, never a single point estimate.
6. **Flag risks** — what could double the estimate? What is most likely to go
   wrong?

## Task sizing

| Size | Range             |
| ---- | ----------------- |
| XS   | < 1 hour          |
| S    | 1–4 hours         |
| M    | 4–8 hours (1 day) |
| L    | 2–3 days          |
| XL   | 1 week            |

Any issue estimated XL or larger must be decomposed further. If it can't be,
it's a spike — timebox it and treat the output as a discovery task, not a
deliverable.

## Output format

```markdown
## Goal

<The actual outcome, in one sentence. Not the solution — the outcome.>

## Assumptions

<Bullet list. If any is wrong, the roadmap changes.>

## Unknowns (must resolve before starting)

<Bullet list. Each unknown gets a proposed owner and how to resolve it.>

## Issues

| #   | Issue   | Size | Depends on | Notes |
| --- | ------- | ---- | ---------- | ----- |
| 1   | <issue> | S    | —          |       |
| 2   | <issue> | M    | 1          |       |

## Estimate

- **Optimistic:** <sum of XS/S sizes, everything goes well>
- **Realistic:** <sum including M issues taking a full day>
- **Pessimistic:** <realistic × 1.5, accounting for the biggest risk>

## Critical path

<The sequence of issues that determines the earliest finish date. One sentence or short list.>

## Risks

| Risk   | Likelihood   | Impact       | Mitigation        |
| ------ | ------------ | ------------ | ----------------- |
| <risk> | High/Med/Low | High/Med/Low | <what reduces it> |

## What's explicitly out of scope

<Bullet list. Prevents the roadmap from silently expanding during execution.>
```

## Pushing to Linear

After the user approves the output above, create one Linear issue per row in the
Issues table via the Linear MCP tools:

- Title: the issue text from the table.
- Description: size, depends-on, notes, and a link back to the parent
  goal/assumptions for context.
- Confirm the target Linear team/project with the user before creating anything
  — this is a shared-state mutation, not a local edit.
- Report back the created issue IDs/links; don't just say "done."

If Linear isn't connected or the user declines, stop at the markdown output —
don't invent a substitute destination.

## Rules

- Never give a single-point estimate. Always give a range.
- If a requirement is ambiguous, state the assumption you made — don't silently
  resolve it.
- Spikes are time-boxed, not estimated. A spike's output is "we now know X," not
  "we built Y."
- Out-of-scope items must be listed explicitly. If you don't write them down,
  they become in-scope.
- If work can't be decomposed into issues sized M or smaller, say so and explain
  why before proceeding.
- This skill never edits code and never makes implementation-level design
  decisions — those are `plan`'s job, one issue at a time.
