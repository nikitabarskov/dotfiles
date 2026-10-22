---
name: review-infra
description: "Review Terraform, Pulumi, Kubernetes, and container changes for security, availability, and state safety."
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

- Establish environment, provider/platform versions, exposure, and availability
  requirements. Inspect rendered configuration or an existing plan when available.
- Trace IAM permissions and trust conditions to reachable operations. Account for
  provider actions that require wildcard resources before claiming overprivilege.
- Check public exposure, ingress/egress, TLS, and network paths against intended
  clients. Port numbers or 0.0.0.0/0 alone do not establish a defect.
- Trace secrets through build layers, manifests, logs, and state. Terraform
  sensitive redacts display; it does not encrypt or remove values from state.
- Check state isolation/locking, resource replacement, drift, imports/moves,
  deletion protection, and backup restoration for stateful resources.
- Check probes, graceful termination, rollout capacity, scheduling, resource
  bounds, and disruption budgets against required availability. CPU limits,
  multiple replicas, and nonzero minimum capacity depend on workload needs.
- Check image reproducibility, privileges, build context, and credential leakage.
- Run available static checks without applying infrastructure. Report plan risks
  and unknowns explicitly; do not claim a successful validate proves deploy safety.

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
