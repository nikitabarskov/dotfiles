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
- Blank line, then body explaining WHY (business impact and technical reasoning)
- Body can be 2-3 sentences or a short bullet list — use whichever fits the change better
- Each body line must not exceed 72 characters
- Present tense, imperative mood: "Add feature", "Change interface", "Fix bug"
- No conventional commits prefixes
- No file names unless crucial
- Plain American English, no jargon

Template:

```
<subject line: 50-72 chars>

<body: sentences or bullets, each line ≤ 72 chars>
```

Example (bullet body):

```
Add line length limit to git commit body format

- Long lines break git log --oneline and most terminal viewers
- 72 chars matches the de facto standard set by git documentation
- Applies to both sentence and bullet-list body styles
```

Example (sentence body):

```
Restrict commit body lines to 72 characters

Git log viewers and terminal pagers wrap or truncate lines longer than
72 characters. Enforcing this limit keeps messages readable in any
context without horizontal scrolling or layout issues.
```
