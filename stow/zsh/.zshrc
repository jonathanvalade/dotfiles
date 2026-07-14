# Zsh Options
    setopt EXTENDED_GLOB

# fzf
    eval "$(fzf --zsh)"

# Completion
    autoload -Uz compinit
    if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit
    else
        compinit -C
    fi

# History
    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt HIST_IGNORE_DUPS
    setopt SHARE_HISTORY

# Prompt
    PROMPT='%F{cyan}%n%f@%F{blue}%m%f %F{green}%~%f %# '

# Aliases
    # General
    alias ls="ls -G"
    alias ll="ls -lahG"
    alias ..="cd .."
    alias ...="cd ../.."

    # Nix
    alias update-mac='sudo darwin-rebuild switch --flake "$HOME/dotfiles/nix-darwin#jos-macbook-pro"'
    alias mac-update="update-mac"
