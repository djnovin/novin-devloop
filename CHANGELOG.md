# 🧾 Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [1.1.0] - 2024-12-19
### Added
- Brewfile for declarative package management with Homebrew Bundle
- GNU Stow integration for dotfile management
- Example dotfile packages for git and zsh configurations
- New modular script structure with atomic scripts

### Changed
- Refactored setup.zsh to be minimal - just runs all scripts
- Reorganized scripts into focused, atomic units:
  - 01_prerequisites.zsh: Xcode & Homebrew setup
  - 02_brewfile.zsh: Package installation via Brewfile
  - 03_languages.zsh: Language runtime setup
  - 04_dotfiles.zsh: Dotfile symlinking with Stow
- Simplified README with clearer documentation

### Removed
- Individual package installation scripts (replaced by Brewfile)
- Redundant script files for core, dev, containers, cli, and apps

---

## [1.0.0] - 2025-10-27
### Added
- Initial setup scripts for macOS developer environment.
- Modular `scripts/` directory with language, CLI, and GUI installers.
- Xcode Command Line Tools and Homebrew bootstrap.
- Core language support: Python, Rust, Go, .NET, Java, Node.js.
- CLI utilities: fzf, bat, eza, htop, ripgrep, fd, neovim, tmux.
- GUI apps: browsers, Docker, Raycast, Zed, Obsidian, Slack, etc.
- `LICENSE` (MIT), `README.md`, `.gitignore`, `.editorconfig`.
- `VERSION` file for release tracking.
