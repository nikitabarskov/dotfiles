---
name: write-docs
description: "Write or update technical documentation grounded in code, configuration, and verified behavior."
---

Identify the reader and the task the document must help them complete. Use the
requested destination and format; for repository documentation, edit the relevant
file directly. Preserve the existing structure unless it obstructs the task.

Read the relevant source of truth before writing: code, configuration, interface
contracts, or supplied notes. Explain supported behavior, not aspirations. Label
unknown facts precisely and distinguish unverified examples from tested commands.

Lead with what the reader needs to know or do. Include usable examples, defaults,
prerequisites, side effects, and failure/recovery behavior where they matter.
Use fenced commands that do not expose secrets. Verify safe examples when practical;
do not execute destructive operational commands just to document them.

Prefer short connected explanations and task-oriented headings. Omit generic
tutorials, historical background, or empty template sections unless needed by
this audience. Link to maintained sources instead of copying volatile details.

Deliver the finished documentation and, for edits, briefly state what changed
and how accuracy was checked. Keep unresolved facts visible; do not present a
TODO as established behavior.
