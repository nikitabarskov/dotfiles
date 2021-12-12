export PATH="${HOME}/.pyenv/bin:${HOME}/.local/bin:${PATH}"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

typeset -U PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
