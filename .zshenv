# Sourced by every zsh invocation — login, interactive, non-interactive
# `-c`, and Claude Code / Codex Bash-tool subshells — unlike .zshrc, which
# only runs for interactive shells. This is what keeps agent-spawned shells
# from running with a stale PATH or missing the claudeh/codexh wrappers.
# Keep this file minimal: it runs on every single command.

[ -f "$HOME/.config/shell/agent-env.sh" ] && . "$HOME/.config/shell/agent-env.sh"

# Propagate the same bootstrap to any non-interactive bash children (e.g. an
# agent's Bash tool spawning `bash -c ...` instead of zsh).
export BASH_ENV="$HOME/.config/shell/agent-env.sh"
