#!/usr/bin/env bash
set -euo pipefail

# ─── Nix ────────────────────────────────────────────────────────
setup_nix() {
    if command -v nix &>/dev/null; then
        echo "Nix already installed, skipping"
        return
    fi
    echo "Installing Nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
}

# ─── CLI tools ──────────────────────────────────────────────────
install_tools() {
    local pkgs=(
        neovim
        tmux
        ripgrep
        fd
        fzf
        eza
        yazi
        btop
        fastfetch
        starship
        typst
        gitu
        stow
    )
    for pkg in "${pkgs[@]}"; do
        echo "Installing $pkg..."
        nix profile add nixpkgs#"$pkg"
    done
}

# ─── LSPs and formatters ────────────────────────────────────────
install_lsp() {
    local pkgs=(
        basedpyright
        ruff
        clang-tools
        neocmakelsp
        typescript-language-server
        vscode-langservers-extracted
        lua-language-server
        stylua
        rust-analyzer
        zls
        tinymist
        marksman
        nil
    )
    for pkg in "${pkgs[@]}"; do
        echo "Installing $pkg..."
        nix profile add nixpkgs#"$pkg"
    done
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
    local marker="# --- nix-dotfiles ---"

    if grep -q "$marker" "$rc" 2>/dev/null; then
        echo "Shell already configured, skipping"
        return
    fi

    cat >> "$rc" << 'EOF'

# --- nix-dotfiles ---
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
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

nix-add()     { NIXPKGS_ALLOW_UNFREE=1 nix profile add --impure nixpkgs#"$1"; }
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
    stow fontconfig tmux nvim
    fc-cache -fvr
}

# ─── Main ───────────────────────────────────────────────────────
main() {
    echo "==> Setting up Nix..."
    setup_nix

    echo "==> Installing CLI tools..."
    install_tools

    echo "==> Installing LSPs and formatters..."
    install_lsp

    echo "==> Installing fonts..."
    install_fonts

    echo "==> Configuring shell..."
    setup_shell

    echo "==> Stowing dotfiles..."
    run_stow

    echo "==> Done! Restart your shell."
}

main "$@"
