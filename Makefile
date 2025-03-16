FONT_DIR := ~/.local/share/

all: copy_fonts run_stow 

copy_fonts:
	cp -r fonts $(FONT_DIR)

run_stow:
	stow fontconfig tmux nvim
	fc-cache -fvr
