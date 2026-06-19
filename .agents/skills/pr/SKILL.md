---
name: pr
description:
  Create or update a PR for the current branch based on actual changes. Uses
  av for PR management, and git/sem/codegraph for change analysis.
---

You MUST act as an experienced engineer preparing a pull request for review.
Your job is to describe the change clearly enough that a reviewer can evaluate
risk without re-discovering the whole diff. Use create-or-update behavior:
update the existing PR for the branch, or create one if none exists.

## Gathering context

Before writing anything, understand what actually changed:

- Use `git log`, `git diff`, and `git show` for commit history and line-level
  diffs.
- Use `sem_diff`, `sem_blame`, and `sem_log` for entity-level understanding —
  what functions changed, who owns them, and why they existed.
- Use `codegraph_impact` or `codegraph_explore` to identify blast radius and
  callers affected by the change.
- Prefer semantic tools over raw diffs when the goal is understanding intent,
  not counting lines.

## Process

1. Gather context using git, sem, and codegraph before writing.
2. Check for a PR description template. Use the first applicable template from
   `.github/pull_request_template.md`, `.github/PULL_REQUEST_TEMPLATE.md`,
   `.github/PULL_REQUEST_TEMPLATE/*.md`, `docs/pull_request_template.md`, or
   `pull_request_template.md`. Preserve headings and required prompts; fill
   irrelevant optional sections with `N/A` or remove them only when the
   template clearly allows it.
3. Separate why the change exists from what code changed.
4. Call out behavior changes, migrations, compatibility concerns, and user
   impact.
5. Include only verification that was actually run.
6. Point reviewers at the riskiest files, flows, or decisions.
7. If the user asks for text only, produce the proposed PR description and stop.
8. Otherwise, apply the description with the create-or-update workflow below.

## Create-or-update workflow

1. Determine whether a PR already exists for the current branch using
   `av pr list` or `gh pr view --json number,title,body,url`.
2. If a PR exists, compare its current body with the expected body after
   trimming trailing whitespace. If it already matches, report that no update
   was needed. If it differs, update it with `gh pr edit --body-file <file>`.
3. If no PR exists, create one with `av pr create --title "<title>" --body -`
   and pass the body on stdin. Do not rely on the interactive editor.
4. If `av pr create` fails, fall back to
   `gh pr create --title "<title>" --body-file <file>`. Report the `av`
   failure briefly and include the PR URL from the successful fallback.
5. After creating or updating, read the PR back and confirm the body matches
   the expected description. If it does not match, fix it or report the
   mismatch.
6. Do not use `--force` flags unless the user explicitly asks.

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

Omit `Review focus` only when the change is trivial. If no tests were run,
write `Not run: <reason>`.

## Writing rules

- Be concise. A normal PR description should fit on one screen.
- Do not restate every file touched.
- Do not paste raw diffs.
- Do not claim tests, screenshots, migrations, or validation that did not happen.
- Avoid vague bullets like "misc fixes" or "cleanup".
- Use past tense for what changed and present tense for current behavior.
- Include issue links only when provided or discoverable from branch names,
  commits, or the prompt.

## What to produce

When asked to prepare, create, or update a PR: produce the final description,
apply it with the create-or-update workflow, and report whether the PR was
created, updated, or already current. Include the PR URL when available.

When asked only to draft text: produce the proposed description without
creating or updating a PR.

Do not judge whether the PR is atomic; PRs may contain multiple atomic
commits. Use the `git-commit` skill for commit-level atomicity checks.
