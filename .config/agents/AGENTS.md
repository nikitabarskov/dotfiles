# Global Agent Instructions

## Principles

**Be pragmatic.** Prefer working solutions over theoretically perfect ones. Ship the simplest thing that solves the problem correctly and is easy to delete or change later.

**Prefer clarity over cleverness.** Code is read far more often than it is written. Obvious code beats clever code every time.

**Minimize surface area.** Fewer abstractions, fewer files, fewer dependencies. Only add indirection when it demonstrably reduces complexity — not to follow patterns for their own sake.

**Don't over-engineer.** Solve the actual problem at hand. Do not add configuration options, extension points, or generalization that isn't needed today. YAGNI applies.

**Prefer deleting code to adding code.** When fixing a problem, consider whether removing code solves it. Smaller codebases are easier to maintain.

## Code Quality

- Write code that is easy to test, not code that merely has tests.
- Prefer pure functions and immutable data where it doesn't fight the language/framework.
- Name things clearly; don't abbreviate unless the abbreviation is universally understood in context.
- Keep functions short and focused on a single responsibility. If a function needs a comment to explain what it does, rename it or split it.
- Error handling is not optional. Fail fast and loudly with actionable messages.
- Avoid magic numbers and strings; use named constants.

## Structure

- Flat is better than nested. Avoid deep directory hierarchies.
- Co-locate things that change together. Don't split by type (controllers/, models/) when splitting by feature is more natural.
- One file per concept. Don't stuff unrelated things in the same file to save files.
- Configuration belongs in config files, not in code.

## When Proposing Changes

- Show the minimal diff. Don't refactor unrelated code while fixing a bug.
- If multiple approaches exist, briefly state the trade-offs and recommend one. Don't ask the user to choose when you have a clear preference.
- If a request is ambiguous, make a reasonable assumption and state it — don't ask clarifying questions for minor decisions.
- Check that the change actually works before declaring it done (run tests, lint, build as appropriate).

## Communication

- Be direct and concise. No preamble, no praise, no filler.
- State what you did and why, not a step-by-step narration of how.
- If something is wrong or a bad idea, say so plainly.
- Use code blocks for all code, commands, and file paths.

<!-- rtk-instructions v2 -->

# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:

```bash
# Wrong
git add . && git commit -m "msg" && git push

# Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

## RTK Commands by Workflow

### Build & Compile (80-90% savings)

```bash
rtk cargo build         # Cargo build output
rtk cargo check         # Cargo check output
rtk cargo clippy        # Clippy warnings grouped by file (80%)
rtk tsc                 # TypeScript errors grouped by file/code (83%)
rtk lint                # ESLint/Biome violations grouped (84%)
rtk prettier --check    # Files needing format only (70%)
rtk next build          # Next.js build with route metrics (87%)
```

### Test (60-99% savings)

```bash
rtk cargo test          # Cargo test failures only (90%)
rtk go test             # Go test failures only (90%)
rtk jest                # Jest failures only (99.5%)
rtk vitest              # Vitest failures only (99.5%)
rtk playwright test     # Playwright failures only (94%)
rtk pytest              # Python test failures only (90%)
rtk rake test           # Ruby test failures only (90%)
rtk rspec               # RSpec test failures only (60%)
rtk test <cmd>          # Generic test wrapper - failures only
```

### Git (59-80% savings)

```bash
rtk git status          # Compact status
rtk git log             # Compact log (works with all git flags)
rtk git diff            # Compact diff (80%)
rtk git show            # Compact show (80%)
rtk git add             # Ultra-compact confirmations (59%)
rtk git commit          # Ultra-compact confirmations (59%)
rtk git push            # Ultra-compact confirmations
rtk git pull            # Ultra-compact confirmations
rtk git branch          # Compact branch list
rtk git fetch           # Compact fetch
rtk git stash           # Compact stash
rtk git worktree        # Compact worktree
```

Note: Git passthrough works for ALL subcommands, even those not explicitly listed.

### GitHub (26-87% savings)

```bash
rtk gh pr view <num>    # Compact PR view (87%)
rtk gh pr checks        # Compact PR checks (79%)
rtk gh run list         # Compact workflow runs (82%)
rtk gh issue list       # Compact issue list (80%)
rtk gh api              # Compact API responses (26%)
```

### JavaScript/TypeScript Tooling (70-90% savings)

```bash
rtk pnpm list           # Compact dependency tree (70%)
rtk pnpm outdated       # Compact outdated packages (80%)
rtk pnpm install        # Compact install output (90%)
rtk npm run <script>    # Compact npm script output
rtk npx <cmd>           # Compact npx command output
rtk prisma              # Prisma without ASCII art (88%)
```

### Files & Search (60-75% savings)

```bash
rtk ls <path>           # Tree format, compact (65%)
rtk read <file>         # Code reading with filtering (60%)
rtk grep <pattern>      # Search grouped by file (75%). Format flags (-c, -l, -L, -o, -Z) run raw.
rtk find <pattern>      # Find grouped by directory (70%)
```

### Analysis & Debug (70-90% savings)

```bash
rtk err <cmd>           # Filter errors only from any command
rtk log <file>          # Deduplicated logs with counts
rtk json <file>         # JSON structure without values
rtk deps                # Dependency overview
rtk env                 # Environment variables compact
rtk summary <cmd>       # Smart summary of command output
rtk diff                # Ultra-compact diffs
```

### Infrastructure (85% savings)

```bash
rtk docker ps           # Compact container list
rtk docker images       # Compact image list
rtk docker logs <c>     # Deduplicated logs
rtk kubectl get         # Compact resource list
rtk kubectl logs        # Deduplicated pod logs
```

### Network (65-70% savings)

```bash
rtk curl <url>          # Compact HTTP responses (70%)
rtk wget <url>          # Compact download output (65%)
```

### Meta Commands

```bash
rtk gain                # View token savings statistics
rtk gain --history      # View command history with savings
rtk discover            # Analyze Claude Code sessions for missed RTK usage
rtk proxy <cmd>         # Run command without filtering (for debugging)
rtk init                # Add RTK instructions to CLAUDE.md
rtk init --global       # Add RTK to ~/.claude/CLAUDE.md
```

## Token Savings Overview

| Category         | Commands                       | Typical Savings |
| ---------------- | ------------------------------ | --------------- |
| Tests            | vitest, playwright, cargo test | 90-99%          |
| Build            | next, tsc, lint, prettier      | 70-87%          |
| Git              | status, log, diff, add, commit | 59-80%          |
| GitHub           | gh pr, gh run, gh issue        | 26-87%          |
| Package Managers | pnpm, npm, npx                 | 70-90%          |
| Files            | ls, read, grep, find           | 60-75%          |
| Infrastructure   | docker, kubectl                | 85%             |
| Network          | curl, wget                     | 65-70%          |

Overall average: **60-90% token reduction** on common development operations.

<!-- /rtk-instructions -->

<!-- CODEGRAPH_START -->

## CodeGraph

This project has a CodeGraph MCP server (`codegraph_*` tools) configured. CodeGraph is a tree-sitter-parsed knowledge graph of every symbol, edge, and file. Reads are sub-millisecond and return structural information grep cannot.

### When to prefer codegraph over native search

Use codegraph for **structural** questions — what calls what, what would break, where is X defined, what is X's signature. Use native grep/read only for **literal text** queries (string contents, comments, log messages) or after you already have a specific file open.

| Question                                                  | Tool                                                                                 |
| --------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| "Where is X defined?" / "Find symbol named X"             | `codegraph_search`                                                                   |
| "What calls function Y?"                                  | `codegraph_callers`                                                                  |
| "What does Y call?"                                       | `codegraph_callees`                                                                  |
| "How does X reach/become Y? / trace the flow from X to Y" | `codegraph_trace` (one call = the whole path, incl. callback/React/JSX dynamic hops) |
| "What would break if I changed Z?"                        | `codegraph_impact`                                                                   |
| "Show me Y's signature / source / docstring"              | `codegraph_node`                                                                     |
| "Give me focused context for a task/area"                 | `codegraph_context`                                                                  |
| "See several related symbols' source at once"             | `codegraph_explore`                                                                  |
| "What files exist under path/"                            | `codegraph_files`                                                                    |
| "Is the index healthy?"                                   | `codegraph_status`                                                                   |

### Rules of thumb

- **Answer directly — don't delegate exploration.** For "how does X work" / architecture questions, answer with 2-3 codegraph calls: `codegraph_context` first, then ONE `codegraph_explore` for the source of the symbols it surfaces. For a specific **flow** ("how does X reach Y") start with `codegraph_trace` from→to — one call returns the whole path with dynamic hops bridged — then ONE `codegraph_explore` for the bodies; don't rebuild the path with `codegraph_search` + `codegraph_callers`. Codegraph IS the pre-built index, so spawning a separate file-reading sub-task/agent — or running a grep + read loop — repeats work codegraph already did and costs more for the same answer.
- **Trust codegraph results.** They come from a full AST parse. Do NOT re-verify them with grep — that's slower, less accurate, and wastes context.
- **Don't grep first** when looking up a symbol by name. `codegraph_search` is faster and returns kind + location + signature in one call.
- **Don't chain `codegraph_search` + `codegraph_node`** when you just want context — `codegraph_context` is one call.
- **Don't loop `codegraph_node` over many symbols** — one `codegraph_explore` call returns several symbols' source grouped in a single capped call, while each separate node/Read call re-reads the whole context and costs far more.
- **Index lag — check the staleness banner, don't guess a wait.** When a codegraph response starts with "⚠️ Some files referenced below were edited since the last index sync…", the listed files are pending re-index — Read those specific files for accurate content. Files NOT in that banner are fresh and codegraph is authoritative for them. `codegraph_status` also lists pending files under "Pending sync".

### If `.codegraph/` doesn't exist

The MCP server returns "not initialized." Ask the user: _"I notice this project doesn't have CodeGraph initialized. Want me to run `codegraph init -i` to build the index?"_

<!-- CODEGRAPH_END -->

## Semantic Tools (sem\_\*)

Use `sem_*` tools for entity-level code understanding. Prefer them over grep/read loops when the question is about structure, ownership, or history.

| Question                                                      | Tool           |
| ------------------------------------------------------------- | -------------- |
| Who last changed this function and why?                       | `sem_blame`    |
| What does this entity depend on / what depends on it?         | `sem_impact`   |
| How has this function changed over time?                      | `sem_log`      |
| Packed context for a function + its deps in one call          | `sem_context`  |
| What changed between two refs (entity-level, not line-level)? | `sem_diff`     |
| List all functions/classes in a file or directory             | `sem_entities` |

Rules:

- Use `sem_diff` instead of `git diff` when understanding _what_ changed semantically, not just lines.
- Use `sem_blame` before touching a function — know who owns it and why it exists.
- Use `sem_impact` before refactoring — see the blast radius first.
- Use `sem_context` to pack a function + its direct deps into one call instead of chaining reads.

## Inspect Tools (inspect\_\*)

Use `inspect_*` tools for PR review and change risk analysis.

| Question                                             | Tool                  |
| ---------------------------------------------------- | --------------------- |
| What changed and where should I focus review effort? | `inspect_triage`      |
| Which unchanged code might break from these changes? | `inspect_predict`     |
| File-level risk heatmap for a commit/range           | `inspect_risk_map`    |
| Deep dive on a single changed entity                 | `inspect_entity`      |
| Review a remote GitHub PR without a local clone      | `inspect_pr`          |
| Post review comments on a GitHub PR                  | `inspect_post_review` |
| Search for a pattern across PR files                 | `inspect_search`      |

Rules:

- Start code review with `inspect_triage` — it surfaces risk scores and logical groups in one call.
- Use `inspect_predict` before merging risky changes to see what else might silently break.
- Use `inspect_pr` for remote PRs; use `inspect_triage` with `target` for local commits/ranges.
