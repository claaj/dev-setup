# Dev setup

This repo contains a my `neovim`, `tmux` and `zed` config that I use for development.

Makefile installs all dependencies using `brew` and `brew` itself.

The idea of this is to be able to install my setup in any linux distro.

Also has a fontalias to set `Adwaita Mono Nerd Font` as the default Monospace font.

## Setup
~~~
# Super simple
make
~~~

To use `zed` in `Ubuntu 20.04` is necesary to update `Mesa` version.

It can be done using the following ppa:

~~~
sudo add-apt-repository ppa:kisak/turtle
sudo apt update
~~~
