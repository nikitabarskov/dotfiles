---
name: plan
description:
  "Turn a scoped task or issue into an actionable implementation plan with
  design decisions, work orders, and verification."
---

Produce a plan, not implementation code. Use the active session; no model-picker
confirmation is needed. If delegating, use the repository's cost-optimized tier
unless a named risk justifies another available tier. Verify identifiers against
the runtime; do not pretend that announcing a model changes the session model.

## Design

State the outcome and survey enough of the existing code, contracts, and tests
to choose an approach. Use available graphs for structural questions and
targeted reads for relevant details. State consequential assumptions and resolve
routine implementation choices yourself. Ask only about decisions that
materially change scope, compatibility, data safety, or user-visible behavior.

Recommend an approach and explain its main tradeoff. Include migration, rollout,
and recovery when relevant. For a broad multi-project goal, recommend roadmap
and produce useful decomposition rather than inventing implementation detail.

## Artifact

Write the requested artifact, otherwise .plans/<slug>.md. Creating the requested
plan does not need a separate approval round. Preserve an existing plan's
history and status when updating it. Use this contract for implement:

```markdown
# Plan: <task>

## Outcome

<observable result>

## Design decisions

- <decision, rationale, and consequential tradeoff>

## Work orders

- [ ] 1. `workorder` <title>
  - Goal: <observable outcome>
  - Files: <known paths or bounded discovery scope>
  - Constraints: <invariants and compatibility requirements>
  - Non-goals: <excluded work>
  - Proof: <verification command and expected outcome>
  - Output: <deliverable and evidence to report>
- [ ] 2. `design-required` <unresolved decision>
  - Open question: <decision and why it cannot be inferred>
  - Blocks: <dependent items>

## Sequence

<dependencies and safely independent work>

## Out of scope

<explicit exclusions>
```

Scale work orders to coherent, reviewable changes. Give enough context for an
executor to work without conversation history; do not prescribe every line or
pretend that all implementation judgment can be eliminated. Verify that named
commands/files exist, or clearly label commands that the implementation will
add. Separate existing test failures from expected acceptance results.

Keep unresolved design decisions visible. Allow independent work to proceed even
if other items need a decision. Report the artifact and the decisions still
needed; planning alone does not authorize implementation.
