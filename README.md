# Dev setup

This repo contains my `neovim` and `tmux` configs that I use for development,
plus the tooling to reproduce my whole environment on any Linux distro.

Dependencies (CLI tools + LSPs/formatters) are managed with
[Pixi](https://pixi.sh) via its **global** environment, declared in
[`pixi/.pixi/manifests/pixi-global.toml`](pixi/.pixi/manifests/pixi-global.toml).

It also sets `Adwaita Mono Nerd Font` as the default monospace font.

## Setup

Full install (all tools + LSPs + fonts):

```
./install-all.sh
```

Minimal install (core tools + core LSPs, no fonts):

```
./bootstrap.sh
```

Then restart your shell.

## How dependencies work

All tools live in a single Pixi global environment named `dev`, declared
in `pixi/.pixi/manifests/pixi-global.toml`. `install-all.sh` stows that
manifest into `~/.pixi/manifests/` and runs `pixi global sync`, which makes
the installed environment match the manifest exactly.

Handy shell helpers (added to `.bashrc`):

| Command          | What it does                                  |
|------------------|-----------------------------------------------|
| `pixi-add <pkg>` | add a package to the `dev` env                |
| `pixi-remove <pkg>` | remove a package from the `dev` env        |
| `pixi-search <pkg>` | search conda-forge                         |
| `pixi-update`    | update all packages                           |
| `pixi-list`      | list installed packages                       |
| `pixi-sync`      | reconcile install with the manifest           |
| `pixi-gc`        | clean the pixi cache                           |

To add a tool permanently, run `pixi-add <pkg>` (it edits the manifest,
which is symlinked back into this repo) and commit the change.

> Note: packages come from **conda-forge**, whose names can differ from
> nixpkgs (e.g. the Neovim editor is `nvim`, not `neovim`).
