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
    fzf
    gh
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

# macOS homebrew is in /opt/homebrew or /usr/local, Linux is in /home/linuxbrew/.linuxbrew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"
else
    export PATH="${HOME}/bin:${HOME}/.local/bin:${PATH}"
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
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
export

SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Source zsh plugins if available
if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX=$(brew --prefix)
    [ -f "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh" ] && \
        source "$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    [ -f "$BREW_PREFIX/share/forgit/forgit.plugin.zsh" ] && \
        source "$BREW_PREFIX/share/forgit/forgit.plugin.zsh"
fi

UUTILS_PATH_PREFIX="$(brew --prefix)/opt/uutils-diffutils/libexec/uubin:$(brew --prefix)/opt/uutils-findutils/libexec/uubin:$(brew --prefix)/opt/uutils-coreutils/libexec/uubin"

export BUN_INSTALL="${HOME}/.bun"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

typeset -U PATH
export PATH="${UUTILS_PATH_PREFIX}:${BUN_INSTALL}/bin::$PATH"
export XDG_CONFIG_HOME="${HOME}/.config"

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

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

fpath+=${ZDOTDIR:-~}/.zsh_functions
