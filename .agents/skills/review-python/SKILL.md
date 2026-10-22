---
name: review-python
description: "Review Python code for runtime correctness, async behavior, resource safety, and maintainability."
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

- Trace exceptions and partial failure. Broad catches are valid at deliberate
  boundaries if recovery is correct; flag swallowed failures with an impact.
  Explicit exception chaining is useful when translating errors, not mandatory
  for every raise because implicit exception context already exists.
- Check mutable defaults and closure capture for unintended shared state.
  Do not call intentional caching or deliberate sharing a bug without evidence.
- Check context-manager cleanup, iterator exhaustion, mutation during iteration,
  timezone handling, and equality/identity assumptions.
- For async code, trace blocking calls, cancellation, task ownership, concurrency
  bounds, and exception collection. Inspect thread/process safety where used.
- Verify annotations against runtime behavior and supported Python versions.
  Do not report annotation spelling or missing hints as correctness defects.
- Check serialization and external input at trust boundaries. Trace ORM access,
  batch size, and memory behavior when data volume makes them material.
- Recommend simplification only when it removes a concrete source of error or
  maintenance cost. Nesting depth and class counts are not defect thresholds.

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
