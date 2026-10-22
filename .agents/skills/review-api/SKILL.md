---
name: review-api
description: "Review REST or gRPC contracts and changes for correctness, compatibility, and retry safety."
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

- Check actual HTTP/RPC semantics, validation, status codes, error shapes, and
  null/omitted/default behavior against the documented contract.
- Analyze compatibility in both directions: old clients with new servers and
  new clients with old servers. New required request fields, removed response
  fields, enum expansion, and tighter validation affect different consumers.
  Adding a required response field is not the same as requiring a new input.
- Check authorization at the resource and operation boundary, including whether
  errors disclose data that the caller must not learn.
- Trace duplicate requests, concurrent updates, partial failures, and timeouts.
  Require idempotency or concurrency controls where retries or lost updates can
  cause harm; do not require idempotency keys on every POST.
- Check bounded result sizes and pagination consistency under the expected write
  pattern. A next-page signal need not include an expensive total count.
- For long operations, evaluate deadlines and completion/retry semantics against
  caller needs. Synchronous success is valid when completion fits the contract.
- For protobuf, check field-number/type compatibility, reserved removed fields,
  presence semantics, update masks where needed, deadlines, and stream flow
  control. Check the deployed protocol/library version before giving syntax.
- Preserve established versioning conventions. Recommend migration/deprecation
  mechanisms for demonstrated consumer breakage, not as ceremony.

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
