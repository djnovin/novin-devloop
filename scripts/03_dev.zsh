#!/bin/zsh

set -e

brew install fzf bat eza htop ripgrep fd neovim tmux zoxide tldr jq gh

$(brew --prefix)/opt/fzf/install --all
