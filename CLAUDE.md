# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles. `install.sh` symlinks config files from this repo into `$HOME` and `~/.config/`. `bootstrap.sh` is a one-time new-machine setup script.

## Commands

Format and lint all files (runs `mise fmt` then `biome check --unsafe --write`):

```bash
just fix
```

Apply dotfiles to the current machine (idempotent, safe to re-run):

```bash
bash ./install.sh
```

Manage Homebrew packages (defined as shell functions in `.aliases`):

```bash
brew-install    # install all packages from global Brewfile
brew-lock       # dump current packages back to Brewfile
brew-upgrade    # update + clean
brew-add <pkg>  # install a package and add it to the Brewfile
```

## Architecture

**Symlink strategy**: `install.sh` runs `ln -fsv` from repo paths → `$HOME` or `$XDG_CONFIG_HOME`. No dotbot or stow.

**Platform branching**: `install.sh` and `.zshrc` branch on `$OSTYPE`:

- macOS: links `darwin.Brewfile`, `aerospace.toml`, sets up 1Password SSH signing at `/opt/1Password/op-ssh-sign`
- Linux: links `linux.Brewfile`, `i3/config`, GTK/HiDPI settings, `xprofile`/`Xresources`

**Shell init chain**: `.zshrc` → sources `.environment` (sets `XDG_CONFIG_HOME`, `GITHUB_TOKEN`) → sources `.aliases` (brew helpers, `av`/`avb`/`avsc`/`avpr` for Aviator stacked PRs)

**Tool versions**: `mise.toml` pins `biome`, `claude`, and `rtk` to `latest`. `mise.lock` records resolved versions.

**Formatting**: `biome.json` covers JSON files. Uses tabs. Zed's `settings.json` is exempted to allow comments and trailing commas.

**Git signing**: SSH signing via 1Password agent socket at `~/.1password/agent.sock`. Git configs are in `.config/git/` with per-context includes (`nikitabarskov.gitconfig`, `hirn.studio.gitconfig`, `deepinsight.gitconfig`).

<!-- rtk-instructions v2 -->

# RTK (Rust Token Killer) - Token-Optimized Commands

## Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged. This means RTK is always safe to use.

**Important**: Even in command chains with `&&`, use `rtk`:

```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
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

## Global Agent Preferences

Global coding preferences, principles, and shared tool instructions (CodeGraph) are maintained in `.config/agents/AGENTS.md` and symlinked to `~/.claude/CLAUDE.md`, `~/.config/opencode/AGENTS.md`, and `~/.codex/AGENTS.md` by `install.sh`.
