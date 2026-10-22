---
name: review-typescript
description: "Review TypeScript boundaries and types for unsound assumptions that cause runtime or compatibility defects."
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

- Read tsconfig and package/compiler versions. Check strictness, module settings,
  declaration output, and consumer compatibility relevant to the change.
- Trace assertions, any, non-null assertions, and suppression directives to the
  invariant they bypass. Report a reachable failure, not the syntax alone.
- Check external-data validation where untrusted values enter trusted logic.
  Type assertions cannot validate runtime data; existing upstream validation may
  already establish the contract. Do not mandate a particular schema library.
- Check narrowing, user-defined type guards, discriminants, optional properties,
  indexed access, generic variance, and impossible intersections at real call sites.
- For public APIs, inspect inferred declaration changes and assignability in both
  producer and consumer directions. Explicit return types are a tool, not a rule.
- Enums, utility types, overloads, and inferred types are valid language features.
  Recommend alternatives only when the compilation/runtime contract benefits.
- Separate compiler-detected build failures from unsoundness accepted by the
  compiler. Include a small counterexample when it makes the problem clear.

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
