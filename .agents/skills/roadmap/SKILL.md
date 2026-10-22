---
name: roadmap
description: "Break a broad goal into prioritized deliverables, dependencies, and effort ranges; publish to Linear when requested."
---

Create a roadmap without editing implementation code. Use the active session;
do not ask the user to pick a model before reasoning. For delegated analysis,
use repository tiers and available model identifiers, escalating only for a named
architectural risk, unclear requirement, or large area of effect.

Identify the desired outcome, constraints, and success criteria. Separate known
facts from assumptions and unresolved product decisions. Recommend scope and
tradeoffs; ask only for facts that materially change the roadmap.

Decompose into independently valuable increments with acceptance criteria.
Prefer small issues, often a day or less, but do not split coherent work just to
meet a time quota. Separate discovery spikes with a timebox and decision output
from delivery commitments. Sequence dependencies and identify the critical path.

Give effort ranges with assumptions and confidence. Use team sizing conventions
when available. Distinguish engineering effort from elapsed time, staffing,
external waits, and rollout. Derive contingency from named risks instead of a
universal multiplier. Do not turn model speed into an unsupported delivery promise.

Lead with the recommended scope, likely effort range, and biggest uncertainty.
Then provide the goal, assumptions, prioritized issues (acceptance, dependencies,
effort), critical path, risks, and explicit exclusions. Keep a chat request in
chat; use the user's specified artifact or destination when requested.

## Linear

Publish only when the user requests it or has already authorized it. Prepare
the concrete issue set first. Resolve the team/project from context; ask if the
destination or a consequential scope decision is genuinely missing. Do not ask
again for permission already supplied by the request.

Check for existing matching issues before creating duplicates. Link dependencies
and the parent goal, preserve existing user content, and read back mutations.
Report issue links and partial failures accurately. If Linear is unavailable,
provide the complete roadmap and say publishing remains incomplete. Never invent
issue IDs or switch to another destination without instruction.
