#!/bin/zsh

set -e

SCRIPT_DIR="${0:A:h}"
PROJECT_DIR="${SCRIPT_DIR:h}"
DOTFILES_DIR="${PROJECT_DIR}/dotfiles"

# Check if dotfiles directory exists
if [[ ! -d "$DOTFILES_DIR" ]]; then
    echo "No dotfiles directory found at $DOTFILES_DIR"
    echo "Skipping dotfiles setup."
    exit 0
fi

# Check if GNU Stow is installed
if ! command -v stow &>/dev/null; then
    echo "GNU Stow not found. Installing via Homebrew..."
    brew install stow
fi

echo "Setting up dotfiles with GNU Stow..."

cd "$DOTFILES_DIR"

# Find all directories (packages) in dotfiles
for package in */; do
    if [[ -d "$package" ]]; then
        package_name="${package%/}"
        echo "Installing ${package_name} dotfiles..."

        # Try to stow the package, skip if conflicts exist
        if stow -n -t "$HOME" "$package_name" &>/dev/null; then
            stow -t "$HOME" "$package_name"
            echo "  ✓ ${package_name} installed"
        else
            echo "  ⚠ ${package_name} skipped (conflicts exist)"
        fi
    fi
done

echo "Dotfiles setup complete."
