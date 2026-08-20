## Communication

### Style: BLUF

Write BLUF - bottom line up front. Put the answer in the first sentence. Give
the evidence, the conditions, and the alternatives after it. The reader decides
after the first sentence if they continue to read.

- Start with the conclusion: what is true, what you did, or what to do next.
- Start with the request if you need a decision, an approval, or a fact.
- Start with the bad news if something is broken or wrong. Do not start with the
  parts that operate correctly.

### Content

- Report what you did and why. Do not describe each step.
- Separate facts from assumptions. Tell the user which is which.
- Say plainly when a plan is bad. Name the risk and its cost. Write "this breaks
  X when Y", not "this can have implications".

### Format

- Write short sentences. Give one instruction in one sentence.
- Do not write a preamble, praise, or filler text.
- Put all code, commands, and file paths in code blocks.

## Code

- Write the most simple code that is correct. Keep it easy to change or delete.
- Write clear code, not clever code. Code is read more often than it is written.
- Use few abstractions, files, and dependencies. Add a layer only if it
  decreases the complexity.
- Do not add options, extension points, or generalizations that you do not need
  today.
- To correct a problem, first examine if you can remove code.
- Write code that is easy to test. Tests alone are not sufficient.
- Use pure functions and immutable data if the language permits it.
- Use clear names. Do not abbreviate.
- Give each function one task and keep it short. If a function needs a comment
  to tell what it does, change its name or divide it.
- Handle all errors. Stop immediately, and give a message that tells the user
  what to do.
- Do not use magic numbers or magic strings. Use named constants.

## Structure

- Use a flat directory tree. Do not make deep hierarchies.
- Keep related files together. Divide by feature, not by type (`controllers/`,
  `models/`).
- Put one concept in one file.
- Put configuration in configuration files, not in code.

## Changes

- Make atomic changes. One change does one thing, and the repository operates
  correctly before and after it. If you cannot describe a change in one
  sentence, divide it.
- Make the smallest possible diff. Do not refactor other code when you correct a
  defect.
- If there is more than one method, give the trade-offs and recommend one. Do
  not ask the user to select.
- If a request is not clear, make a reasonable assumption and tell the user the
  assumption. Do not ask questions about small decisions.
- Test the change before you report that it is complete. Use the tests, the
  linter, and the build.

## NOTES.md

A repository can have a `NOTES.md` file in its root. It holds context, TODO
items, and output from earlier agents. The global gitignore file hides it, thus
`git status` and a list of tracked files do not show it. Try to read this file
before you start work.

## Model tiers

The skills `plan`, `roadmap`, and `implement` use tier names, not model names.
Thus a new model needs only one change to this table.

| Tier                   | Claude (`Agent` `model` param)       | Codex         |
| ---------------------- | ------------------------------------ | ------------- |
| Cheap/mechanical       | Haiku 4.5 (`haiku`)                  | gpt-5.6-luna  |
| Cost-optimized default | Sonnet 5 (`sonnet`)                  | gpt-5.6-terra |
| Frontier/escalated     | Opus 5 (`opus`) or Fable 5 (`fable`) | gpt-5.5-sol   |

Do not use a tier above the default without a specified reason: architectural
risk, unclear requirements, or a large area of effect. Each skill gives its own
rules.

## Skill tiers

Skills that you start with `Skill` have no confirmation step. Before you start a
Group B skill, compare the model of the session with the table above. If the
model is below the frontier tier, and the task has high risk by the criteria of
that skill (authentication boundary, data model or migration, public API, or
security), tell the user in one line. Do not stop, and tell the user one time
only.

- **Group A — the default tier is sufficient:** `git-commit`, `pr`,
  `update-readme`, `write-docs`, `create-skill`, `create-system-prompt`,
  `edit-article`, `headroom-check`. These skills have small, clear inputs. Do
  not do the check.
- **Group B — these skills need judgement:** all `review-*` skills and
  `design-doc`. Use the default tier, but tell the user when the change has high
  risk.

## Code graph tools

Use a code graph server for structural questions: what calls what, what breaks,
where a symbol is, and what its signature is. Do not use grep and read for these
questions.

| Need                                             | Server                                                     |
| ------------------------------------------------ | ---------------------------------------------------------- |
| Symbols, call paths, area of effect, context     | `codegraph_*` — the first choice when `.codegraph/` exists |
| The same, plus git history and ownership         | `sem_*` (`sem_blame`, `sem_log`, `sem_diff`, `sem_impact`) |
| PR review and change risk                        | `inspect_*` — start with `inspect_triage`                  |
| File find and content grep in a git-indexed tree | `fff` (`fffind`, `ffgrep`, `fff-multi-grep`)               |

Rules:

- **Answer directly.** The graph is the index. Do not start a sub-agent to read
  files. Two or three calls are sufficient to tell how X operates.
- **Trust the results.** They come from a full parse of the syntax tree. Do not
  check them again with grep.
- **Make one call for many symbols.** Do not make one call for each symbol.
- **Use grep and read only for text** (strings, comments, log messages), for
  files that are not code, and for a file that you will edit.
- **If a result starts with a warning about stale data,** read the listed files
  directly. All other data is correct.
- **If the graph does not exist,** the server tells you. Offer to build it, for
  example with `codegraph init -i`.
- **If no tool can answer the question,** query the database with SQL, for
  example `.tokensave/tokensave.db` (tables `nodes`, `edges`, `files`). If a gap
  in a tool caused this, tell the user to report it upstream. Remind the user to
  remove proprietary code from the report.

## Headroom (`headroom_*`)

Headroom decreases the number of tokens in three layers:

1. **RTK** filters shell output before it enters the context (60–99%).
2. **The Headroom proxy** compresses API responses
   (`headroom proxy --port 8787`). Configure it one time.
3. **The Headroom MCP server** compresses large content that the other two
   layers did not catch (file reads, MCP results).

Start a session with `claudeh` (Claude Code) or `codexh` (Codex) when token
savings are important. These wrappers run `headroom wrap`, which supplies the
proxy, the retrieve tool, and the `agent-90` profile. They are defined in
`.config/shell/agent-env.sh` and are available in non-interactive shells. When
you start the other CLI from a session, use `claudeh` or `codexh`. Do not use
the bare `claude` or `codex` command.

MCP tools: `headroom_compress` (a large result that is already in the context),
`headroom_retrieve` (get the full text by hash), `headroom_stats`.

Rules:

- **Compress content before you reason about it**, not after.
- **Headroom is lossless.** You can get the original by hash.
- **Use RTK first, the MCP server second.** RTK stops the output at its source.
- **Keep sessions short.** The cache-write cost increases with the length.
  Compact the session, or start a new one, between different tasks.
- **Do not keep stale reads.** Read and Glob output is not compressed
  automatically, thus it accumulates. Use the code graph tools instead of a
  second read of a file, and compress large results when you are done with them.
- **Publish TOIN patterns.** When `headroom perf` shows patterns with sufficient
  samples, run `python -m headroom.cli.toin_publish --min-observations <n>` with
  the threshold that it reports.
