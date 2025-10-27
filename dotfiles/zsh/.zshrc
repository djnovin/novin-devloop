# ============================================================================
# Zsh Configuration
# ============================================================================

# --------------------------------------------------------------------------
# Environment Variables
# --------------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# --------------------------------------------------------------------------
# Path Configuration
# --------------------------------------------------------------------------
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# --------------------------------------------------------------------------
# History Configuration
# --------------------------------------------------------------------------
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# --------------------------------------------------------------------------
# Zsh Options
# --------------------------------------------------------------------------
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt GLOB_DOTS

# --------------------------------------------------------------------------
# Completion System
# --------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# --------------------------------------------------------------------------
# Key Bindings
# --------------------------------------------------------------------------
bindkey -e  # Emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# --------------------------------------------------------------------------
# Aliases
# --------------------------------------------------------------------------
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# List files
alias ls='eza --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias lt='eza -T --icons --group-directories-first'
alias l='eza --icons --group-directories-first'

# Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# Common commands
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'
alias cat='bat'
alias vim='nvim'
alias vi='nvim'
alias mkdir='mkdir -pv'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick edits
alias zshrc='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'
alias gitconfig='$EDITOR ~/.gitconfig'

# Reload configuration
alias reload='source ~/.zshrc'

# --------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------
# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar e "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find in current directory
f() {
    find . -name "*$1*" 2>/dev/null
}

# Grep in current directory
gr() {
    grep -r "$1" . 2>/dev/null
}

# --------------------------------------------------------------------------
# Tool Integrations
# --------------------------------------------------------------------------
# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust/Cargo
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Python/Pyenv
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# .NET
export PATH="$PATH:/usr/local/share/dotnet"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# FZF (Fuzzy Finder)
if command -v fzf &>/dev/null; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# Zoxide (Better cd)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# Starship Prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# Direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# Atuin (Shell History)
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

# --------------------------------------------------------------------------
# Local Configuration
# --------------------------------------------------------------------------
# Source local configuration if it exists
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
