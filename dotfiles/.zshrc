# Colors.
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
unsetopt prompt_cr
unsetopt prompt_sp

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f $HOME/.aliases ]
then
  source $HOME/.aliases
fi

# Enable plugins (if present)
if [ -f $HOME/.zsh_plugins ]
then
  source $HOME/.zsh_plugins
  # Allow history search via up/down keys.
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down 
fi

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# History
HISTSIZE=10000 # Lines of history to keep in memory for current session
HISTFILESIZE=10000 # Number of commands to save in the file
SAVEHIST=10000 # Number of history entries to save to disk
HISTFILE=~/.zsh_history # Where to save history to disk
HISTDUP=erase # Erase duplicates in the history file
setopt hist_ignore_dups # Ignore duplicates

# Options `man zshoptions`
setopt append_history # Append history to the history file (no overwriting)
setopt share_history # Share history across terminals
setopt inc_append_history # Immediately append to the history file, not just when a term is killed
setopt extended_glob # Use extended globbing syntax
setopt auto_cd # Auto change to a dir without typing cd

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Environment variables
source $HOME/.environment

# Enable starship
eval "$(starship init zsh)"

# Enable Pyenv
eval "$(pyenv init -)"
# Enable Pyenv virtual-env
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/nikitabarskov/.sdkman"
[[ -s "/Users/nikitabarskov/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/nikitabarskov/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nikitabarskov/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nikitabarskov/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nikitabarskov/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nikitabarskov/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/terraform@0.13/bin:$PATH"
export PATH="/usr/local/opt/terraform@0.12/bin:$PATH"
