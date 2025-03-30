#!/bin/sh
set -e

DOTFILES_REPOSITORY_DIR="${HOME}"/dotfiles
DOTFILES_REPOSITORY="https://github.com/nikitabarskov/dotfiles.git"
DOTFILES_REPOSITORY_BRANCH="nikita.barskov-20250330T200051-update-bootstrap-scripts"
[ -d "$DOTFILES_REPOSITORY_DIR" ] && rm -rf "$DOTFILES_REPOSITORY_DIR"
git clone --quiet --depth=1 --branch "$DOTFILES_REPOSITORY_BRANCH" "$DOTFILES_REPOSITORY" "$DOTFILES_REPOSITORY_DIR"

cd "$DOTFILES_REPOSITORY_DIR"

make install

cd - > /dev/null
