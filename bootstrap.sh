#!/usr/bin/env bash
set -euo pipefail

# Minimal setup: installs a core subset of tools with Pixi.
# For the full setup (all LSPs, fonts, starship, ...) use ./install-all.sh,
# which installs everything declared in ./pixi/.pixi/manifests/pixi-global.toml.

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

# ─── CLI tools + core LSPs (single 'dev' environment) ───────────
install_tools() {
  pixi global install --environment dev \
    nvim \
    ripgrep \
    fd-find \
    fzf \
    eza \
    yazi \
    stow \
    basedpyright \
    ruff \
    clang-tools \
    neocmakelsp
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
  stow nvim tmux
}

# ─── Main ───────────────────────────────────────────────────────
main() {
  echo "==> Setting up Pixi..."
  setup_pixi

  echo "==> Installing core tools & LSPs..."
  install_tools

  echo "==> Configuring shell..."
  setup_shell

  echo "==> Stowing dotfiles..."
  run_stow

  echo "==> Done! Restart your shell."
}

main "$@"
