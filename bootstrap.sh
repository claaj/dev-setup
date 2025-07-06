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
/home/linuxbrew/.linuxbrew/bin/brew install tmux-sessionizer

echo 'alias vim="nvim"' >> $HOME/.bashrc
echo 'alias ll="eza -la --icons --color=always"' >> $HOME/.bashrc

/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim zed
