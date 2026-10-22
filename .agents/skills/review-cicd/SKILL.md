---
name: review-cicd
description: "Review CI/CD workflows for trust boundaries, reliable checks, artifact integrity, and deployment safety."
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

- Trace event context, checked-out revision, token permissions, secrets, and
  runner isolation. Pay particular attention to untrusted PR code in privileged
  workflows such as pull_request_target and downstream workflow_run jobs.
- Check untrusted expressions interpolated into shell code and persistent caches
  or artifacts crossing trust boundaries. Pin external actions where required by
  the threat model or repository policy; explain the concrete supply-chain risk.
- Trace failure propagation using the actual shell and runner defaults. Check
  pipes, conditional jobs, continue-on-error, needs, and required-check behavior.
- Ensure tested artifacts and revisions are the ones released. Check dependency
  locks, cache restore semantics, platform keys, and build provenance.
- Check deployment concurrency, environments, credentials, migration ordering,
  health verification, and recovery. Cancellation of a deploy can leave partial
  state. Automatic production deployment is valid with suitable safeguards.
- Evaluate timeouts, parallelism, path filters, and notification rules against
  measured cost and required coverage. Do not require sharding or manual gates
  simply because the pipeline could support them.
- Validate configuration locally where possible; do not trigger production jobs
  as a review check.

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
