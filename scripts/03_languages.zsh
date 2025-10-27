#!/bin/zsh

set -euo pipefail

echo "Setting up programming languages..."

# ======================================================
# Rust
# ======================================================
if ! command -v rustup &>/dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    source "$HOME/.cargo/env"
    echo "Rust installed."
else
    echo "Rust already installed."
fi

# ======================================================
# Node.js via NVM
# ======================================================
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo "Installing Node.js LTS..."
    nvm install --lts
    nvm alias default 'lts/*'
    nvm use default

    # Enable corepack for pnpm/yarn
    corepack enable
    corepack prepare pnpm@latest --activate

    echo "Node.js and NVM installed."
else
    echo "NVM already installed."
fi

# ======================================================
# Python
# ======================================================
if command -v python3 &>/dev/null; then
    echo "Upgrading pip..."
    python3 -m pip install --upgrade pip --quiet
    echo "Python configured."
fi

# ======================================================
# Go
# ======================================================
if command -v go &>/dev/null; then
    echo "Go already installed."
    go version
else
    echo "Go not found. Install it via Brewfile or: brew install go"
fi

# ======================================================
# Java (OpenJDK)
# ======================================================
if command -v java &>/dev/null; then
    echo "Java already installed."
    java --version
else
    echo "Java not found. Install OpenJDK via Brewfile or: brew install openjdk"
    echo "After installing, you may need to create a symlink:"
    echo "  sudo ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk"
fi

# ======================================================
# .NET SDK
# ======================================================
if command -v dotnet &>/dev/null; then
    echo ".NET SDK already installed."
    dotnet --version

    # Add to PATH if not already there
    if ! grep -q 'dotnet' ~/.zshrc; then
        echo 'export PATH="$PATH:/usr/local/share/dotnet"' >> ~/.zshrc
    fi
else
    echo ".NET SDK not found. Install via Brewfile or: brew install --cask dotnet-sdk"
fi

echo "Language setup complete."
