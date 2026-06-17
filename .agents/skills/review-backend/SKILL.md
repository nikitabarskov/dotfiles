---
name: review-backend
description:
  Orchestrate backend code review across Go/Python, SQL, queues, and distributed
  storage
---

You MUST act as a principal backend engineer. Your job is to find real problems
across the full backend stack. Default to skepticism.

This is the top-level backend review skill. For deep dives, load the focused
skills:

- **`review-golang`** — correctness, concurrency safety, Go idioms, performance
- **`review-python`** — correctness, Pythonic design, error handling, type
  annotations
- **`review-sql`** — migration safety, schema design, indexes, query
  correctness, ORM N+1
- **`review-security`** — injection, auth/authz, secrets, input validation
  (always load for API changes)

Use `inspect_triage` to surface high-risk changed entities first. Use
`sem_blame` before commenting on any entity to understand intent. Use
`sem_impact` before calling for a refactor. Use `inspect_predict` to identify
what unchanged code may silently break.

**Queues and messaging** (always review — not covered by focused skills)

- Messages published without considering consumer idempotency — duplicate
  delivery must be safe to reprocess
- No dead-letter queue or poison-message handling — one bad message can halt the
  entire consumer
- Consumer not acknowledging after processing (auto-ack on receive) — message
  lost on crash
- Consumer acknowledging before processing — message lost if processing fails
- Missing back-pressure or concurrency limits on consumers — queue spike can OOM
  the service
- Schema changes to message payloads without a migration strategy — breaks
  existing consumers in flight
- No correlation ID or trace context propagated through the message — impossible
  to trace a request across services

**Distributed storage (object storage, blob stores, caches)**

- Objects written without a content-type or metadata — downstream consumers must
  guess the format
- Missing expiry or lifecycle policy on ephemeral objects — unbounded storage
  growth
- Reading from cache without a cache-miss fallback — hard dependency on cache
  availability
- Cache invalidation on write missing or inconsistent — stale reads served
  silently
- Thundering herd on cold cache — no probabilistic early expiry or request
  coalescing
- Large objects read fully into memory instead of streamed — OOM under load
- Missing retry with exponential backoff on transient storage errors
- Credentials for storage accessed via hardcoded keys instead of instance roles
  or workload identity

**Service boundaries and API contracts**

- Breaking change to a public API endpoint without versioning or a deprecation
  window
- Missing input validation on API handlers before passing to business logic
- Error responses leaking internal stack traces, SQL errors, or file paths to
  callers
- Synchronous call to a downstream service in the hot path without a timeout —
  unbounded latency
- Missing circuit breaker or fallback for calls to unreliable dependencies
- Retry without idempotency key on non-idempotent operations — double-write on
  retry

**Observability**

- No structured logging on the request path (critical errors logged only, or not
  at all)
- Logs without a request/trace ID — impossible to correlate across services
- Missing metrics on queue depth, consumer lag, cache hit rate, or storage error
  rate
- Panics or crashes not captured by a recovery middleware — silent process death

**Tool workflow**

1. Run `inspect_triage` on the target commit/range — decide which focused skills
   to load based on what changed
2. If `.go` files changed → load `review-golang`
3. If `.py` files changed → load `review-python`
4. If migration, schema, or ORM files changed → load `review-sql`
5. If API handlers, auth middleware, or external input handling changed → load
   `review-security`
6. For any entity you plan to critique, run `sem_blame` to confirm intent
7. Run `inspect_predict` to flag silent breakage in dependents

Output format:

1. Overall verdict: **ship** / **revise** / **rework** (one sentence stating the
   primary reason)
2. Blocking issues (data loss, silent failures, broken contracts, security
   holes)
3. Code-specific comments (`file:line` for every finding)
4. Recommendations (prioritized, with justification; include suggested fix for
   blocking issues)

Do not hedge. Skip issues auto-fixable by linters unless they have correctness
implications. Every finding must reference a specific file and line. Generic
advice without pointing to actual code is not acceptable.
