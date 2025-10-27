# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7
ENABLE_CORRECTION="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
    git
    dotenv
)
source $ZSH/oh-my-zsh.sh

# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
unsetopt prompt_cr
unsetopt prompt_sp

# linux specific

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export GDK_DPI_SCALE=0.5
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# macOS homebrew is in /opt/homebrew or /usr/local, Linux is in /home/linuxbrew/.linuxbrew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/opt/uutils-coreutils/libexec/uubin:${HOME}/.pyenv/bin:${HOME}/bin:${HOME}/.local/bin:${PATH}"
else
    export PATH="${HOME}/.pyenv/bin:${HOME}/bin:${HOME}/.local/bin:${PATH}"
fi

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

HISTSIZE=10000 # Lines of history to keep in memory for current session
HISTFILESIZE=10000 # Number of commands to save in the file
SAVEHIST=10000 # Number of history entries to save to disk
HISTFILE=~/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates

# Initialize pyenv if available
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey ";5C" forward-word
bindkey ";5D" backward-word
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Source zsh plugins if available
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    [ -f "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ] && \
        source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    [ -f "$BREW_PREFIX/share/forgit/forgit.plugin.zsh" ] && \
        source "$BREW_PREFIX/share/forgit/forgit.plugin.zsh"
fi

export BUN_INSTALL="${HOME}/.bun"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

typeset -U PATH
export PATH="${BUN_INSTALL}/bin:$PATH"

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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
