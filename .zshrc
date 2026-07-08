# Initialize package and tool paths before loading shell plugins.
export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"

# $SHELL can be stale (e.g. set by a login/session manager before a
# `chsh` took effect), which breaks tools like tmux that spawn $SHELL
# for new panes. Since we're already running inside zsh, just fix it.
export SHELL="$(command -v zsh)"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
    1password
    brew
    docker
    git
)
source $ZSH/oh-my-zsh.sh

# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
unsetopt prompt_cr
unsetopt prompt_sp

# linux specific

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # 4K 27" display scaling (96 DPI * 2 = 192 DPI for 200% scaling)
    export GDK_SCALE=2
    export GDK_DPI_SCALE=0.5
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_SCALE_FACTOR=2
    export QT_FONT_DPI=96
    export XCURSOR_SIZE=32
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

HISTSIZE=10000 # Lines of history to keep in memory for current session
HISTFILESIZE=10000 # Number of commands to save in the file
SAVEHIST=10000 # Number of history entries to save to disk
HISTFILE=~/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates

bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Source zsh plugins if available
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    if [ -f "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
        source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
        bindkey "^[[A" history-substring-search-up
        bindkey "^[[B" history-substring-search-down
    fi
    [ -f "$BREW_PREFIX/share/forgit/forgit.plugin.zsh" ] && \
        source "$BREW_PREFIX/share/forgit/forgit.plugin.zsh"
fi

UUTILS_PATH_PREFIX="$(brew --prefix)/opt/uutils-diffutils/libexec/uubin:$(brew --prefix)/opt/uutils-findutils/libexec/uubin:$(brew --prefix)/opt/uutils-coreutils/libexec/uubin"

export BUN_INSTALL="${HOME}/.bun"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

typeset -U PATH
export PATH="${UUTILS_PATH_PREFIX}:${BUN_INSTALL}/bin:${HOME}/.docker/bin:$PATH"
export XDG_CONFIG_HOME="${HOME}/.config"

# Initialize fzf if available
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

if [ -f ${HOME}/.environment ]
then
    source ${HOME}/.environment
fi

if [ -f ${HOME}/.aliases ]
then
    source ${HOME}/.aliases
fi

# Initialize starship if available
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Docker CLI completions
if [[ "$OSTYPE" == "darwin"* ]] && [ -d "$HOME/.docker/completions" ]; then
    fpath=($HOME/.docker/completions $fpath)
    export PATH="${HOME}/.orbstack/bin:$PATH"
fi

# Initialize completion system
autoload -Uz compinit
compinit

# Start a new tmux session per Alacritty window.
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ] && [[ "$TERM_PROGRAM" == "alacritty" ]]; then
    exec tmux new-session
fi
