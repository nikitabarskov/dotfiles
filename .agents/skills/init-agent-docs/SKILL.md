---
name: init-agent-docs
description:
  "Consolidate root agent instructions into README.md and create minimal
  AGENTS.md and CLAUDE.md pointers."
---

Read root README.md, AGENTS.md, and CLAUDE.md, including any symlink targets.
Check repository conventions and nested instruction files so their scope is not
accidentally widened. Do not rewrite a shared symlink target or move private
instructions into a public README without resolving that scope conflict.

Merge unique root-level setup, verification, conventions, and operational
constraints into README.md under Agent Instructions. Preserve existing meaning;
deduplicate without losing exceptions. If instructions conflict, resolve from
known precedence or ask about the specific unresolved conflict.

Keep unrelated README content intact. Use only subsections with real content,
such as Build and test, Conventions, and Repository notes. If the README is
absent, create a minimal factual introduction and the collected instructions; do
not fabricate commands or create empty placeholders.

After verifying that every unique root instruction has a home, make root
AGENTS.md and CLAUDE.md contain only:

```markdown
See [README.md](./README.md) for repo context, commands, and agent instructions.
```

Do not change nested instructions or unrelated files. Verify the relative links,
the preserved instruction coverage, and the resulting diff. Report any content
that could not safely be consolidated.
