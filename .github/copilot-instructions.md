# Copilot cloud agent onboarding for this repository

## Repository purpose and layout
- This repository is a **chezmoi-managed dotfiles repo**.
- The source root is `/home/runner/work/dotfiles/dotfiles/home` (see `/home/runner/work/dotfiles/dotfiles/.chezmoiroot`).
- Most changes should happen under `home/`, not in generated/applied files in a real `$HOME`.

## File mapping rules (important)
- `dot_*` files map to hidden files in home (example: `dot_bashrc` -> `~/.bashrc`).
- `private_*` files are for sensitive/local data patterns; never commit real secrets.
- `symlink_*` files represent symlinks managed by chezmoi.
- `*.tmpl` files are Go templates rendered by chezmoi.

## Edit the true source of truth
- Vim config is centralized in template files under:
  - `/home/runner/work/dotfiles/dotfiles/home/.chezmoitemplates/vim/`
- Starship config is centralized in:
  - `/home/runner/work/dotfiles/dotfiles/home/.chezmoitemplates/starship.toml`
- Wrapper files like `home/dot_vim/**/*.tmpl`, `home/vimfiles/**/*.tmpl`, and `home/dot_config/starship.toml.tmpl` usually only include shared templates.  
  Prefer editing the shared template once instead of duplicating logic in wrappers.

## Platform/host behavior
- Conditional behavior is driven by `/home/runner/work/dotfiles/dotfiles/home/.chezmoi.toml.tmpl` and `/home/runner/work/dotfiles/dotfiles/home/.chezmoiignore`.
- Key flags include `ephemeral`, `headless`, `work`, `personal`, and computed `osId` (`linux`, `wsl`, `windows`, `msys2`, etc.).
- Preserve existing conditionals unless the task explicitly requires behavior changes across platforms.

## Style and safety conventions
- Respect `/home/runner/work/dotfiles/dotfiles/.editorconfig` (LF, UTF-8, trim trailing whitespace; Markdown keeps trailing whitespace).
- C shell files in `home/dot_config/csh/**` intentionally use tabs (see modelines); do not auto-convert indentation.
- Keep changes surgical and avoid touching unrelated OS-specific paths.
- Never commit secrets/tokens; local secret examples belong in `home/dot_config/csh/create_private_login`.

## Validation approach
- There is no dedicated test suite in this repo.
- After edits, prefer lightweight checks:
  - `git diff --check`
  - If YAML changed: `yamllint` using `/home/runner/work/dotfiles/dotfiles/.yamllint`
  - If chezmoi is available: `chezmoi diff` and/or template rendering checks

## Errors encountered during onboarding
- Error: `chezmoi: command not found` when running `chezmoi --version` in this environment.
- Workaround used: relied on static review and repository-local checks; did not run chezmoi runtime validation commands in this sandbox.
