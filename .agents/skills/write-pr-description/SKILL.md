---
name: write-pr-description
description: Generate concise PR descriptions with context, behavior changes, tests, and review focus.
---

You MUST act as an experienced engineer preparing a pull request for review.
Your job is to describe the change clearly enough that a reviewer can evaluate
risk without re-discovering the whole diff. When the user asks you to prepare a
PR, use create-or-update behavior: update the existing PR for the branch, or
create one if none exists.

Write PR descriptions from:

- Git diffs, commit ranges, or working tree changes
- A summary of implementation work
- Issue descriptions and acceptance criteria
- Test and verification output
- An existing GitHub pull request

## Process

1. Inspect the diff or provided change summary before writing.
2. Check for a PR description template before drafting. Use the first applicable
   template from `.github/pull_request_template.md`,
   `.github/PULL_REQUEST_TEMPLATE.md`, `.github/PULL_REQUEST_TEMPLATE/*.md`,
   `docs/pull_request_template.md`, or `pull_request_template.md`. Preserve the
   template's headings and required prompts; fill irrelevant optional sections
   with `N/A` or remove them only when the template clearly allows it.
3. Separate why the change exists from what code changed.
4. Call out behavior changes, migrations, compatibility concerns, and user
   impact.
5. Include only verification that was actually run.
6. Point reviewers at the riskiest files, flows, or decisions.
7. If the user asks for text only, produce the proposed PR description and stop.
8. Otherwise, apply the description with the create-or-update workflow below.

## Create-or-update workflow

1. Determine whether a PR already exists for the current branch. Prefer
   `gh pr view --json number,title,body,url` for checking the current branch PR.
2. If a PR exists, compare its current body with the expected body after
   trimming trailing whitespace. If it already matches, report that no update was
   needed. If it differs, update it with `gh pr edit --body-file <file>` or the
   available GitHub MCP tool.
3. If no PR exists, create one with `av pr` first. Use
   `av pr --title "<title>" --body -` and pass the body on stdin. Do not rely on
   the interactive editor.
4. If `av pr` fails, create the PR with `gh pr create --title "<title>"
   --body-file <file>`. Report the `av` failure briefly and include the PR URL
   from the successful fallback.
5. After creating or updating, read the PR back and confirm the body matches the
   expected description. If it does not match, fix it or report the mismatch.
6. Do not use `av pr --force` unless the user explicitly asks for it.

## Output format

Use the repository PR template when one exists. If no template exists, use:

```markdown
<A concise summary of what changed.>

<One short paragraph explaining the problem or goal and why the change was made.>

## Testing

- <Command or check that was run>
- <Manual verification, if any>

## Review focus

- <Risky area, contract change, migration, or edge case to inspect>
```

Omit `Review focus` only when the change is trivial. If no tests were run, write
`Not run: <reason>`.

## Writing rules

- Be concise. A normal PR description should fit on one screen.
- Do not restate every file touched.
- Do not paste raw diffs.
- Do not claim tests, screenshots, migrations, or validation that did not
  happen.
- Avoid vague bullets like "misc fixes" or "cleanup".
- Use past tense for what changed and present tense for current behavior.
- Include issue links only when provided or discoverable from branch names,
  commits, or the prompt.

## What to produce

When asked to prepare, create, or update a PR, produce the final description,
apply it to the PR with the create-or-update workflow, and report whether the PR
was created, updated, or already current. Include the PR URL when available.

When asked only to draft text, produce the proposed description without creating
or updating a PR.

Do not judge whether the PR is atomic; PRs may contain multiple atomic commits.
Use the `git-commit` skill for commit-level atomicity checks.
