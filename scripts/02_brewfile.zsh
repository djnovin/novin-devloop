#!/bin/zsh

set -e

SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"

# Check if Brewfile exists
if [[ -f "${PROJECT_DIR}/Brewfile" ]]; then
    echo "Installing packages from Brewfile..."
    cd "${PROJECT_DIR}"
    brew bundle install --verbose

    # Run FZF install script if it exists
    if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
        echo "Setting up FZF..."
        $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish 2>/dev/null || true
    fi

    echo "Brewfile packages installed."
else
    echo "No Brewfile found at ${PROJECT_DIR}/Brewfile"
    echo "Skipping Brewfile installation."
fi
