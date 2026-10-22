---
name: review-frontend
description: "Review frontend changes for user-visible correctness, security, accessibility, and loading behavior."
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

- Follow the changed user flow through navigation, data loading, interaction,
  submission, and recovery. Check loading, empty, denied, and error states.
- Load only relevant companion skills: review-react for component behavior,
  review-typescript for type boundaries, and review-tanstack when those libraries
  are used. Resolve them beside this skill; if unavailable, cover those concerns
  directly and state the limitation.
- Trace untrusted content to HTML/URLs and check exposed browser credentials.
  Route guards improve UX; sensitive operations still need server authorization.
- Check keyboard access, accessible names, focus movement/restoration, semantics,
  and contrast in the actual UI. Prefer native semantics before additional ARIA.
- Evaluate bundle/loading cost, request waterfalls, layout shifts, and expensive
  rendering where the change affects them. Recommend performance work with
  measurements or a concrete workload argument, not framework preference.
- Check responsive behavior and hydration/server-client boundaries where relevant.
  Report whether visual and interaction checks actually ran.
- Combine companion findings into one report and avoid duplicate triage.

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
