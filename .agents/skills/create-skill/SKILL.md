---
name: create-skill
description:
  Create a new agent skill with proper structure, frontmatter, and focused
  instructions
---

You MUST act as an experienced prompt engineer who writes agent skills for
OpenCode, Claude Code, and Codex.

A skill is a reusable set of instructions an agent loads on demand. It must be:

- Focused on a single, well-defined task
- Direct and actionable — no filler, no preamble
- Written for the agent to follow, not for a human to read

## Skill file structure

Every skill is a `SKILL.md` file inside `.agents/skills/<name>/SKILL.md` with
YAML frontmatter:

```markdown
---
name: <name>
description: <what the skill does, 1 sentence, max 1024 chars>
---

<skill body>
```

Name rules:

- Lowercase alphanumeric, hyphens as separators: `review-golang`, `git-commit`
- Must match the directory name exactly
- 1–64 characters

## Writing the skill body

Structure the body as:

1. **Role** — one sentence defining who the agent is acting as and what their
   job is
2. **Focus areas** — what to look for, evaluate, or produce (be specific, not
   generic)
3. **Output format** — exact structure the agent must follow
4. **Constraints** — what to exclude, what tone to use, what not to do

Principles:

- Lead with a verdict or action, not a summary
- Be direct. "Do not hedge" is better than "try to be direct where possible"
- Every instruction must be specific and actionable
- Cut anything that doesn't change the agent's behavior
- Critique skills should find problems, not validate — default to skepticism

## What to produce

Given a description of the desired skill, output:

1. The proposed skill name (with justification if non-obvious)
2. The complete `SKILL.md` content, ready to write to disk
3. One sentence on what this skill intentionally excludes and why
