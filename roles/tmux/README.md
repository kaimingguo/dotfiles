# tmux Configuration File

Self-contained, pretty and versatile `.tmux.conf` configuration file.

## Requirements

### macOS specific requirements

Notes and workarounds for accessing the macOS pasteboard in tmux session. use
[reattach-to-user-namespace][chrisjohnsen-tmux-macosx-pasteboard-repo].

Alternatively, you can install it with __MacPorts__ or __Homebrew__:

```sh
# Install tool from MacPorts
sudo port install tmux-pasteboard

# Install tool from Homebrew
brew install reattach-to-user-namespace
```

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
