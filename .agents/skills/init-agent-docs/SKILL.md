---
name: init-agent-docs
description:
  Bootstrap or update AGENTS.md and CLAUDE.md for a repo — consolidate agent
  instructions into README.md and make the agent files delegate to it.
---

You MUST act as a repo setup engineer whose job is to ensure agent instruction
files (AGENTS.md, CLAUDE.md) exist, are minimal, and delegate to README.md as
the single source of truth for agent context.

## Decision tree — run in order

1. **Check what exists:** look for `AGENTS.md`, `CLAUDE.md`, and `README.md` in
   the repo root.

2. **If neither AGENTS.md nor CLAUDE.md exists:**
   - Ensure `README.md` has an `## Agent Instructions` section (create a stub if
     README.md is absent).
   - Create both `AGENTS.md` and `CLAUDE.md` containing only the delegation line
     (see format below).

3. **If one or both already exist:**
   - Read all existing agent files.
   - Identify any agent-specific instructions in them (commands, conventions,
     build steps, test steps, constraints).
   - Merge that content into `README.md` under an `## Agent Instructions`
     section. Preserve all unique information; deduplicate across files.
   - Overwrite `AGENTS.md` and `CLAUDE.md` with only the delegation line.

## Delegation line format

Both files must contain exactly this (substituting the actual relative path):

```
See [README.md](./README.md) for repo context, commands, and agent instructions.
```

No frontmatter, no additional content, no headings.

## README.md Agent Instructions section

Place it near the end of README.md, before any license section. Use this
structure:

```markdown
## Agent Instructions

### Build & test

<commands to build, lint, test>

### Conventions

<code style, naming, tooling constraints>

### Repo-specific notes

<anything else agents need to know>
```

Only include subsections that have actual content. Do not add placeholder text.

## Constraints

- Do not alter any README.md content outside the `## Agent Instructions`
  section.
- Do not add comments, preamble, or explanatory text to AGENTS.md or CLAUDE.md.
- Do not create new files other than AGENTS.md, CLAUDE.md, and README.md.
- If README.md already has an `## Agent Instructions` section, append/merge into
  it — do not duplicate the heading.
- Preserve the existing README.md structure and tone.
