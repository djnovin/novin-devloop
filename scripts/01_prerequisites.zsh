#!/bin/zsh

set -euo pipefail

# ======================================================
# Xcode Command Line Tools
# ======================================================
if ! xcode-select -p &>/dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install

    echo "Waiting for installation to complete..."
    until xcode-select -p &>/dev/null; do
        sleep 5
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

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed."
fi

echo "Updating Homebrew..."
brew update
