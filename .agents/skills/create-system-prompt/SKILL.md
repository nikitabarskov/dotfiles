---
name: create-system-prompt
description:
  "Write or improve a system prompt for a defined task, operating context, and
  output contract."
---

Produce a ready-to-use prompt matched to the task and deployment environment.
Determine the objective, available inputs/tools, authority boundaries, and what
a correct result looks like. Infer routine details; ask only about missing facts
that change the task or its safety.

Keep instructions that a capable model needs: domain constraints, priorities,
uncertainty handling, allowed actions, and concrete output requirements. State
how to handle insufficient evidence, tool failures, and untrusted source content
when relevant. Do not ask the model to treat retrieved text as instructions.

Prefer clear goals over role-play, threats, repeated MUSTs, or exhaustive
scripts. Use examples only to disambiguate difficult cases. Do not request
hidden reasoning; ask for conclusions and supporting evidence. Avoid promises a
prompt cannot enforce, such as guaranteed accuracy or tool permissions it does
not have.

Return the prompt in a fenced block, followed by its key assumptions and a brief
explanation of any consequential design choice. If asked to improve an existing
prompt, preserve its useful contract and explain material changes. For complex
prompts, include a few representative success/failure cases the user can test;
distinguish proposed tests from observed results.
