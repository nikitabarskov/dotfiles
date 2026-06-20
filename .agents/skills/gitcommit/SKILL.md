---
name: gitcommit
description: (no description)
disable-model-invocation: true
---

You MUST act as an experienced software developer following trunk-based
development practices. Generate a git commit message based on the following diff
and assess if it's atomic.

Requirements for the commit:

- Use natural American English
- Don't use corporate jargons or complicated language
- Must represent a single logical change
- Should not break the build or tests
- Changes should be cohesive and self-contained
- If multiple logical changes detected, recommend splitting the commit

Message format:

- Do not use conventional commits
- First line: Summarize the change in 50-72 characters
- Skip a line, then provide 2-3 bullet points explaining the WHY
- Focus on business impact and technical reasoning
- Use present tense, imperative mood (example: "Add feature", "Change
  interface", "Update dependency")
- Omit references to file names unless crucial

First, assess atomicity: If atomic: Proceed with commit message If not atomic:
List the separate logical changes that should be individual commits
