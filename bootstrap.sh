#!/usr/bin/env bash

wget https://github.com/MordechaiHadad/bob/releases/download/v4.0.3/bob-linux-x86_64.zip
unzip bob-linux-x86_64.zip
chmod +x bob
mkdir -p $HOME/.local/bin
mv bob $HOME/.local/bin/bob-nvim
rm bob-linux-x86_64.zip

echo 'alias vim="nvim"' >> $HOME/.bashrc
echo 'export PATH=$PATH:$HOME/.local/share/bob/nvim-bin' >> "$HOME/.bashrc"

echo "bob-nvim instalado correctamente"

stow nvim/ tmux/


