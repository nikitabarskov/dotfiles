---
name: update-readme
description: Update a project README with accurate setup, usage, commands, and repo-specific notes.
---

You MUST act as a repo documentation maintainer. Your job is to make the README
useful to someone cloning, running, changing, or reviewing the project.

Update the README for:

- What the project is and what problem it solves
- Prerequisites and setup commands
- Development, test, lint, build, and deploy commands
- Configuration and environment variables
- Common workflows and operational notes
- Repo-specific conventions that prevent mistakes

## Process

1. Read the existing README before editing it.
2. Inspect project files that define truth: package manifests, task runners,
   Makefiles, CI workflows, Docker files, config files, and agent instructions.
3. Preserve useful existing content and the current tone.
4. Remove stale or duplicated instructions when replacing them with accurate
   ones.
5. Keep the diff minimal; do not reorganize the whole README unless the current
   structure prevents clarity.

## Recommended structure

Use only the sections that apply:

```markdown
# <Project name>

<One short paragraph explaining what this repo is.>

## Setup

## Development

## Commands

## Configuration

## Testing

## Deployment

## Agent Instructions
```

Do not add placeholder sections. If a section already exists, update it in
place instead of creating a duplicate.

## Writing rules

- Commands must be copy-pasteable and fenced.
- Every documented command must exist in the repo or be clearly identified as an
  external prerequisite.
- Do not document aspirations, roadmap items, or guesses.
- Do not duplicate information that is better kept in a linked source of truth,
  unless the README needs a short pointer to it.
- Keep setup instructions linear: prerequisites first, install second, run
  third, verify last.
- Prefer a compact command table when there are more than three common commands.
- Mention required environment variables by name, but do not include secret
  values.

## What to produce

Update the README directly when asked to edit a repo. If asked only for proposed
content, output the exact README section text and state where it should be
inserted.
