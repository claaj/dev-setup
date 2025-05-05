BREW = "/home/linuxbrew/.linuxbrew/bin/brew"

all: brew_setup fonts utils run_stow 

brew_setup:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$$HOME/.bashrc"

utils:
	$(BREW) install llvm zig cmake 
	$(BREW) install just meson ninja 
	$(BREW) install python pip-tools pipx 
	$(BREW) install rustup node nodejs lld
	$(BREW) install nvim tmux stow fzf 
	$(BREW) install eza fd ripgrep typst
	$(BREW) install htop fastfetch tmux-sessionizer starship
	echo 'eval "$$(starship init bash)"' >> "$$HOME/.bashrc"
	/home/linuxbrew/.linuxbrew/bin/rustup-init -y
	. "$$HOME/.cargo/env"
	echo 'alias vim="nvim"' >> "$$HOME/.bashrc"
	echo 'alias ll="eza -la --icons --color=always"' >> "$$HOME/.bashrc"

fonts:
	$(BREW) install --cask font-adwaita font-adwaita-mono-nerd-font font-ibm-plex-sans font-ibm-plex-math font-twitter-color-emoji

run_stow:
	/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim
	fc-cache -fvr
