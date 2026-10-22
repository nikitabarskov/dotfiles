---
name: implement
description:
  "Execute a plan with resumable work orders, proportionate delegation, and
  verified completion."
---

Read the selected plan, repository instructions, and current working state.
Honor its outcome, constraints, dependency order, and previously completed work.
Implementing the requested plan is authorized; do not require a dispatch-table
approval before starting ordinary work.

## Execution

Use the active session for small or tightly coupled changes. Delegate
independent, substantial work orders when available and useful. Choose by task
complexity, tool access, and cost rather than vendor stereotypes or line counts.
Use the repository's tier mapping for delegated work: cheap for mechanical work,
default otherwise, frontier only for a named architectural risk, unclear
requirement, or large area of effect. Check identifiers against the available
runtime; if a mapped model is unavailable, report the fallback and use a
supported option within the authorized cost/capability constraints. Never claim
a model switch that did not occur.

Give delegates the work order's goal, files, constraints, non-goals, proof,
output, and relevant context. Assign disjoint ownership for parallel edits;
integrate dependent work serially. Use native agent tools when suitable. For
another CLI, use the configured claudeh/codexh wrapper, preserve
sandbox/approval settings, and resume the same task when useful. Never disable
safeguards to make dispatch easier. If delegation is unavailable, execute
locally when possible.

Resolve routine implementation choices within the plan. Revisit the plan for
changes to architecture, public contracts, data safety, or scope. Mark such
items `[blocked: needs-plan]` with the missing decision and continue independent
items. Do not execute `design-required` entries as if their decisions were
settled. When retries stop producing new evidence, diagnose the blocker instead
of looping or escalating the model automatically.

## Verification and status

Inspect the actual diff, the delegate report, and the verification evidence. Run
the work order's proof against the integrated result; avoid repeating an
identical expensive check when reliable evidence already covers the same state.
Run required repository checks and targeted integration checks after
integration. Do not accept a delegate's unsupported claim of success.

Update the same plan after each item: `[ ]` to `[x]` only after its proof
passes, or record the blocker and attempted checks. Preserve legacy blocked
markers and include enough evidence to resume without repeating completed work.
Do not mark an item done when a necessary test is unavailable.

Report completed outcomes, checks, and remaining blockers. Commit, publish, or
deploy only when authorized by the user's scope; execution of a local plan alone
does not authorize those external actions.
