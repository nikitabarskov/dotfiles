#!/usr/bin/env bash
set -e

softwareupdate --install --all --force
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install python