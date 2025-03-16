FONT_DIR := ~/.local/share/

all: copy_fonts run_stow 

copy_fonts:
	./setup-fonts.sh

run_stow:
	stow fontconfig tmux nvim
	fc-cache -fvr
