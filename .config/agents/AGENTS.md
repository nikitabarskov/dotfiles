# Global Agent Instructions

## Principles

- **Be pragmatic.** Ship the simplest thing that solves the problem correctly
  and is easy to delete or change later.
- **Prefer clarity over cleverness.** Code is read far more often than written.
- **Minimize surface area.** Fewer abstractions, files, dependencies. Add
  indirection only when it demonstrably reduces complexity.
- **Don't over-engineer.** No config options, extension points, or
  generalization that isn't needed today. YAGNI.
- **Prefer deleting code to adding it.** When fixing a problem, first consider
  whether removing code solves it.

## Code Quality

- Write code that is easy to test, not code that merely has tests.
- Prefer pure functions and immutable data where it doesn't fight the language.
- Name things clearly; don't abbreviate unless universally understood.
- Keep functions short and single-purpose. If a function needs a comment to
  explain what it does, rename or split it.
- Error handling is not optional. Fail fast and loudly with actionable messages.
- Avoid magic numbers and strings; use named constants.

## Structure

- Flat beats nested. Avoid deep directory hierarchies.
- Co-locate things that change together. Split by feature, not by type
  (`controllers/`, `models/`).
- One file per concept.
- Configuration belongs in config files, not in code.

## NOTES.md

Any repo may have a `NOTES.md` in its root — a personal scratch file for
context, TODOs, and prior agent output. It is globally gitignored, so it never
appears in `git status` or a listing of tracked files. Check for it directly at
the start of a task (just try reading it) and read it before starting work.

## When Proposing Changes

- Show the minimal diff. Don't refactor unrelated code while fixing a bug.
- If multiple approaches exist, state the trade-offs and recommend one. Don't
  ask the user to choose when you have a clear preference.
- If a request is ambiguous, make a reasonable assumption and state it — don't
  ask clarifying questions for minor decisions.
- Verify the change works before declaring it done (tests, lint, build).

## Communication

- Be direct and concise. No preamble, no praise, no filler.
- State what you did and why, not a step-by-step narration of how.
- If something is wrong or a bad idea, say so plainly.
- Use code blocks for all code, commands, and file paths.

## Model tiers

Skills that dispatch or escalate work (`plan`, `roadmap`, `implement`) refer to
tiers, not model names, so a model bump means editing this table once.

| Tier                   | Claude (`Agent` `model` param)         | Codex         |
| ---------------------- | -------------------------------------- | ------------- |
| Cheap/mechanical       | Haiku 4.5 (`haiku`)                    | gpt-5.6-luna  |
| Cost-optimized default | Sonnet 5 (`sonnet`)                    | gpt-5.6-terra |
| Frontier/escalated     | Opus 4.8 (`opus`) or Fable 5 (`fable`) | gpt-5.5-sol   |

Never escalate off the cost-optimized default without a named, concrete reason
(architectural risk, ambiguity, blast radius) — see each skill's escalation
rules.

## Suggested skill tiers

Inline skills (invoked via `Skill`, not dispatched through `Agent`) have no
confirmation gate. Before invoking a Group B skill, compare the session model
against the tiers above; if it's below frontier and the task looks high-stakes
by that skill's own criteria (auth boundary, data model/migration, public API,
security-sensitive code), say so in one line. Non-blocking, once per invocation.

- **Group A — cost-optimized tier is sufficient:** `git-commit`, `pr`,
  `update-readme`, `write-docs`, `create-skill`, `create-system-prompt`,
  `edit-article`, `headroom-check`. Bounded input, low ambiguity — no check.
- **Group B — judgment-heavy:** every `review-*` skill plus `design-doc`.
  Default to cost-optimized; flag when the change looks high-stakes.

## Code intelligence: prefer graph tools over grep/read

Several MCP servers expose pre-built code graphs. For any **structural**
question — what calls what, what would break, where X is defined, what X's
signature is — query a graph instead of running a grep/read loop. Each server
documents its own tool table at runtime; the routing is:

| Need                                               | Server                                                     |
| -------------------------------------------------- | ---------------------------------------------------------- |
| Symbols, call paths, blast radius, focused context | `codegraph_*` — first choice when `.codegraph/` exists     |
| Same, plus entity-level git history and ownership  | `sem_*` (`sem_blame`, `sem_log`, `sem_diff`, `sem_impact`) |
| PR review and change-risk triage                   | `inspect_*` — start with `inspect_triage`                  |
| File find / content grep in a git-indexed tree     | `fff` (`fffind`, `ffgrep`, `fff-multi-grep`)               |

Rules:

- **Answer directly — don't delegate exploration.** The graph IS the pre-built
  index. Spawning a file-reading sub-agent, or grepping then reading, repeats
  work already done and costs more for the same answer. Two or three calls
  should answer "how does X work".
- **Trust the results.** They come from a full AST parse. Don't re-verify with
  grep — slower, less accurate, wastes context.
- **Batch, don't loop.** One multi-symbol call (`codegraph_explore`,
  `sem_context`) beats N single-symbol calls.
- **Use grep/read only for literal text** (string contents, comments, log
  messages), non-code files, or a file you're about to edit.
- **Watch for index lag.** When a response opens with a staleness banner, Read
  the listed files directly; everything else is authoritative.
- **If a graph isn't initialized,** the server says so. Offer to build it (e.g.
  `codegraph init -i`).
- **If a question can't be answered natively,** query the store directly —
  e.g. `.tokensave/tokensave.db` (`nodes`, `edges`, `files`) via SQL. If a tool
  or extractor gap caused it, suggest the user file an issue upstream, and
  remind them to strip proprietary code from the report.

## Headroom (`headroom_*`)

Three layers of token compression:

1. **RTK** — filters shell output before it enters context (60–99%).
2. **Headroom proxy** — compresses API responses at the HTTP level
   (`headroom proxy --port 8787`); set up once, transparent thereafter.
3. **Headroom MCP** — explicit compression for large content that bypassed the
   other two (file reads, MCP results).

Start sessions through the shell wrappers when token savings matter: `claudeh`
for Claude Code, `codexh` for Codex. They run `headroom wrap` — proxy, retrieve
tool, and the `agent-90` profile — without pointing every shell at a proxy that
may not be running. **Nested handoffs go through the wrapper too:** when
shelling out to the sibling CLI, call `codexh`/`claudeh`, never bare
`codex`/`claude`. Both are defined in `.config/shell/agent-env.sh` and exist in
non-interactive shells, so there's no reason to use the bare binary.

MCP tools: `headroom_compress` (large result already in context),
`headroom_retrieve` (recover full detail by hash), `headroom_stats`.

Rules:

- **Compress before reasoning**, not after you've processed the content.
- **Headroom is lossless** — the original is retrievable by hash.
- **RTK first, MCP second.** RTK stops output at the source; MCP handles what's
  already in context.
- **Keep conversations short.** Cache-write cost grows with length and long
  sessions destabilize the prefix. Compact or start fresh between unrelated
  tasks.
- **Don't let stale reads sit uncompressed.** Read/Glob output is excluded from
  automatic compression, so it accumulates. Prefer graph lookups over re-reading
  files, and compress large results you're done with.
- **Publish eligible TOIN patterns.** When `headroom perf` flags patterns with
  enough samples, run
  `python -m headroom.cli.toin_publish --min-observations <n>` (matching the
  threshold it reports) to raise the retrieval hit rate.

<!-- headroom:rtk-instructions -->

# RTK (Rust Token Killer) - Token-Optimized Commands

When running shell commands, **always prefix with `rtk`**. This reduces context
usage by 60-90% with zero behavior change. If rtk has no filter for a command,
it passes through unchanged — so it is always safe to use.

## Key Commands

```bash
# Git (59-80% savings)
rtk git status          rtk git diff            rtk git log

# Files & Search (60-75% savings)
rtk ls <path>           rtk read <file>         rtk grep <pattern>
rtk find <pattern>      rtk diff <file>

# Test (90-99% savings) — shows failures only
rtk pytest tests/       rtk cargo test          rtk test <cmd>

# Build & Lint (80-90% savings) — shows errors only
rtk tsc                 rtk lint                rtk cargo build
rtk prettier --check    rtk mypy                rtk ruff check

# Analysis (70-90% savings)
rtk err <cmd>           rtk log <file>          rtk json <file>
rtk summary <cmd>       rtk deps                rtk env

# GitHub (26-87% savings)
rtk gh pr view <n>      rtk gh run list         rtk gh issue list

# Infrastructure (85% savings)
rtk docker ps           rtk kubectl get         rtk docker logs <c>

# Package managers (70-90% savings)
rtk pip list            rtk pnpm install        rtk npm run <script>
```

## Rules

- In command chains, prefix each segment:
  `rtk git add . && rtk git commit -m "msg"`
- For debugging, use raw command without rtk prefix
- `rtk proxy <cmd>` runs command without filtering but tracks usage
<!-- /headroom:rtk-instructions -->
