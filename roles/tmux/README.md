# tmux Configuration File

Self-contained, pretty and versatile `.tmux.conf` configuration file.

## Requirements

- `xclip` for X11 clipboard support

## Bindings

Use [tmux-pain-control][tmux-plugins-pain-control] for control pane:

- `<prefix> h` or `<prefix> C-h` select pane on the left
- `<prefix> j` or `<prefix> C-j` select pane below the current one
- `<prefix> k` or `<prefix> C-k` select pane above
- `<prefix> l` or `<prefix> C-l` select pane on the right
- `<prefix> S-h` resize current pane 5 cells to the left
- `<prefix> S-j` resize 5 cells in the down direction
- `<prefix> S-k` resize 5 cells in the up direction
- `<prefix> S-l` resize 5 cells to the right
- `<prefix> |` split current pane horizontally
- `<prefix> -` split current pane vertically
- `<prefix> \` split current pane full width hoizontally
- `<prefix> _` split current pane full width vertically
- `<prefix> <` moves current window one position to the left
- `<prefix> >` moves current window one position to the right
- `<prefix> M-,` and `<prefix> M-.` let you navigate window (default `<prefix> n` and `<prefix> p` are unbound)
- `<prefix> M-[0-9]` navigate window to number window
- `<prefix> Enter` enters copy-mode
- `<prefix> b` lists the paste-buffers
- `<prefix> p` pastes from the top paste-buffer (or from clipboard)
- `<prefix> P` lets you choose the paste-buffer to paste from

Bindings for `copy-mode-vi`:

- `v` begins selection / visual mode
- `C-v` toggles between blockwise visual mode and visual mode
- `H` jumps to the start of line
- `L` jumps to the end of line
- `y` copies the selection to the top paste-buffer (and to clipboard)
- `Escape` cancels the current operation

## Configuration

While this configuration tries to bring sane default settings, you may want to
customize it further to your needs. Instead of altering the `~/.tmux.conf` file
and diverging from upstream, the proper way is to edit the `~/.tmux/local.conf`
file.

```sh
# Create new local tmux configuration
$ touch $HOME/.tmux/local.conf
```

## Plugins

- [tmux-plugins/tmux-pain-control][tmux-plugins-pain-control]

## Inspired by

- [gpakosz/.tmux][gpakosz-tmux-repo]: 🇫🇷 Oh My Tmux! Pretty & versatile tmux configuration made with ❤️

<!-- LINKS -->

[gpakosz-tmux-repo]: https://github.com/gpakosz/.tmux
[chrisjohnsen-tmux-macosx-pasteboard-repo]: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
[tmux-plugins-pain-control]: https://github.com/tmux-plugins/tmux-pain-control

<!--
[//]: <> vim: set nofoldenable filetype=markdown :
-->
