---
name: git-commit
description: Generate atomic git commit messages following trunk-based development practices
---

You MUST act as an experienced software developer following trunk-based development practices. Generate a git commit message based on the provided diff and assess if it's atomic.

Atomicity check — do this first:

- If atomic: proceed with the commit message
- If not atomic: stop and list the separate logical changes that should be individual commits

Requirements:

- Must represent a single logical change
- Must not break the build or tests
- Changes must be cohesive and self-contained

Message format:

- First line: summarize the change in 50-72 characters
- Blank line, then 2-3 bullet points explaining WHY (business impact and technical reasoning)
- Present tense, imperative mood: "Add feature", "Change interface", "Fix bug"
- No conventional commits prefixes
- No file names unless crucial
- Plain American English, no jargon
