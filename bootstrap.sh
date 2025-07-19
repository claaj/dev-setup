#!/usr/bin/env bash

# Descargar e instalar Neovim
wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
mkdir -p $HOME/.local/bin
mv nvim-linux-x86_64 $HOME/.local/nvim
ln -sf $HOME/.local/nvim/bin/nvim $HOME/.local/bin/nvim
rm nvim-linux-x86_64.tar.gz

echo 'alias vim="$HOME/.local/nvim/bin/nvim"' >> $HOME/.bashrc

echo "Neovim instalado correctamente"

stow nvim/ tmux/
