#!/bin/zsh

set -euo pipefail

# ======================================================
# Build Tools
# ======================================================
brew install make gcc cmake pkg-config autoconf automake

# ======================================================
# Python
# ======================================================
brew install python pyenv
python3 --version
pip3 --version

# ======================================================
# Rust
# ======================================================
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

rustc --version
cargo --version

# ======================================================
# Go
# ======================================================
brew install go
go version

# ======================================================
# .NET
# ======================================================
brew install --cask dotnet-sdk

if ! grep -q 'dotnet' ~/.zshrc; then
  echo 'export PATH="$PATH:/usr/local/share/dotnet"' >> ~/.zshrc
fi

dotnet --version
dotnet --list-sdks

# ======================================================
# Java
# ======================================================
brew install openjdk

# ======================================================
# Node.js via NVM
# ======================================================

if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "nvm already installed."
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install --lts
nvm alias default 'lts/*'
nvm use default

node -v
npm -v

# ======================================================
# Corepack & Package Managers
# ======================================================
corepack enable
corepack prepare pnpm@latest --activate

# ======================================================
# JS Globals
# ======================================================
pnpm install -g vercel serverless pm2 concurrently nodemon

# ======================================================
# Bun
# ======================================================
brew install oven-sh/bun/bun

# ======================================================
# Deno
# ======================================================
brew install deno
