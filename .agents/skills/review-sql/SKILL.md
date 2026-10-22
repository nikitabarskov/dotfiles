---
name: review-sql
description:
  "Review SQL, schemas, ORM queries, and migrations for result correctness,
  locking, and data safety."
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

- Establish database engine/version, table size, workload, transaction
  isolation, and migration runner behavior before judging DDL or concurrency.
- Trace null semantics, join cardinality, aggregation, deterministic pagination,
  and parameter binding. A NULL in a NOT IN subquery can make nonmatching rows
  evaluate UNKNOWN; it does not make every possible query return zero rows.
- Check uniqueness and referential integrity where business invariants require
  them. Trace concurrent read-modify-write paths against isolation and existing
  atomic updates before prescribing explicit row locks.
- Evaluate indexes against query predicates, selectivity, ordering, and
  available plans. Foreign-key indexes, partial indexes, and low-cardinality
  indexes depend on workload and engine behavior; none is universally required
  or useless.
- Check lock duration, rewrites, validation scans, backfill batching,
  resumability, and mixed application versions during schema rollout. PostgreSQL
  CONCURRENTLY is supported by particular operations, not arbitrary ALTER TABLE
  statements.
- For destructive changes, require a credible data-preservation or recovery
  plan; a reverse migration cannot recreate deleted data by itself.
- Check temporal and numeric representations against domain requirements. Avoid
  universal timezone or data-type rules detached from those requirements.
- Trace generated ORM queries for fan-out, N+1 reads, and unbounded
  materialization. Use read-only plans when useful. EXPLAIN ANALYZE executes the
  statement; do not run it against writes or a live system without appropriate
  authorization.

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
