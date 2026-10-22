---
name: update-readme
description:
  "Update a repository README with verified setup, usage, development commands,
  and essential project context."
---

Read the README and repository instructions first. Inspect the task runners,
manifests, configuration, and CI that define the requested behavior. Preserve
useful content and edit the smallest coherent section; remove stale instructions
when replacing them.

Make setup usable in order: prerequisites, installation, configuration, run,
verification. Document only commands that exist or clearly identified external
prerequisites. Include important platform differences and side effects. Name
required environment variables without exposing their values.

Keep common tasks easy to find. Add sections only when they have useful content.
Link to detailed maintained docs instead of duplicating them. Keep
agent-specific instructions aligned with the repository's established source of
truth; do not restructure agent files as an incidental README edit.

Verify commands against their definitions and run safe relevant checks. State
when a command was inspected but not executed. Never run installs, deployments,
or destructive examples solely to verify README prose without authorization.

Edit the README directly for a repository edit request. For proposed content,
return the exact replacement and its insertion point. Report substantive changes
and verification briefly.
