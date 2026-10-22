---
name: review-tanstack
description: "Review TanStack Router and Query behavior for routing, cache isolation, mutations, and data freshness."
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

- Establish installed Router/Query versions and integration conventions before
  judging APIs, defaults, or type safety. Typed string Link destinations and
  properly constrained useParams/useNavigate calls are valid.
- Trace search validation, loaderDeps, route context, redirects, pending/error
  handling, and cancellation. Missing dependencies matter when loaders can reuse
  results for different inputs. Client route guards do not enforce server auth.
- Query keys must distinguish every input that changes cached data, including
  tenant/user scope where needed. Check cache clearing or partitioning on logout.
- Check query enablement, stale/gc times, retry behavior, and cancellation against
  the UX and data contract. enabled: false and skipToken have different valid uses.
- Trace mutation failures and concurrent optimistic updates: cancellation,
  snapshots, rollback, invalidation, and server reconciliation. Error handling
  may exist in shared configuration or the consuming UI.
- Check infinite-query page parameters and terminal-page behavior against the API.
- Where loaders and Query share data, verify compatible keys/options and freshness
  behavior. Loader-only data is valid; not every route needs a Query cache.
- Check SSR hydration and request-scoped caches for cross-user data leakage.

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
