#!/usr/bin/env bash

dir=$(pwd)

echo "Installing dotfiles from ${dir} to ${HOME}"

ln -fsv $(pwd)/.gitconfig ${HOME}/.gitconfig
ln -fsv $(pwd)/hirn.studio.gitconfig ${HOME}/.config/git/hirn.studio.gitconfig
ln -fsv $(pwd)/nikitabarskov.gitconfig ${HOME}/.config/git/nikitabarskov.gitconfig
ln -fsv $(pwd)/ignore ${HOME}/.config/git/ignore
ln -fsv $(pwd)/.aliases ${HOME}/.aliases
ln -fsv $(pwd)/.zshrc ${HOME}/.zshrc
ln -fsv $(pwd)/.config/zed/settings.json ${HOME}/.config/zed/settings.json
ln -fsv $(pwd)/.alacritty.toml ${HOME}/.config/alacritty/.alacritty.toml

if [[ $OSTYPE == "linux-gnu"* ]]; then
    echo "Detected Linux - configuring i3"
    ln -fsv "$(pwd)/.config/i3" "${HOME}/.config/i3"
    ln -fsv "$(pwd)/.config/i3status-rust" "${HOME}/.config/i3status-rust"
fi

# Configure 1Password SSH signing path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS - configuring 1Password SSH signing path"
    ln -fsv "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" "/opt/1Password/op-ssh-sign"
fi
