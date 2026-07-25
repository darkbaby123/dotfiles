# dotfiles

Personal macOS dotfiles.

## Overview

Each tool/package has its own directory whose internal path mirrors `$HOME`.
`bin/bootstrap.sh` creates symlinks for all managed files and runs post-link setup.

```
dotfiles/
├── zsh/
│   └── .zshrc                    →  ~/.zshrc
├── git/
│   ├── .gitconfig                →  ~/.gitconfig
│   └── .gitignore_global         →  ~/.gitignore_global
├── ghostty/
│   └── .config/ghostty/config    →  ~/.config/ghostty/config
├── Brewfile                      # Homebrew packages (CLI + Cask)
├── bin/bootstrap.sh              # Single entry point
└── LOCAL.md                      # Private config checklist (gitignored)
```

## Quick Start

### New machine

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
./bin/bootstrap.sh
```

### Existing machine (re-run is safe)

```bash
cd ~/code/personal/dotfiles
./bin/bootstrap.sh
```

The script is **idempotent** — running it multiple times is safe.

## Daily Usage

**Edit** configs directly in the `dotfiles/` directory — symlinks sync instantly.

**Add** a new file to an existing package: place it in the right subdirectory,
then re-run `./bin/bootstrap.sh` to create the symlink.

**Add** a new package: create a new directory (e.g., `ghostty/.config/ghostty/config`),
add a `link_file` line to `bootstrap.sh`, then re-run it.

## Private / Sensitive Config

Some files contain personal info (email, SSH keys, proxy settings) and are
**not** stored in this public repo. See `LOCAL.md` for the full checklist.

## What's Managed

- **zsh** — Oh My Zsh, proxy, mise, Neovim aliases
- **git** — aliases, global ignore, LFS, osxkeychain
- **ghostty** — terminal config
- **mise** — dev tools version manager
- **neovim** — LazyVim
- **psqlrc** — PostgreSQL client
- **editorconfig** — cross-editor formatting
- **opencode** — AI coding assistant

## License

MIT
