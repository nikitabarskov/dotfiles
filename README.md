# dotfiles

Personal dotfiles for macOS and Linux. Symlink-based — no dotbot or stow.

## Quick Start

New machine bootstrap (installs Homebrew, 1Password, clones repo, runs `install.sh`):

```bash
/bin/bash <(wget --no-cache -qO- https://raw.githubusercontent.com/nikitabarskov/dotfiles/main/bootstrap.sh)
```

Re-apply dotfiles on an existing machine (idempotent):

```bash
bash ./install.sh
```

## Daily Commands

```bash
just fix          # format + lint (mise fmt then biome check --unsafe --write)
just upgrade      # bump all mise tool versions
just lock         # regenerate mise.lock for linux-x64 and macos-arm64
```

## Structure

| Path | Purpose |
|---|---|
| `install.sh` | Symlinks everything into `$HOME` and `~/.config/` |
| `bootstrap.sh` | One-time new-machine setup |
| `justfile` | Task runner |
| `mise.toml` | Tool versions (biome, claude, codex, rtk, just) |
| `.config/agents/AGENTS.md` | Global AI agent instructions (symlinked to Claude, OpenCode, Codex) |
| `.config/git/` | Per-context git configs (nikitabarskov, hirn.studio, deepinsight) |
| `.config/homebrew/` | `darwin.Brewfile` and `linux.Brewfile` |

## Platform Notes

- **macOS**: links `aerospace.toml`, `darwin.Brewfile`; creates 1Password SSH sign at `/opt/1Password/op-ssh-sign`
- **Linux**: links `i3/config`, `linux.Brewfile`, GTK/HiDPI settings, `xprofile`, `Xresources`

## Links

| Link | Summary |
|---|---|
| [anishathalye/dotbot](https://github.com/anishathalye/dotbot) | Lightweight dotfiles bootstrapper. Uses a YAML config to symlink, create dirs, and run shell commands. No external dependencies; ships as a git submodule or PyPI package. |
| [Using GNU Stow to manage your dotfiles](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) | Classic article showing how to use GNU Stow to symlink dotfiles from a versioned subdirectory into `$HOME`. Simpler alternative to dedicated dotfile managers. |
| [MikeMcQuaid/strap](https://github.com/MikeMcQuaid/strap) | Script to bootstrap a minimal macOS dev system: enables FileVault/firewall/TouchID sudo, installs Xcode CLT and Homebrew, runs macOS updates, and optionally installs a `~/github/username/dotfiles` repo and Brewfile. |
| [Brew Bundle Brewfile Tips](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f) | Comprehensive guide to `brew bundle`: creating/restoring Brewfiles, using `mas` for App Store apps, `buo/cask-upgrade` for GUI app upgrades, and managing multiple Brewfiles per machine profile. |
| [mac-upgrade.sh](https://gist.github.com/arturmartins/f779720379e6bd97cac4bbe1dc202c8b#file-mac-upgrade-sh) | Single-command macOS upgrade script: runs `brew update`, `brew upgrade`, `brew cu --all`, `mas upgrade`, `brew cleanup`, then dumps the result back to a Brewfile. |
| [buo/homebrew-cask-upgrade](https://github.com/buo/homebrew-cask-upgrade) | `brew cu` — interactive Homebrew Cask upgrade tool with version pinning, auto-update app filtering, and `--all`/`--yes`/`--cleanup` flags. Fills the gap left by native `brew upgrade` for casks. |
| [GNU tools in macOS instead of FreeBSD tools](https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da) | How to install GNU coreutils/sed/tar/grep via Homebrew and prepend their `gnubin` paths so they shadow the BSD defaults on macOS. |
| [dotfiles — Document and automate your Macbook setup](https://about.gitlab.com/blog/dotfiles-document-and-automate-your-macbook-setup/) | GitLab blog post on dotfiles philosophy, structure, and automation: ZSH + Oh My Zsh, Homebrew scripts, `defaults write` for trackpad/keyboard settings, and keeping everything in a public git repo. |
| [i3wm for multilinguals](https://taras-sereda.github.io/blog/2022/i3-for-multilinguals/) | How to add a second keyboard layout in i3wm via `setxkbmap`, force US layout before screen lock with `xkb-switch`, and show a language indicator in i3bar with a custom `i3status` wrapper. |
