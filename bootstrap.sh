#!/usr/bin/env bash
set -euo pipefail

# ─── Nix ────────────────────────────────────────────────────────
setup_nix() {
  if command -v nix &>/dev/null; then
    echo "Nix already installed, skipping"
    return
  fi
  echo "Installing Nix..."
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon --yes
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

# ─── CLI tools ──────────────────────────────────────────────────
install_tools() {
   export NIX_CONFIG="experimental-features = nix-command flakes
allow-unfree = true"

    local pkgs=(
        neovim
        ripgrep
        fd
        fzf
        eza
        yazi
        stow
    )
    nix profile add "${pkgs[@]/#/nixpkgs#}"
}

# ─── LSPs and formatters ────────────────────────────────────────
install_lsp() {
    export NIX_CONFIG="experimental-features = nix-command flakes
allow-unfree = true"

    local pkgs=(
        basedpyright
        ruff
        clang-tools
        neocmakelsp
    )
    nix profile add "${pkgs[@]/#/nixpkgs#}"
}

# ─── Shell config ───────────────────────────────────────────────
setup_shell() {
    local rc="$HOME/.bashrc"
    local marker="# --- nix-dotfiles ---"

    if grep -q "$marker" "$rc" 2>/dev/null; then
        echo "Shell already configured, skipping"
        return
    fi

    cat >> "$rc" << 'EOF'

# --- nix-dotfiles ---
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
export EDITOR="nvim"
alias vim="nvim"
alias ll="eza -la --icons --color=always"

export FZF_DEFAULT_OPTS=" \
		--color=bg+:#202020,bg:#151515,spinner:#ffafaf,hl:#ff8700 \
		--color=fg:#dddddd,header:#ffaf5f,info:#ff8700,pointer:#ffafaf \
		--color=marker:#ff5f87,fg+:#c6b6ee,prompt:#ff8700,hl+:#ff8700 \
		--color=border:#151515 \
		--multi"

export NIX_CONFIG="experimental-features = nix-command flakes
allow-unfree = true"

nix-add()     { nix profile add nixpkgs#"$1"; }
nix-remove()  { nix profile remove nixpkgs#"$1"; }
nix-search()  { nix search nixpkgs "$1"; }
nix-upgrade() { nix profile upgrade --all; }
nix-list()    { nix profile list; }
nix-gc()      { nix-collect-garbage -d; }
# --- end nix-dotfiles ---
EOF
}

# ─── Stow dotfiles ──────────────────────────────────────────────
run_stow() {
    stow nvim tmux
}

# ─── Main ───────────────────────────────────────────────────────
main() {
    echo "==> Setting up Nix..."
    setup_nix

    echo "==> Installing CLI tools..."
    install_tools

    echo "==> Installing LSPs and formatters..."
    install_lsp

    echo "==> Configuring shell..."
    setup_shell

    echo "==> Stowing dotfiles..."
    run_stow

    echo "==> Done! Restart your shell."
}

main "$@"
