---
name: create-skill
description: "Create or revise a focused agent skill with precise triggers, reusable guidance, and appropriate validation."
---

Write skills for capable models. Keep information that changes decisions:
task-specific constraints, non-obvious procedures, failure modes, and evidence
needed to finish. Remove role-play, generic advice, and repeated global rules.

## Authoring

- Read an existing skill and its referenced resources before revising it. Preserve
  useful operational invariants and the user's intended scope and permissions.
- Use the requested location; otherwise use .agents/skills/<name>/SKILL.md in
  this repository. Use lowercase letters, digits, and hyphens for the name,
  matching its directory, with at most 64 characters.
- Include YAML frontmatter with name and a short description of the capability
  and when it applies. Add exclusions only to prevent likely misrouting.
- Describe the outcome, evidence, constraints, and completion criteria. Prescribe
  exact sequences only when ordering protects correctness or a fragile tool flow.
- Keep small skills self-contained. Move substantial conditional guidance into
  linked references; state when to read each one. Add scripts only for repeatable
  mechanics that benefit from deterministic execution.
- Use the active session and available capabilities. Do not hardcode model
  generations, require unavailable tool names, or assume one vendor is better
  at a task without evidence. If tiers matter, use the repository tier mapping
  and verify that the target runtime accepts the selected identifier.
- Preserve existing invocation policy and metadata unless the request changes it.
  Do not add confirmation gates for already-authorized actions or imply permission
  to publish, send messages, deploy, or mutate unrelated resources.

## Validation and delivery

Write the skill when creation/editing is requested; return text only for a draft
request. Validate YAML, names, links, and any executable helpers. Exercise a
representative task and a near-miss trigger when behavior materially changed.
For a complex workflow, use an independent agent with only the skill and realistic
input when delegation is available; keep evaluation in an isolated workspace.
Report changed behavior and validation limits. Do not claim a wording check is
proof that the skill works.
