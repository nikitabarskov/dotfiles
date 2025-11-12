#!/usr/bin/env bash

set -euo pipefail

# Function to install system dependencies
install_system_dependencies() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "[INFO] Detected macOS"
        if ! xcode-select -p &> /dev/null; then
            echo "[INFO] Installing Command Line Tools..."
            xcode-select --install
            echo "[INFO] Please complete the Command Line Tools installation and run this script again"
            exit 0
        fi
    elif [[ "$OSTYPE" == "linux"* ]] || [[ "$(uname -s)" == "Linux" ]]; then
        echo "[INFO] Detected Linux system"

        if command -v dnf &> /dev/null; then
            echo "[INFO] Using dnf package manager (Fedora/RHEL)"
            echo "[INFO] Installing dependencies via dnf..."
            sudo dnf group install development-tools
            sudo dnf install -y procps-ng curl file git
        elif command -v apt-get &> /dev/null; then
            echo "[INFO] Using apt package manager (Ubuntu/Debian)"
            echo "[INFO] Installing dependencies via apt..."
            sudo apt-get update
            sudo apt-get install -y build-essential procps curl file git
        else
            echo "[ERROR] Unsupported Linux distribution. This script requires dnf (Fedora/RHEL) or apt (Ubuntu/Debian)"
            exit 1
        fi
    else
        echo "[ERROR] Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Function to determine Homebrew prefix
get_brew_prefix() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            echo "/opt/homebrew"
        else
            echo "/usr/local"
        fi
    else
        echo "/home/linuxbrew/.linuxbrew"
    fi
}

# Function to install Homebrew
install_homebrew() {
    install_system_dependencies

    echo "[INFO] Installing Homebrew..." >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    local brew_prefix
    brew_prefix="$(get_brew_prefix)"

    if [[ ! -f "${brew_prefix}/bin/brew" ]]; then
        echo "[ERROR] Homebrew installation failed" >&2
        exit 1
    fi

    echo "[INFO] Homebrew installed successfully at: ${brew_prefix}" >&2
    echo "${brew_prefix}"
}

TMP_DIR=$(mktemp -d)
echo "Use ${TMP_DIR} as a temporary directory"

trap 'rm -rf "${TMP_DIR}"' EXIT

# Setup Homebrew
if command -v brew &> /dev/null; then
    echo "[INFO] Homebrew is already installed at: $(command -v brew)"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[INFO] Skipping Homebrew installation"
        BREW_PREFIX="$(brew --prefix)"
    else
        BREW_PREFIX="$(install_homebrew)"
    fi
else
    # Homebrew is not installed
    echo "[INFO] Homebrew is not installed"
    read -p "Do you want to install Homebrew? (Y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "[INFO] Homebrew installation declined. Exiting."
        exit 0
    fi

    BREW_PREFIX="$(install_homebrew)"
fi

echo "[INFO] Installing git and zsh..."
"${BREW_PREFIX}"/bin/brew install --verbose zsh git

# Install 1Password
echo "[INFO] Installing 1Password..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    "${BREW_PREFIX}"/bin/brew install --cask 1password 1password-cli
elif [[ "$OSTYPE" == "linux"* ]] || [[ "$(uname -s)" == "Linux" ]]; then
    if command -v dnf &> /dev/null; then
        # Fedora/RHEL
        sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
        sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
        sudo dnf install -y 1password 1password-cli
    elif command -v apt-get &> /dev/null; then
        # Ubuntu/Debian
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | sudo tee /etc/apt/sources.list.d/1password.list
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
        curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
        sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
        sudo apt-get update
        sudo apt-get install -y 1password 1password-cli
    fi
fi

# Launch 1Password and wait for user to set it up
echo "[INFO] Launching 1Password..."
echo "[INFO] Please complete 1Password setup and sign in before continuing."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open -a "1Password"
elif [[ "$OSTYPE" == "linux"* ]] || [[ "$(uname -s)" == "Linux" ]]; then
    1password &
fi

read -p "Press Enter once you have completed 1Password setup and signed in..." -r
echo

# Clone bare repo to temporary directory
echo "[INFO] Cloning bare dotfiles repo to temporary directory..."
"${BREW_PREFIX}"/bin/git clone --depth 1 https://github.com/nikitabarskov/dotfiles.git "${TMP_DIR}/dotfiles.git"

# Setup temporary git configuration
echo "[INFO] Setting up temporary git configuration..."
mkdir -p "${TMP_DIR}/.config/git"
ls -la "${TMP_DIR}/dotfiles.git"
cp "${TMP_DIR}/dotfiles.git/.gitconfig" "${TMP_DIR}/.gitconfig"
cp "${TMP_DIR}/dotfiles.git/nikitabarskov.gitconfig" "${TMP_DIR}/.config/git/nikitabarskov.gitconfig"
cp "${TMP_DIR}/dotfiles.git/hirn.studio.gitconfig" "${TMP_DIR}/.config/git/hirn.studio.gitconfig"
[ -f "${TMP_DIR}/dotfiles.git/deepinsight.gitconfig" ] && cp "${TMP_DIR}/dotfiles.git/deepinsight.gitconfig" "${TMP_DIR}/.config/git/deepinsight.gitconfig"
cp "${TMP_DIR}/dotfiles.git/ignore" "${TMP_DIR}/.config/git/ignore"

# Clone proper repo to ~/personal/dotfiles
echo "[INFO] Cloning dotfiles repository to ~/personal/dotfiles..."
mkdir -p "${HOME}/personal"
env HOME="${TMP_DIR}" "${BREW_PREFIX}"/bin/git clone git@github.com:nikitabarskov/dotfiles.git "${HOME}/personal/dotfiles"

# Run install.sh
echo "[INFO] Running install.sh..."
cd "${HOME}/personal/dotfiles"
bash ./install.sh

echo "[INFO] Bootstrap complete! Please restart your shell or source your configuration files."
