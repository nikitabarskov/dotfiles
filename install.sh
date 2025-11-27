#!/usr/bin/env bash

dir=$(pwd)
XDG_CONFIG_HOME="${HOME}/.config"

echo "Installing dotfiles from ${dir} to ${HOME}"

ln -fsv "${dir}/.aliases" "${HOME}/.aliases"
ln -fsv "${dir}/.environment" "${HOME}/.environment"
ln -fsv "${dir}/.zshrc" "${HOME}/.zshrc"

ln -fsv "${dir}/.gitconfig" "${HOME}/.gitconfig"
[ -e "${XDG_CONFIG_HOME}/git" ] && rm -rf "${XDG_CONFIG_HOME}/git"
ln -fsv "${dir}/.config/git" "${XDG_CONFIG_HOME}/git"

mkdir -p "${XDG_CONFIG_HOME}/zed" && \
  ln -fsv "${dir}/.config/zed/settings.json" "${XDG_CONFIG_HOME}/zed/settings.json" && \
  ln -fsv "${dir}/.config/zed/themes" "${XDG_CONFIG_HOME}/zed/"
[ -e "${XDG_CONFIG_HOME}/alacritty" ] && rm -rf "${XDG_CONFIG_HOME}/alacritty"
ln -fsv "${dir}/.config/alacritty" "${XDG_CONFIG_HOME}/alacritty"
[ -e "${XDG_CONFIG_HOME}/ghostty" ] && rm -rf "${XDG_CONFIG_HOME}/ghostty"
ln -fsv "${dir}/.config/ghostty" "${XDG_CONFIG_HOME}/ghostty"
[ -e "${XDG_CONFIG_HOME}/lazygit" ] && rm -rf "${XDG_CONFIG_HOME}/lazygit"
ln -fsv "${dir}/.config/lazygit" "${XDG_CONFIG_HOME}/lazygit"
[ -e "${XDG_CONFIG_HOME}/gh" ] && rm -rf "${XDG_CONFIG_HOME}/gh"
ln -fsv "${dir}/.config/gh" "${XDG_CONFIG_HOME}/gh"
ln -fsv "${dir}/.profile" "${HOME}/.profile"
[ -e "${XDG_CONFIG_HOME}/helix" ] && rm -rf "${XDG_CONFIG_HOME}/helix"
ln -fsv "${dir}/.config/helix" "${XDG_CONFIG_HOME}/helix"

if [[ $OSTYPE == "linux-gnu"* ]]; then
    echo "Configure HiDPI on Linux"
    ln -fsv "$(pwd)/.xprofile" "${HOME}/.xprofile"
    ln -fsv "$(pwd)/.Xresources" "${HOME}/.Xresources"
    echo "Detected Linux - configuring i3"
    mkdir -p "${XDG_CONFIG_HOME}/i3" && \
      ln -fsv "${dir}/.config/i3/config" "${XDG_CONFIG_HOME}/i3/config"
    [ ! -e "${XDG_CONFIG_HOME}/homebrew" ] && mkdir -p "${XDG_CONFIG_HOME}/homebrew"
    mkdir -p "${XDG_CONFIG_HOME}/gtk-3.0"
    ln -fsv "${dir}/.config/gtk-3.0/settings.ini" "${XDG_CONFIG_HOME}/gtk-3.0/settings.ini"
    ln -fsv "${dir}/.config/homebrew/linux.Brewfile" "${XDG_CONFIG_HOME}/homebrew/Brewfile"
fi

# Configure 1Password SSH signing path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS - configure Aerospace"
    [ ! -e "${XDG_CONFIG_HOME}/aerospace" ] && mkdir -p "${XDG_CONFIG_HOME}/aerospace"
    ln -fsv "${dir}/.config/aerospace/aerospace.toml" "${XDG_CONFIG_HOME}/aerospace/aerospace.toml"
    echo "Detected macOS - configuring 1Password SSH signing path"
    [ -d "/opt/1Password" ] && sudo mkdir -p /opt/1Password && sudo chown "$(id -u):$(id -g)" /opt/1Password
    [ ! -e "/opt/1Password/op-ssh-sign" ] && ln -fsv "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" "/opt/1Password/op-ssh-sign"
    echo "Syncing Brewfile"
    [ ! -e "${XDG_CONFIG_HOME}/homebrew" ] && mkdir -p "${XDG_CONFIG_HOME}/homebrew"
    ln -fsv "${dir}/.config/homebrew/darwin.Brewfile" "${XDG_CONFIG_HOME}/homebrew/Brewfile"
fi
