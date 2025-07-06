#!/usr/bin/env bash

brew install just
brew install pipx
brew install node
brew install tmux
brew install stow
brew install fzf
brew install eza
brew install fd
brew install ripgrep
brew install typst
brew install btop
brew install fastfetch
brew install tmux-sessionizer
brew install starship
brew install gitui
brew install --cask font-adwaita font-adwaita-mono-nerd-font font-ibm-plex-sans font-ibm-plex-math font-twitter-color-emoji

echo 'eval "$$(starship init bash)"' >> "~/.bashrc"
echo 'alias vim="nvim"' >> "~/.bashrc"
echo 'alias ll="eza -la --icons --color=always"' >> "~/.bashrc"

stow fontconfig tmux nvim zed

fc-cache -fvr
