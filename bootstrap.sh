#!/usr/bin/env bash

wget https://github.com/MordechaiHadad/bob/releases/download/v4.0.3/bob-linux-x86_64.zip
unzip bob-linux-x86_64.zip
chmod +x bob
mkdir -p ~/.local/bin
mv bob ~/.local/bin/bob
rm bob-linux-x86_64.zip

echo 'alias vim="nvim"' >> "~/.bashrc"
echo 'export PATH=$PATH:$HOME/.local/share/bob/nvim-bin' >> "~/.bashrc"

echo "bob-nvim instalado correctamente"

stow nvim/ tmux/
