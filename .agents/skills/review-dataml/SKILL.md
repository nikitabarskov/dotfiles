---
name: review-dataml
description: "Review data and ML pipelines for leakage, result correctness, reproducibility, and serving consistency."
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

- Trace data lineage and what was knowable at prediction time. Check temporal,
  entity/group, and train/validation/test boundaries before preprocessing or tuning.
- Verify join cardinality, null handling, units, time zones, windows, completeness,
  late data, and deduplication against the intended data contract.
- Compare training and serving feature definitions and preprocessing artifacts.
  Shared code alone does not prove matching data or runtime semantics.
- Check dataset/model/artifact identity, parameters, environment, and randomness.
  Seeds alone do not guarantee determinism; bound nondeterminism to the task's
  reproducibility needs instead of requiring bitwise equality everywhere.
- Evaluate metrics, baselines, uncertainty, leakage from tuning, and relevant
  subgroups against the prediction objective. Do not infer performance from code.
- Trace retries, checkpointing, partial output, atomic publication, and schema
  evolution through batch/stream consumers.
- Check inference validation, resource bounds, model loading provenance, rollout,
  drift detection, and rollback for the deployed risk level.
- Use small representative fixtures for checks. Do not start expensive training
  or overwrite datasets/artifacts without authorization.

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
