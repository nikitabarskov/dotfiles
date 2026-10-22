---
name: review-golang
description: "Review Go changes for correctness, concurrency, resource lifetime, and performance regressions."
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

- Trace error handling, nil/interface semantics, partial results, and cleanup.
  Wrap errors when callers need identity or context; check errors.Is/As behavior.
- Check shared-state synchronization, lock ordering, channel ownership, and
  goroutine termination on success, error, cancellation, and timeout.
- Follow context propagation across I/O and worker boundaries. Check transaction,
  response-body, timer, and file lifetimes, including early returns.
- Check version-dependent language behavior such as loop-variable capture against
  the module's Go version rather than assuming older semantics.
- Evaluate receiver and interface choices by aliasing, contracts, and consumers.
  Do not require an interface or dependency-injection layer just for testing.
- Investigate allocation, copying, or contention only on relevant paths with
  workload evidence. Pooling adds ownership and lifetime risks.
- Prefer tests for observable failure cases, including race detection where
  concurrency changed, over tests that mirror implementation details.

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
