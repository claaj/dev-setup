BREW = "/home/linuxbrew/.linuxbrew/bin/brew"

all: brew_setup fonts utils zed run_stow

brew_setup:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$$HOME/.bashrc"

utils:
	$(BREW) install llvm cmake
	$(BREW) install zig
	$(BREW) install cmake
	$(BREW) install just
	$(BREW) install meson
	$(BREW) install ninja
	$(BREW) install python
	$(BREW) install pip-tools
	$(BREW) install pipx
	$(BREW) install rustup
	$(BREW) install node
	$(BREW) install nodejs
	$(BREW) install lld
	$(BREW) install nvim
	$(BREW) install tmux
	$(BREW) install stow
	$(BREW) install fzf
	$(BREW) install eza
	$(BREW) install fd
	$(BREW) install ripgrep
	$(BREW) install typst
	$(BREW) install htop
	$(BREW) install fastfetch
	$(BREW) install tmux-sessionizer
	$(BREW) install starship
	$(BREW) install gitui
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
