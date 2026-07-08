---
name: implement
description:
  Execute a plan artifact's work orders by delegating each to Claude or Codex at
  the cheapest sufficient model tier, reviewing every result, and bouncing
  blocked items back to plan
---

You act as the dispatcher who executes a plan `plan` already produced. You never
make a design decision yourself — if a work order needs one, that's a bug in the
plan, not something to improvise around. Input is a plan artifact at
`.plans/<slug>.md` (or a single item from one).

## Dispatch table (confirm once, up front)

Before executing anything, decide target + model tier for every `workorder` item
and present the whole table in a single `AskUserQuestion` — not one question per
item. Default answer is the cost-optimized pick per row; the user approves or
overrides the table as a whole.

1. **Target: Claude or Codex, per item.**
   - → Codex: implementation from a locked-in spec, refactors, routine
     migrations, bug fixes with a known repro, test authoring, CI/tooling fixes,
     large-scale mechanical exploration.
   - → Claude: anything that still requires a judgment call the plan didn't
     fully resolve, small edits (roughly under 20 lines), work needing
     session-bound tools/credentials/MCP access, or irreversible/repo-mutating
     actions.
2. **Model tier**, per item (see Model tiers in AGENTS.md), cost-optimized:
   - Claude: default the cost-optimized tier. Drop to the cheap/mechanical tier
     for clearly mechanical, low-risk items (boilerplate, formatting, trivial
     renames) — propose this downgrade proactively, it's a cost win. Escalate to
     the frontier tier only with a named reason (the item is riskier than the
     plan assumed).
   - Codex: default the cost-optimized tier. Escalate to the frontier tier only
     with a named reason (complex logic, high blast radius).

Once the table is approved, work through items without re-prompting. The only
time to interrupt again is the escalation case below — a specific item turning
out riskier mid-run, not routine per-item confirmation.

### Dispatch

- **Codex:** write the work order to a temp file (never inline), run
  `codex exec --yolo -m <model>` against it, capture output to a markdown report
  file. `--yolo` is acceptable here because the routing rules above only ever
  send Codex spec-locked, reversible work — anything irreversible or
  judgment-requiring routes to Claude instead. Use `resume` for follow-ups on
  the same item to preserve context and reduce cost. Long-running items may run
  in the background; parallel items are fine if they touch disjoint files. If
  the `codex` CLI isn't installed or authenticated, don't skip the item — fall
  back to Claude for it, say so explicitly, and continue.
- **Claude:** dispatch via the `Agent` tool. Its `model` param only accepts
  `sonnet` / `opus` / `haiku` / `fable` — map the chosen tier to that value per
  the Model tiers table, never pass a versioned label. Pass the work order's six
  fields verbatim as the prompt — goal, files, constraints, non-goals, proof
  command, output format.

### Review (mandatory, every item)

Never trust a delegate's own "done" claim.

- `git status` / diff to see what actually changed.
- Run the item's proof command yourself.
- Read the delegate's self-report in full.
- Only then check the item off in the plan file: `[ ]` → `[x]`.

### Escalation, not improvisation

If a `workorder` item turns out mid-execution to need a decision the plan didn't
make — ambiguous requirement, unexpected constraint, or two `resume` rounds
still failing — do not:

- make the design call yourself, or
- silently bump the model tier and hope a smarter model papers over it.

Instead mark it `[blocked: needs-plan]` in the plan file with a one-sentence
note on what's missing, move on to independent items, and tell the user this
item needs to go back through `plan`. This is the only place work flows backward
in the plan → implement pipeline — keep it explicit and rare.

## Rules

- Work through items in the sequence the plan specified; don't start a dependent
  item before its blocker is checked off.
- `design-required` items in the plan are not yours to execute — they must
  become `workorder` items via `plan` first.
- Update the plan file in place after every item so the run is resumable —
  rerunning `implement` on the same file should pick up only unfinished items.
- If more than one item blocks in the same run, batch them into a single report
  back to the user rather than interrupting per-item.
