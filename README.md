# novin-devloop

Simple, modular macOS development environment setup.

## Quick Start

```bash
git clone https://github.com/yourusername/novin-devloop.git
cd novin-devloop
./setup.zsh
```

## What It Does

1. **Prerequisites** - Installs Xcode Command Line Tools and Homebrew
2. **Packages** - Installs all packages from Brewfile using `brew bundle`
3. **Languages** - Sets up Rust, Node.js (via NVM), and Python
4. **Dotfiles** - Symlinks configuration files using GNU Stow

## Structure

```
novin-devloop/
├── setup.zsh                 # Main setup script (runs all scripts)
├── Brewfile                  # Homebrew packages declaration
├── scripts/                  # Modular setup scripts
│   ├── 01_prerequisites.zsh # Xcode & Homebrew
│   ├── 02_brewfile.zsh      # Install from Brewfile
│   ├── 03_languages.zsh     # Language setup (Rust, Node, Python)
│   └── 04_dotfiles.zsh      # Dotfiles with GNU Stow
└── dotfiles/                 # Configuration files
    ├── git/
    │   └── .gitconfig
    └── zsh/
        └── .zshrc
```

## Customization

### Add Packages

Edit the `Brewfile`:
```ruby
brew "neovim"
cask "visual-studio-code"
```

### Add Dotfiles

1. Create a directory in `dotfiles/`
2. Add your config files (mirror home directory structure)
3. Run `./scripts/04_dotfiles.zsh` to install

Example:
```bash
mkdir -p dotfiles/vim
cp ~/.vimrc dotfiles/vim/
cd dotfiles && stow vim
```

### Manual Stow Commands

```bash
cd dotfiles
stow vim          # Install vim configs
stow -D vim       # Uninstall vim configs
stow -R vim       # Reinstall vim configs
```

## Troubleshooting

If stow reports conflicts:
```bash
cd dotfiles
stow --adopt vim  # Adopt existing files
```

## License

MIT