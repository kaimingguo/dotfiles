# dotfiles

[![GitHub last commit](https://img.shields.io/github/last-commit/kaimingguo/dotfiles?color=purple&style=for-the-badge)](https://github.com/kaimingguo/dotfiles/commits/main "Commit History")

My dotfiles, managed with [chezmoi](https://github.com/twpayne/chezmoi).

These configuration files work across macOS, Linux, WSL, Windows, and MSYS2,
and adapt themselves per-machine using chezmoi's templating and feature tags
(ephemeral, work, headless, personal).

## What's inside

| Tool | Files |
| ---- | ----- |
| **Shells** | `bash` (`.bashrc`, `.profile`, `.bash_logout`), `csh`/`tcsh` (`.cshrc`, `.login`, `.config/csh/`) |
| **Terminal** | `tmux` (`.tmux.conf`) |
| **Editor** | `vim`/`nvim` (`.vim/`, `.vimrc`, `.config/nvim`) |
| **Prompt** | [starship](https://starship.rs/) (`.config/starship.toml`) |
| **Git** | `.config/git/` (config, work config, global ignore) |
| **Tools** | [ripgrep](https://github.com/BurntSushi/ripgrep) (`.config/ripgrep/config`), `pycodestyle` |

## Installation

Install and apply the dotfiles in one command with the chezmoi one-line
installer:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply kaimingguo
```

If you already have chezmoi installed:

```sh
chezmoi init --apply kaimingguo
```

On first run chezmoi will prompt for a few machine details (whether the
machine is ephemeral or headless) and generate the local config at
`~/.config/chezmoi/chezmoi.toml`.

## Daily use

```sh
chezmoi edit ~/.bashrc   # edit a managed file in the source directory
chezmoi diff             # preview pending changes
chezmoi apply            # apply changes to your home directory
chezmoi update           # pull latest from the repo and apply
```

## Structure

Sources live under `home/` (see `.chezmoiroot`). Key pieces:

- `.chezmoi.toml.tmpl` — generates per-machine config and feature tags.
- `.chezmoidata/user.yaml` — user/git/github identity data used by templates.
- `.chezmoiignore` — files ignored per OS and per work/personal machine.
- `.chezmoitemplates/` — shared template snippets (e.g. starship, vim).
- `dot_*` — files that map to `~/.*` (e.g. `dot_bashrc` → `~/.bashrc`).
- `symlink_*` — files rendered as symlinks.
- `AppData/`, `vimfiles/` — Windows-specific counterparts.

## License

[BSD 3-Clause](LICENSE) © Kaiming Guo
