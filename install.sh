dir=$(pwd)

echo "Installing dotfiles from ${dir} to ${HOME}"

ln -v -s --force $(pwd)/.gitconfig ${HOME}/.gitconfig
ln -v -s --force $(pwd)/hirn.studio.gitconfig ${HOME}/.config/git/hirn.studio.gitconfig
ln -v -s --force $(pwd)/nikitabarskov.gitconfig ${HOME}/.config/git/nikitabarskov.gitconfig
ln -v -s --force $(pwd)/ignore ${HOME}/.config/git/ignore
ln -v -s --force $(pwd)/.aliases ${HOME}/.aliases
ln -v -s --force $(pwd)/.zshrc ${HOME}/.zshrc
ln -v -s --force $(pwd)/.config/zed/settings.json ${HOME}/.config/zed/settings.json

# Configure 1Password SSH signing path based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS - configuring 1Password SSH signing path"
    ln -v -s --force "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" "/opt/1Password/op-ssh-sign"
fi
