BREW = "/home/linuxbrew/.linuxbrew/bin/brew"

all: brew_setup fonts utils run_stow

brew_setup:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$$HOME/.bashrc"
	echo "export PATH=$$PATH:$$HOME/.local/bin/" >> "$$HOME/.bashrc"
	echo "export PATH=$$PATH:$$HOME/.local/share/bob/nvim-bin" >> "$$HOME/.bashrc"
	echo 'export EDITOR="$$HOME/.local/share/bob/nvim-bin/nvim"' >> "$$HOME/.bashrc"
	echo 'export FZF_DEFAULT_OPTS=" \
			--color=bg+:#202020,bg:#151515,spinner:#ffafaf,hl:#ff8700 \
			--color=fg:#dddddd,header:#ffaf5f,info:#ff8700,pointer:#ffafaf \
			--color=marker:#ff5f87,fg+:#c6b6ee,prompt:#ff8700,hl+:#ff8700 \
			--color=border:#151515 \
			--multi"' >> "$$HOME/.bashrc"

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
	mkdir -p ~/.local/bin
	/home/linuxbrew/.linuxbrew/bin/stow fontconfig tmux nvim zed scripts
	fc-cache -fvr

zed_setup:
	curl -f https://zed.dev/install.sh | sh
