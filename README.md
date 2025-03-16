# Dev setup

This repo contains a my `neovim` and `tmux` config that I use for development.

Also has the fontalias with `Iosevka Extended` and `Nerd Font Symbols`.

Dependencies:
- `neovim`
- `tmux`
- `perl`
- `npm`
- `cargo`
- `make`
- `ninja`
- `meson`
- `stow`
- `fzf`

~~~
make all # Install fonts and runs stow for nvim, fontconfig and tmux
~~~

## Install apps

~~~
cargo install starship --locked
~~~

~~~
cargo install tmux-sessionizer --locked
~~~

