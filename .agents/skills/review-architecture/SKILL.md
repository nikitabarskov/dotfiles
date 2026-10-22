---
name: review-architecture
description: "Assess a proposed or existing architecture against its requirements, failure modes, and operational cost."
---

## Review method

Establish the requested scope, runtime/library versions, and relevant contracts.
For a change review, focus on defects introduced or exposed by the change.
For an audit, assess the requested surface, including existing defects.

Use available review triage and code graphs to prioritize changed entities and
trace consumers. Batch related queries. Read affected code and configuration;
consult history when intent matters. If tools or indexes are unavailable, use
the diff and targeted reads. Tool risk scores are leads, not evidence.

Follow each suspected issue to a concrete trigger and consequence. Check for
existing safeguards and counterexamples before reporting it. Use targeted tests
or reproductions when they resolve uncertainty. Do not modify the implementation
unless asked. Do not run destructive operations or live deployments for review.

## Focus

- Establish workload, growth, consistency, latency, availability, security, and
  cost constraints. Mark unknowns instead of inventing scale targets.
- Trace representative requests and data ownership across component boundaries.
  Identify coupling, transaction boundaries, and compatibility during rollout.
- Analyze dependency failure, overload, retries, idempotency, recovery, and the
  maximum affected population. Name what fails and under which condition.
- Check trust boundaries and ownership of authorization, credentials, and data.
- Estimate dominant resource/cost drivers using stated assumptions. Distinguish
  measured limits from projections; do not add distributed components on instinct.
- Compare the current design with the simplest viable alternative. Recommend
  changes only when their benefit outweighs migration and operational complexity.
- Include rollout/recovery and observable success criteria for major changes.
  For design-only input, cite sections or diagrams instead of inventing code lines.
- Use sound / needs revision / fundamentally flawed as the architecture verdict
  instead of the code-review verdicts below.

## Findings

Lead with the verdict and its scope: ship, revise, or rework. If no actionable
issues were found, say so; this is not a guarantee of correctness.

Report findings once, ordered by severity. Each needs a precise file/line (or
document section), the failure condition, its impact, and the smallest useful
fix. Separate verified defects from unresolved questions. State missing evidence
and checks that could not run. Do not invent certainty or fill a finding quota.

Prefer correctness, security, data integrity, and demonstrated operational
problems over style preferences. Do not demand a pattern, abstraction, dependency,
or optimization without showing why the existing approach fails its requirements.
Mention automated check failures when relevant; do not repeat their full output.
