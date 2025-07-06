#!/usr/bin/env bash

BREW = "/home/linuxbrew/.linuxbrew/bin/brew"

$(BREW) install zig
$(BREW) install just
$(BREW) install pipx
$(BREW) install node
$(BREW) install tmux
$(BREW) install stow
$(BREW) install fzf
$(BREW) install eza
$(BREW) install fd
$(BREW) install ripgrep
$(BREW) install typst
$(BREW) install htop
$(BREW) install fastfetch
$(BREW) install tmux-sessionizer
$(BREW) install starship
$(BREW) install gitui
$(BREW) install --cask font-adwaita font-adwaita-mono-nerd-font font-ibm-plex-sans font-ibm-plex-math font-twitter-color-emoji

echo 'eval "$$(starship init bash)"' >> "$$HOME/.bashrc"
/home/linuxbrew/.linuxbrew/bin/rustup-init -y
. "$$HOME/.cargo/env"
echo 'alias vim="nvim"' >> "$$HOME/.bashrc"
echo 'alias ll="eza -la --icons --color=always"' >> "$$HOME/.bashrc"

/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim zed

fc-cache -fvr
