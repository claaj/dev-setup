#!/usr/bin/env bash
set -euo pipefail

# ─── Pixi ───────────────────────────────────────────────────────
setup_pixi() {
  if command -v pixi &>/dev/null; then
    echo "Pixi already installed, skipping"
  else
    echo "Installing Pixi..."
    curl -fsSL https://pixi.sh/install.sh | bash
  fi
  export PATH="$HOME/.pixi/bin:$PATH"
}

# ─── Tools & LSPs (declarative) ─────────────────────────────────
# Everything is declared in ./pixi/.pixi/manifests/pixi-global.toml.
# We stow that manifest into ~/.pixi/manifests/ and let `pixi global
# sync` install exactly what it declares.
sync_pixi() {
  local target="$HOME/.pixi/manifests/pixi-global.toml"

  # If a real (non-symlink) manifest already exists, back it up so stow
  # can link ours without conflict.
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing manifest -> ${target}.bak"
    mv "$target" "${target}.bak"
  fi

  stow pixi
  pixi global sync
}

# ─── Fonts ──────────────────────────────────────────────────────
install_fonts() {
  mkdir -p ~/.local/share/fonts

  echo "Downloading Adwaita Mono Nerd Font..."
  curl -fLo /tmp/adwaita-nerd.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/AdwaitaMono.zip
  unzip -o /tmp/adwaita-nerd.zip -d ~/.local/share/fonts/

  rm -rf /tmp/adwaita-nerd.zip
  fc-cache -fvr
}

# ─── Shell config ───────────────────────────────────────────────
setup_shell() {
  local rc="$HOME/.bashrc"
  local marker="# --- pixi-dotfiles ---"

  # Drop any leftover nix-dotfiles block from a previous setup.
  if grep -q "# --- nix-dotfiles ---" "$rc" 2>/dev/null; then
    echo "Removing old nix-dotfiles shell block..."
    sed -i '/# --- nix-dotfiles ---/,/# --- end nix-dotfiles ---/d' "$rc"
  fi

  if grep -q "$marker" "$rc" 2>/dev/null; then
    echo "Shell already configured, skipping"
    return
  fi

  cat >> "$rc" << 'EOF'

# --- pixi-dotfiles ---
case ":$PATH:" in
  *":$HOME/.pixi/bin:"*) ;;
  *) export PATH="$HOME/.pixi/bin:$PATH" ;;
esac

eval "$(starship init bash)"
export EDITOR="nvim"
alias vim="nvim"
alias ll="eza -la --icons --color=always"

export FZF_DEFAULT_OPTS=" \
    --color=bg+:#202020,bg:#151515,spinner:#ffafaf,hl:#ff8700 \
    --color=fg:#dddddd,header:#ffaf5f,info:#ff8700,pointer:#ffafaf \
    --color=marker:#ff5f87,fg+:#c6b6ee,prompt:#ff8700,hl+:#ff8700 \
    --color=border:#151515 \
    --multi"

# pixi global helpers
pixi-add()    { pixi global install --environment dev "$1"; }
pixi-remove() { pixi global remove --environment dev "$1"; }
pixi-search() { pixi search "$1"; }
pixi-update() { pixi global update; }
pixi-list()   { pixi global list; }
pixi-sync()   { pixi global sync; }
pixi-gc()     { pixi clean cache; }
# --- end pixi-dotfiles ---
EOF
}

# ─── Stow dotfiles ──────────────────────────────────────────────
run_stow() {
  stow fontconfig tmux nvim
  fc-cache -fvr
}

# ─── Main ───────────────────────────────────────────────────────
main() {
  echo "==> Setting up Pixi..."
  setup_pixi

  echo "==> Installing tools & LSPs from manifest..."
  sync_pixi

  echo "==> Installing fonts..."
  install_fonts

  echo "==> Configuring shell..."
  setup_shell

  echo "==> Stowing dotfiles..."
  run_stow

  echo "==> Done! Restart your shell."
}

main "$@"
