#!/usr/bin/env bash

dir=$(pwd)
XDG_CONFIG_HOME="${HOME}/.config"

echo "Installing dotfiles from ${dir} to ${HOME}"

ln -fsv "${dir}/.aliases" "${HOME}/.aliases"
ln -fsv "${dir}/.environment" "${HOME}/.environment"
ln -fsv "${dir}/.zshrc" "${HOME}/.zshrc"

ln -fsv "${dir}/.gitconfig" "${HOME}/.gitconfig"
[ -e "${XDG_CONFIG_HOME}/git" ] && rm -rf "${XDG_CONFIG_HOME}/git"
ln -fsv "${dir}/.config/git" "${XDG_CONFIG_HOME}/git"
mkdir -p "${HOME}/.local/bin"
ln -fsv "${dir}/scripts/sem-diff-wrapper" "${HOME}/.local/bin/sem-diff-wrapper"

mkdir -p "${XDG_CONFIG_HOME}/zed" &&
  ln -fsv "${dir}/.config/zed/settings.json" "${XDG_CONFIG_HOME}/zed/settings.json" &&
  ln -fsv "${dir}/.config/zed/themes" "${XDG_CONFIG_HOME}/zed/"
[ -e "${XDG_CONFIG_HOME}/alacritty" ] && rm -rf "${XDG_CONFIG_HOME}/alacritty"
ln -fsv "${dir}/.config/alacritty" "${XDG_CONFIG_HOME}/alacritty"
[ ! -f "${dir}/.config/alacritty/theme.toml" ] && \
    cp "${dir}/.config/alacritty/themes/alabaster.toml" "${dir}/.config/alacritty/theme.toml"
[ -e "${XDG_CONFIG_HOME}/ghostty" ] && rm -rf "${XDG_CONFIG_HOME}/ghostty"
ln -fsv "${dir}/.config/ghostty" "${XDG_CONFIG_HOME}/ghostty"
[ -e "${XDG_CONFIG_HOME}/lazygit" ] && rm -rf "${XDG_CONFIG_HOME}/lazygit"
ln -fsv "${dir}/.config/lazygit" "${XDG_CONFIG_HOME}/lazygit"
[ -e "${XDG_CONFIG_HOME}/gh" ] && rm -rf "${XDG_CONFIG_HOME}/gh"
ln -fsv "${dir}/.config/gh" "${XDG_CONFIG_HOME}/gh"
ln -fsv "${dir}/.profile" "${HOME}/.profile"
[ -e "${XDG_CONFIG_HOME}/helix" ] && rm -rf "${XDG_CONFIG_HOME}/helix"
ln -fsv "${dir}/.config/helix" "${XDG_CONFIG_HOME}/helix"
[ -e "${XDG_CONFIG_HOME}/mise" ] && rm -rf "${XDG_CONFIG_HOME}/mise"
ln -fsv "${dir}/.config/mise" "${XDG_CONFIG_HOME}/mise"
[ -e "${XDG_CONFIG_HOME}/just" ] && rm -rf "${XDG_CONFIG_HOME}/just"
ln -fsv "${dir}/.config/just" "${XDG_CONFIG_HOME}/just"
mkdir -p "${HOME}/.cargo"
ln -fsv "${dir}/.config/cargo/config.toml" "${HOME}/.cargo/config.toml"
ln -fsv "${dir}/.config/tmux/tmux.conf" "${XDG_CONFIG_HOME}/tmux/tmux.conf"

# AI agent global instructions (shared across Claude Code, OpenCode, Codex)
mkdir -p "${HOME}/.claude" "${XDG_CONFIG_HOME}/opencode" "${HOME}/.codex"
[ -e "${HOME}/.agents" ] && rm -rf "${HOME}/.agents"
ln -fsv "${dir}/.agents" "${HOME}/.agents"
mkdir -p "${HOME}/.serena"
ln -fsv "${dir}/.config/serena/serena_config.yml" "${HOME}/.serena/serena_config.yml"
ln -fsv "${dir}/.config/agents/AGENTS.md" "${HOME}/.claude/CLAUDE.md"
ln -fsv "${dir}/.config/agents/AGENTS.md" "${XDG_CONFIG_HOME}/opencode/AGENTS.md"
ln -fsv "${dir}/.config/agents/AGENTS.md" "${HOME}/.codex/AGENTS.md"
# AI agent tool configs
ln -fsv "${dir}/.config/.claude/settings.json" "${HOME}/.claude/settings.json"
[ -e "${HOME}/.claude/skills" ] && rm -rf "${HOME}/.claude/skills"
ln -fsv "${dir}/.agents/skills" "${HOME}/.claude/skills"
# MCP servers for Claude Code (user scope, stored in ~/.claude.json)
# claude mcp add is idempotent — re-running install.sh is safe
claude mcp add --scope user --transport stdio codegraph -- codegraph serve --mcp
claude mcp add --scope user --transport stdio sem -- sem mcp
claude mcp add --scope user --transport stdio inspect -- inspect-mcp
ln -fsv "${dir}/.config/.opencode/opencode.jsonc" "${XDG_CONFIG_HOME}/opencode/opencode.jsonc"
ln -fsv "${dir}/.config/.codex/config.toml" "${HOME}/.codex/config.toml"

if [[ $OSTYPE == "linux-gnu"* ]]; then
  echo "Configure HiDPI on Linux"
  ln -fsv "$(pwd)/.xprofile" "${HOME}/.xprofile"
  ln -fsv "$(pwd)/.Xresources" "${HOME}/.Xresources"
  echo "Detected Linux - configuring i3"
  mkdir -p "${XDG_CONFIG_HOME}/i3" &&
    ln -fsv "${dir}/.config/i3/config" "${XDG_CONFIG_HOME}/i3/config"
  [ ! -e "${XDG_CONFIG_HOME}/homebrew" ] && mkdir -p "${XDG_CONFIG_HOME}/homebrew"
  mkdir -p "${XDG_CONFIG_HOME}/i3status-rust" &&
    ln -fsv "${dir}/.config/i3status-rust/config.toml" "${XDG_CONFIG_HOME}/i3status-rust/config"
  mkdir -p "${XDG_CONFIG_HOME}/gtk-3.0"
  ln -fsv "${dir}/.config/gtk-3.0/settings.ini" "${XDG_CONFIG_HOME}/gtk-3.0/settings.ini"
  ln -fsv "${dir}/.config/homebrew/linux.Brewfile" "${XDG_CONFIG_HOME}/homebrew/Brewfile"
fi

# Configure 1Password SSH signing path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Detected macOS - configure Aerospace"
  [ ! -e "${XDG_CONFIG_HOME}/aerospace" ] && mkdir -p "${XDG_CONFIG_HOME}/aerospace"
  ln -fsv "${dir}/.config/aerospace/aerospace.toml" "${XDG_CONFIG_HOME}/aerospace/aerospace.toml"
  echo "Detected macOS - configuring Headroom LaunchAgent"
  mkdir -p "${HOME}/.headroom/deploy/default" "${HOME}/Library/LaunchAgents"
  ln -fsv "${dir}/.config/headroom/deploy/default/run-headroom.sh" "${HOME}/.headroom/deploy/default/run-headroom.sh"
  cp -f "${dir}/.config/headroom/LaunchAgents/com.headroom.default.plist" "${HOME}/Library/LaunchAgents/com.headroom.default.plist"
  launchctl bootstrap "gui/$(id -u)" "${HOME}/Library/LaunchAgents/com.headroom.default.plist" 2>/dev/null || true
  launchctl kickstart -k "gui/$(id -u)/com.headroom.default" 2>/dev/null || true
  echo "Detected macOS - configuring 1Password SSH signing path"
  [ -d "/opt/1Password" ] && sudo mkdir -p /opt/1Password && sudo chown "$(id -u):$(id -g)" /opt/1Password
  [ ! -e "/opt/1Password/op-ssh-sign" ] && ln -fsv "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" "/opt/1Password/op-ssh-sign"
  echo "Syncing Brewfile"
  [ ! -e "${XDG_CONFIG_HOME}/homebrew" ] && mkdir -p "${XDG_CONFIG_HOME}/homebrew"
  ln -fsv "${dir}/.config/homebrew/darwin.Brewfile" "${XDG_CONFIG_HOME}/homebrew/Brewfile"
fi
