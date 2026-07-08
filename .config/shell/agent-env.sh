# Shared shell bootstrap for agent-spawned shells (Claude Code / Codex Bash
# tools) that skip the normal interactive .zshrc/.bashrc — sourced by
# ~/.zshenv (every zsh invocation, including non-interactive `-c`) and via
# BASH_ENV (every non-interactive bash invocation). Without this, those
# shells inherit a one-time PATH snapshot that goes stale as soon as a new
# mise tool is installed, and never see the claudeh/codexh wrappers below
# since aliases don't expand in non-interactive shells.

if command -v mise >/dev/null 2>&1; then
    if [ -n "${ZSH_VERSION:-}" ]; then
        eval "$(mise activate zsh)"
    elif [ -n "${BASH_VERSION:-}" ]; then
        eval "$(mise activate bash)"
    fi
fi

# Headroom-wrapped CLI entry points. Functions (not aliases) so they also
# work when invoked from a non-interactive script — e.g. one agent shelling
# out to hand off work to the other.
if command -v headroom >/dev/null 2>&1; then
    claudeh() { headroom wrap claude --no-serena --no-mcp --no-tokensave "$@"; }
    codexh() { headroom wrap codex --no-serena --no-mcp --no-tokensave "$@"; }
fi
