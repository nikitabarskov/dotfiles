# dotfiles

## Quick Start

```bash
/bin/bash <(wget -qO- https://raw.githubusercontent.com/nikitabarskov/dotfiles/main/bootstrap.sh)
```

## Notes

- https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
- https://github.com/MikeMcQuaid/strap
- https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f
- https://gist.github.com/arturmartins/f779720379e6bd97cac4bbe1dc202c8b#file-mac-upgrade-sh
- https://github.com/buo/homebrew-cask-upgrade
- https://gist.github.com/skyzyx/3438280b18e4f7c490db8a2a2ca0b9da
- https://about.gitlab.com/blog/dotfiles-document-and-automate-your-macbook-setup/

```shell
brew bundle install --cask --file=cask.Brewfile
brew bundle cleanup --cask --force --file=cask.Brewfile
```

### HiDPI

```shell
xrdb -merge ~/.Xresources
```
