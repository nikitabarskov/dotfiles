# shellcheck shell=sh
# Shared shell bootstrap for agent-spawned shells (Claude Code / Codex Bash
# tools) that skip the normal interactive .zshrc/.bashrc — sourced by
# ~/.zshenv (every zsh invocation, including non-interactive `-c`) and via
# BASH_ENV (every non-interactive bash invocation). Without this, those
# shells inherit a one-time PATH snapshot that goes stale as soon as a new
# mise tool is installed, and never see the claudeh/codexh wrappers below
# since aliases don't expand in non-interactive shells.

case "$-" in
*i*) ;;
*)
  add_path() {
    [ -d "$1" ] || return
    case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
    esac
  }

  add_path "$HOME/.local/bin"
  add_path "$HOME/.local/share/mise/shims"

  mise_installs_dir="$HOME/.local/share/mise/installs"
  if [ -d "$mise_installs_dir" ] && command -v find >/dev/null 2>&1; then
    # shellcheck disable=SC2044
    for mise_tool_dir in $(find "$mise_installs_dir" -mindepth 2 -maxdepth 2 -name latest 2>/dev/null); do
      add_path "$mise_tool_dir"
      add_path "$mise_tool_dir/bin"
      # shellcheck disable=SC2044
      for mise_nested_dir in $(find -L "$mise_tool_dir" -mindepth 1 -maxdepth 2 -type d 2>/dev/null); do
        add_path "$mise_nested_dir"
      done
    done
  fi
  export PATH
  unset -f add_path
  unset mise_installs_dir mise_tool_dir mise_nested_dir
  ;;
esac

if [ -n "${ZSH_VERSION:-}" ]; then
  # shellcheck disable=SC2034,SC3044
  typeset -U path PATH
fi

# Headroom-proxied CLI entry points. Functions (not aliases) so they also
# work when invoked from a non-interactive script — e.g. one agent shelling
# out to hand off work to the other.
agent_proxy_url="http://127.0.0.1:${HEADROOM_PROXY_PORT:-8787}"
export ANTHROPIC_BASE_URL="$agent_proxy_url"
export OPENAI_BASE_URL="$agent_proxy_url/v1"

claudeh() { claude "$@"; }
codexh() { codex "$@"; }

unset agent_proxy_url
