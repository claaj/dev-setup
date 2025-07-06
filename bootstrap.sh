#!/usr/bin/env bash

/home/linuxbrew/.linuxbrew/bin/brew install just
/home/linuxbrew/.linuxbrew/bin/brew install pipx
/home/linuxbrew/.linuxbrew/bin/brew install node
/home/linuxbrew/.linuxbrew/bin/brew install tmux
/home/linuxbrew/.linuxbrew/bin/brew install stow
/home/linuxbrew/.linuxbrew/bin/brew install fzf
/home/linuxbrew/.linuxbrew/bin/brew install eza
/home/linuxbrew/.linuxbrew/bin/brew install fd
/home/linuxbrew/.linuxbrew/bin/brew install ripgrep
/home/linuxbrew/.linuxbrew/bin/brew install typst
/home/linuxbrew/.linuxbrew/bin/brew install btop
/home/linuxbrew/.linuxbrew/bin/brew install fastfetch
/home/linuxbrew/.linuxbrew/bin/brew install tmux-sessionizer
/home/linuxbrew/.linuxbrew/bin/brew install starship
/home/linuxbrew/.linuxbrew/bin/brew install gitui
/home/linuxbrew/.linuxbrew/bin/brew install --cask font-adwaita font-adwaita-mono-nerd-font font-ibm-plex-sans font-ibm-plex-math font-twitter-color-emoji

touch ~/.bashrc

echo 'eval "$$(starship init bash)"' >> "~/.bashrc"
echo 'alias vim="nvim"' >> "~/.bashrc"
echo 'alias ll="eza -la --icons --color=always"' >> "~/.bashrc"

/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim zed
