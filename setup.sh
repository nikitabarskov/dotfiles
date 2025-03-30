#!/bin/bash
set -e

DOTFILES_REPOSITORY_DIR=$(mktemp -d)
cd $DOTFILES_REPOSITORY_DIR

git clone --quiet --depth=1 https://github.com/nikitabarskov/dotfiles.git $DOTFILES_REPOSITORY_DIR
