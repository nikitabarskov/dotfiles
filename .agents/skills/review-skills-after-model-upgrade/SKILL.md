---
name: review-skills-after-model-upgrade
description:
  Review agent skills when switching model versions. Test whether existing
  instructions still help, and revise skills when the results justify a change.
---

Treat the upgrade as a reason to rerun skill evaluations. Keeping a skill
unchanged is a valid result.

## Select what to test

- Identify the target model and the skills it will actually run. Record the
  previous model if known. For a shared skill, include other supported models in
  the compatibility check when an edit could affect them.
- Start with skills that have reported failures, rely on old model workarounds,
  or govern consequential tool actions. Use relevant provider migration notes to
  form testable hypotheses. A release announcement alone is insufficient
  evidence for an edit.
- Read each selected skill and the resources it delegates to. Distinguish model
  coaching from user preferences, output contracts, tool prerequisites, and
  permission boundaries. Carry those requirements into the evaluation.

## Compare behavior

1. Start with existing evaluations or a representative past request. Define what
   counts as success before running it, including observable output, tool
   actions, and any required stopping point. Add a case that exercises the
   suspected weakness. For a routing change, include a similar request that
   should select a different skill or none.
2. Run the existing skill on the target model in a clean context and an isolated
   workspace. Use fixtures or a recording tool for external side effects. If the
   previous model is available, run the same case there to distinguish a
   regression from an existing defect. Historical runs can supply a baseline
   when their inputs and settings are known.
3. Change one suspected instruction at a time. For a possible obsolete
   workaround, try removing it. Run the candidate in a separate clean context on
   the target model with the same inputs, tools, permissions, and settings. Test
   routing with normal skill discovery and without naming the skill. Repeat
   ambiguous results before drawing a conclusion.

## Decide and deliver

Keep the smallest revision that fixes an observed failure or preserves required
behavior with simpler instructions. Recheck the original success case and any
affected permission or compatibility case. If results are inconclusive, retain
the existing wording and record what would resolve the question.

For an audit request, report proposed edits. Apply supported edits when revision
is in scope. Report the models and skills covered, what happened with the
existing and candidate instructions, the resulting decision, and any untested
scope. If the target model cannot be run, provide the cases and expected
outcomes and mark the review unverified.
