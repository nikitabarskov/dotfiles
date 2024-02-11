# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
unsetopt prompt_cr
unsetopt prompt_sp

export PATH="${HOME}/.pyenv/bin:${HOME}/.local/bin:${PATH}"

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey ";5C" forward-word
bindkey ";5D" backward-word

HISTSIZE=10000 # Lines of history to keep in memory for current session
HISTFILESIZE=10000 # Number of commands to save in the file
SAVEHIST=10000 # Number of history entries to save to disk
HISTFILE=~/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

typeset -U PATH

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zellij setup --generate-auto-start zsh)"
