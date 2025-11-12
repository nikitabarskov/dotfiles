#!/usr/bin/env bash

set -euo pipefail

TMP_DIR=$(mktemp -d)
echo "Use ${TMP_DIR} as a temporary directory"

trap 'rm -rf "${TMP_DIR}"' EXIT

if command -v brew &> /dev/null; then
    echo "[INFO] Homebrew is already installed at: $(command -v brew)"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "[INFO] Skipping Homebrew installation"
        BREW_PREFIX="$(brew --prefix)"
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "[INFO] Detected macOS"
            if ! xcode-select -p &> /dev/null; then
                echo "[INFO] Installing Command Line Tools..."
                xcode-select --install
                echo "[INFO] Please complete the Command Line Tools installation and run this script again"
                exit 0
            fi
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if ! command -v dnf &> /dev/null; then
                echo "[ERROR] This script only supports Fedora Linux"
                exit 1
            fi

            echo "[INFO] Detected Fedora system"

            echo "[INFO] Installing dependencies via dnf..."
            sudo dnf group install development-tools
            sudo dnf install procps-ng curl file
        else
            echo "[ERROR] Unsupported operating system: $OSTYPE"
            exit 1
        fi

        echo "[INFO] Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [[ "$OSTYPE" == "darwin"* ]]; then
            if [[ "$(uname -m)" == "arm64" ]]; then
                BREW_PREFIX="/opt/homebrew"
            else
                BREW_PREFIX="/usr/local"
            fi
        else
            BREW_PREFIX="/home/linuxbrew/.linuxbrew"
        fi

        if [[ ! -f "${BREW_PREFIX}/bin/brew" ]]; then
            echo "[ERROR] Homebrew installation failed"
            exit 1
        fi

        echo "[INFO] Homebrew installed successfully at: ${BREW_PREFIX}"
    fi
else
    # Homebrew is not installed, proceed with installation
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "[INFO] Detected macOS"
        if ! xcode-select -p &> /dev/null; then
            echo "[INFO] Installing Command Line Tools..."
            xcode-select --install
            echo "[INFO] Please complete the Command Line Tools installation and run this script again"
            exit 0
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if ! command -v dnf &> /dev/null; then
            echo "[ERROR] This script only supports Fedora Linux"
            exit 1
        fi

        echo "[INFO] Detected Fedora system"

        echo "[INFO] Installing dependencies via dnf..."
        sudo dnf group install development-tools
        sudo dnf install procps-ng curl file
    else
        echo "[ERROR] Unsupported operating system: $OSTYPE"
        exit 1
    fi

    echo "[INFO] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            BREW_PREFIX="/opt/homebrew"
        else
            BREW_PREFIX="/usr/local"
        fi
    else
        BREW_PREFIX="/home/linuxbrew/.linuxbrew"
    fi

    if [[ ! -f "${BREW_PREFIX}/bin/brew" ]]; then
        echo "[ERROR] Homebrew installation failed"
        exit 1
    fi

    echo "[INFO] Homebrew installed successfully at: ${BREW_PREFIX}"
fi

echo "[INFO] Installing git and zsh..."
"${BREW_PREFIX}"/bin/brew install --verbose zsh git

# Install 1Password
echo "[INFO] Installing 1Password..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    "${BREW_PREFIX}"/bin/brew install --cask 1password 1password-cli
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
    sudo dnf install -y 1password 1password-cli
fi

# Launch 1Password and wait for user to set it up
echo "[INFO] Launching 1Password..."
echo "[INFO] Please complete 1Password setup and sign in before continuing."
if [[ "$OSTYPE" == "darwin"* ]]; then
    open -a "1Password"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
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
