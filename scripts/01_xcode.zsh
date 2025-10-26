#!/bin/zsh

set -euo pipefail

# ======================================================
# Xcode Command Line Tools
# ======================================================
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install || true

    echo "Waiting for Xcode Command Line Tools to finish installing..."
    until xcode-select -p &>/dev/null; do
        sleep 20
    done

    echo "Xcode Command Line Tools installed."
else
    echo "Xcode Command Line Tools already installed."
fi

# ======================================================
# Homebrew
# ======================================================
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ -d "/opt/homebrew/bin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -d "/usr/local/bin" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed."
fi

brew update
brew upgrade
