---
name: review-react
description: "Review React components and hooks for state, effects, rendering, and user-visible failures."
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

- Check the installed React version and enabled compiler/framework features.
  Apply hook rules with their documented exceptions, including the use API.
- Trace stale closures, effect dependencies, cleanup, async races, and cancellation.
  Effects should synchronize external systems; redundant derived state can drift.
- Check state ownership, identity, keys, accidental remounts, and mutation during
  render. Follow reordered lists and overlapping state updates to visible behavior.
- Check loading, empty, error, retry, and submission states. Error boundaries do
  not catch every async or event-handler error; locate the actual handling path.
- Check server/client boundaries, hydration, and serialization when applicable.
- Use observed expensive rendering or a clear identity requirement to justify
  memoization. Account for compiler optimization when enabled.
- Class components, local form state, prop drilling, and composition choices are
  valid. Recommend changing them only to address a specific defect or cost.

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
