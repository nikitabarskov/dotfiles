---
name: review-backend
description:
  "Review backend changes across service logic, persistence, queues, and
  distributed boundaries."
---

## Review method

Establish the requested scope, runtime/library versions, and relevant contracts.
For a change review, focus on defects introduced or exposed by the change. For
an audit, assess the requested surface, including existing defects.

Use available review triage and code graphs to prioritize changed entities and
trace consumers. Batch related queries. Read affected code and configuration;
consult history when intent matters. If tools or indexes are unavailable, use
the diff and targeted reads. Tool risk scores are leads, not evidence.

Follow each suspected issue to a concrete trigger and consequence. Check for
existing safeguards and counterexamples before reporting it. Use targeted tests
or reproductions when they resolve uncertainty. Do not modify the implementation
unless asked. Do not run destructive operations or live deployments for review.

## Focus

- Follow the changed request/job from input through authorization, business
  invariants, persistence, and response/acknowledgment. Review failure paths
  too.
- Load only relevant companion skills: review-golang or review-python for
  language details, review-sql for persistence changes, review-api for contract
  changes, and review-security when trust boundaries change. Resolve them beside
  this skill; if unavailable, review the relevant concerns directly and note the
  limitation.
- Check transaction boundaries, duplicate processing, acknowledgment timing,
  poison messages, backpressure, and compatibility with queued older payloads.
- Trace timeout/retry budgets across dependencies. Retries must not multiply
  harm; circuit breakers and fallback behavior depend on the actual failure
  model.
- Check cache keys, invalidation, expiration, miss handling, concurrent fills,
  and object publication/cleanup against consistency and durability
  requirements.
- Check bounded memory/streaming and observability needed to detect concrete
  failures. Do not demand every metric or recovery mechanism in every service.
- Combine companion findings into one report; do not repeat shared findings or
  run the same triage for every language.

## Findings

Lead with the verdict and its scope: ship, revise, or rework. If no actionable
issues were found, say so; this is not a guarantee of correctness.

Report findings once, ordered by severity. Each needs a precise file/line (or
document section), the failure condition, its impact, and the smallest useful
fix. Separate verified defects from unresolved questions. State missing evidence
and checks that could not run. Do not invent certainty or fill a finding quota.

Prefer correctness, security, data integrity, and demonstrated operational
problems over style preferences. Do not demand a pattern, abstraction,
dependency, or optimization without showing why the existing approach fails its
requirements. Mention automated check failures when relevant; do not repeat
their full output.
