# AGENTS.md

Personal dotfiles repo. `install.sh` symlinks files from here into `$HOME` and `~/.config/` using `ln -fsv`. No dotbot or stow.

## Commands

```bash
just fix          # format + lint: runs `mise fmt` then `biome check --unsafe --write`
bash ./install.sh # apply dotfiles (idempotent, safe to re-run)
just upgrade      # bump all mise tool versions
just lock         # regenerate mise.lock for linux-x64 and macos-arm64
```

There are no tests.

## Formatting

Biome handles JSON files. Indent style is **tabs**. Run `just fix` before committing — it both formats and lints. `biome.json` exempts `.config/zed/settings.json` to allow comments and trailing commas.

## Platform branching

`install.sh` branches on `$OSTYPE`:

- **macOS**: links `darwin.Brewfile`, `aerospace.toml`; creates 1Password SSH sign symlink at `/opt/1Password/op-ssh-sign`
- **Linux**: links `linux.Brewfile`, `i3/config`, GTK/HiDPI settings, `xprofile`/`Xresources`

When adding a new symlink, check whether it should be platform-conditional.

## Global agent instructions

`.config/agents/AGENTS.md` is the single source of truth for global coding preferences, principles, and shared tool instructions (CodeGraph, RTK). `install.sh` symlinks it to:

- `~/.claude/CLAUDE.md`
- `~/.config/opencode/AGENTS.md`
- `~/.codex/AGENTS.md`

Edit `.config/agents/AGENTS.md` to update global preferences; re-run `install.sh` to propagate (symlinks mean it's live immediately).

**Do not run `rtk init --global`** — it replaces `~/.claude/CLAUDE.md` with a real file, breaking the symlink. RTK instructions are managed manually in `.config/agents/AGENTS.md`. If the symlink breaks, restore it with `bash ./install.sh`.

## Git signing

SSH signing via 1Password. Socket at `~/.1password/agent.sock`. Per-context git configs in `.config/git/` with includes for `nikitabarskov`, `hirn.studio`, and `deepinsight` identities.
