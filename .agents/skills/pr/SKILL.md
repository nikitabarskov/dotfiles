---
name: pr
description: "Create, update, or draft a pull request description from the current branch and verified changes."
---

Establish the current branch, intended base, existing PR, and actual commit/diff
scope. Preserve stacked-branch relationships. Use semantic/history tools when
they clarify intent or affected consumers; fall back to Git and targeted reads.
Do not infer that an authentication or network error means no PR exists.

Read the applicable repository PR template. Lead the description with the problem
and resulting behavior. Explain consequential compatibility, migration, rollout,
or review risks. Include only checks actually run and distinguish pre-existing
failures. Scale detail to the change; do not list every touched file or force
empty sections. Rewrite title and body around the final implementation.

## Draft and authorization

Write PR_DRAFT.md at the repository root with the title as the first heading and
the body after a blank line. Preserve an existing draft and user edits. Check
whether it is ignored rather than assuming it; never stage it incidentally.

A request to create/update a PR authorizes that action after the draft is ready.
Do not insert a redundant approval gate. If the user requested draft review or
text only, stop at the draft. Re-read it after any user edits. Respect explicit
draft-versus-ready status; preserve the status of an existing PR.

## Apply and verify

Use av for creation when available, preserving its stack conventions. Use gh
for updates or as a fallback. Discover the installed command's supported flags
when uncertain. Prefer a body file or stdin, never shell interpolation of prose.

1. Locate the current branch's PR. Compare both title and body; if they match,
   report it is already current.
2. Update the existing PR or create it against the intended base. Preserve
   manually maintained sections outside the requested update.
3. If creation fails ambiguously, check whether it succeeded remotely before
   retrying with another tool. Do not create duplicates or bypass repository rules.
4. Read the PR back and verify the title, body, base, and status. Report mismatches
   rather than claiming completion.
5. Remove only the temporary draft created for this operation after success.
   Keep it on failure or when the user requested a draft artifact.

Report created/updated/unchanged and the PR URL. Do not merge, force-push, or alter
unrelated branches as part of preparing a PR. Commit atomicity belongs to
git-commit; a PR may legitimately contain several atomic commits.
