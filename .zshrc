if [ -f "${HOME}/.environment" ]; then
    source "${HOME}/.environment"
fi

# oh-my-zsh config
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

# Initialize fzf if available
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
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
fi

# Initialize completion system
autoload -Uz compinit
compinit

# Start a new tmux session per Alacritty window.
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ] && [[ "$TERM_PROGRAM" == "alacritty" ]]; then
    exec tmux new-session
fi
