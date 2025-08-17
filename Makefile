BREW = "/home/linuxbrew/.linuxbrew/bin/brew"

all: brew_setup fonts utils run_stow

brew_setup:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$$HOME/.bashrc"
	echo "export PATH=$$PATH:$$HOME/.local/share/bob/nvim-bin" >> "$$HOME/.bashrc"
	echo 'export EDITOR="$$HOME/.local/share/bob/nvim-bin/nvim"' >> "$$HOME/.bashrc"

utils:
	$(BREW) install bob
	$(BREW) install yazi
	$(BREW) install tmux
	$(BREW) install stow
	$(BREW) install fzf
	$(BREW) install eza
	$(BREW) install fd
	$(BREW) install ripgrep
	$(BREW) install typst
	$(BREW) install btop
	$(BREW) install fastfetch
	$(BREW) install starship
	$(BREW) install gitu
	$(BREW) install just
	echo 'eval "$$(starship init bash)"' >> "$$HOME/.bashrc"
	/home/linuxbrew/.linuxbrew/bin/rustup-init -y
	. "$$HOME/.cargo/env"
	echo 'alias vim="nvim"' >> "$$HOME/.bashrc"
	echo 'alias ll="eza -la --icons --color=always"' >> "$$HOME/.bashrc"

fonts:
	$(BREW) install --cask font-adwaita font-adwaita-mono-nerd-font font-ibm-plex-sans font-ibm-plex-math font-twitter-color-emoji

run_stow:
	/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim zed
	fc-cache -fvr

zed_setup:
	curl -f https://zed.dev/install.sh | sh
