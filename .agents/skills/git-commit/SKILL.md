---
name: git-commit
description:
  "Draft an atomic Git commit message or make a requested commit from the actual
  staged changes."
---

Use a provided diff, otherwise inspect the staged diff first:

```bash
git --no-pager diff --no-ext-diff --cached -- .
```

If empty, inspect the working diff. Inspect relevant status or context when
needed to distinguish user changes and untracked files. If there is no change,
say so. Do not claim tests pass based on a diff alone.

Check atomicity before composing: one logical change with a coherent result. If
unrelated changes are mixed, recommend a concrete split. Stage only changes
within the authorized commit scope; never sweep in unrelated work or alter the
user's staging silently. Ask when ownership or desired grouping is consequential
and cannot be inferred.

Use an imperative subject up to 72 characters, without conventional-commit
prefixes or co-author trailers. Do not pad short subjects. Add a body only when
the motivation or tradeoff needs explanation; wrap body lines at 72 characters.

For a message-only request, return the message; write a draft file if requested.
For a commit request, write COMMIT_MSG.md at the repository root, report the
draft, and use it with git commit -F. A direct commit request authorizes
committing; do not add a second approval gate unless the user requested draft
review or a new material risk requires a decision. Re-read the draft after user
edits.

Before committing, check the staged diff still matches the intended scope and
run the applicable required checks. Preserve hooks and signing; report failures
instead of bypassing them. Verify the resulting commit and remove only the draft
created for this operation after success. Never assume a draft is gitignored:
keep it out of staging and preserve pre-existing user content.
