# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="${HOME}/.local/bin:$(brew --prefix)/opt/uutils-coreutils/libexec/uubin:$(brew --prefix)/opt/curl/bin:${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${HOMEBREW_PREFIX}/opt/make/libexec/gnubin:$HOME/.docker/bin:${BUN_INSTALL}/bin:${PATH}"
export GH_TOKEN=$(gh auth token)
export COMPOSER_BAKE=true

typeset -U PATH

eval .aliases

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nikitabarskov/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nikitabarskov/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nikitabarskov/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nikitabarskov/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/nikitabarskov/.bun/_bun" ] && source "/Users/nikitabarskov/.bun/_bun"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/nikitabarskov/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

eval "$(/opt/homebrew/bin/mise activate zsh)"
eval "$(starship init zsh)"
