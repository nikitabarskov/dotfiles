#!/usr/bin/env bash

dir=$(pwd)
XDG_CONFIG_HOME="${HOME}/.config"

echo "Installing dotfiles from ${dir} to ${HOME}"

ln -fsv $(pwd)/.gitconfig ${HOME}/.gitconfig
ln -fsv $(pwd)/hirn.studio.gitconfig ${XDG_CONFIG_HOME}/git/hirn.studio.gitconfig
ln -fsv $(pwd)/nikitabarskov.gitconfig ${XDG_CONFIG_HOME}/git/nikitabarskov.gitconfig
ln -fsv $(pwd)/ignore ${XDG_CONFIG_HOME}/git/ignore
ln -fsv $(pwd)/.aliases ${HOME}/.aliases
ln -fsv $(pwd)/.zshrc ${HOME}/.zshrc
ln -fsv $(pwd)/.config/zed/settings.json ${XDG_CONFIG_HOME}/zed/settings.json
ln -fsv $(pwd)/.alacritty.toml ${XDG_CONFIG_HOME}/alacritty/.alacritty.toml

if [[ $OSTYPE == "linux-gnu"* ]]; then
    echo "Detected Linux - configuring i3"
    ln -fsv "$(pwd)/.config/i3" "${XDG_CONFIG_HOME}/i3"
    ln -fsv "$(pwd)/.config/i3status-rust" "${XDG_CONFIG_HOME}/i3status-rust"
    echo "Syncing Brewfile"
    ln -fsv "${dir}/linux/Brewfile" "${XDG_CONFIG_HOME}/homebrew/.Brewfile"
fi

# Configure 1Password SSH signing path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS - configuring 1Password SSH signing path"
    [ -d "/opt/1Password" ] && sudo mkdir -p /opt/1Password && sudo chown $(id -u):$(id -g) /opt/1Password
    ln -fsv "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" "/opt/1Password/op-ssh-sign"
    echo "Syncing Brewfile"
    ln -fsv "${dir}/macos/Brewfile" "${XDG_CONFIG_HOME}/homebrew/.Brewfile"
fi
