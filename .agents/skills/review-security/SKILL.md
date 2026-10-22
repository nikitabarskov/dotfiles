---
name: review-security
description:
  "Review code and configuration for exploitable trust-boundary failures and
  security regressions."
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

- Identify assets, attacker control, entry points, and deployed safeguards.
  Trace input to a sensitive operation; distinguish an exploitable path from
  hardening.
- Check authentication, token signature/issuer/audience/expiry validation,
  session lifecycle, and recovery flows against the intended identity model.
- Check server-side resource/tenant authorization on every reachable path,
  including alternate methods, batch APIs, jobs, and cached results. Unguessable
  IDs are not authorization; sequential IDs alone are not a vulnerability.
- Trace SQL/shell/template injection, contextual output escaping, path
  traversal, SSRF including redirects/address resolution, and unsafe
  deserialization.
- Evaluate CSRF, CORS, cookies, and security headers against the actual browser,
  credential, and deployment model. Missing headers are not uniformly
  exploitable.
- Check secret disclosure, logs, cryptography, randomness, and key handling.
  Redact secrets in findings; do not reproduce usable credentials.
- Check dependency resolution, lockfiles, artifact provenance, and execution of
  untrusted code. A manifest range with a locked install is not itself a flaw.
  Verify advisory applicability before claiming a dependency is vulnerable.
- Evaluate abuse limits where attacker-controlled work exhausts a real resource.
  Use safe local reproductions; do not exploit live services for validation.

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
