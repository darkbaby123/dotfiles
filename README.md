# dotfiles

Personal macOS dotfiles.

## Overview

Each tool/package has its own directory. `bin/bootstrap.sh` creates symlinks
for all managed files and runs post-link setup.

```
dotfiles/
├── zsh/
│   └── .zshrc                    →  ~/.zshrc
├── git/
│   ├── .gitconfig                →  ~/.gitconfig
│   └── .gitignore_global         →  ~/.gitignore_global
├── ghostty/                      →  ~/.config/ghostty/
├── mise/                         →  ~/.config/mise/
├── lazyvim/                      →  ~/.config/lazyvim/
├── postgres/
│   └── .psqlrc                   →  ~/.psqlrc
├── Brewfile                      # Homebrew packages (CLI + Cask)
├── bin/bootstrap.sh              # Single entry point
└── LOCAL.md                      # Private config checklist (gitignored)
```

## Bootstrap Order

```
 1  zsh       — Oh My Zsh install + .zshrc symlink
 2  Homebrew  — brew bundle (Brewfile)
 3  git       — .gitconfig + .gitignore_global
 4  ghostty   — terminal config
 5  mise      — dev tools + mise install
 6  lazyvim   — LazyVim config + headless plugin install
 7  postgres  — .psqlrc
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

The script is **idempotent** — running it multiple times is safe. Existing
files are backed up before symlinks are created.

## Daily Usage

**Edit** configs directly in the `dotfiles/` directory — symlinks sync instantly.

**Add** a new file: place it in the right directory, add a `link_file` line
to `bootstrap.sh`, then re-run it.

## Private / Sensitive Config

Some files contain personal info (email, SSH keys, API keys) and are
**not** stored in this public repo. See `LOCAL.md` for the full checklist:

- `~/.gitconfig_local` — name, email, proxy
- `~/.ssh/config` — SSH keys, jump hosts
- `~/.gnupg/gpg.conf` — GPG settings
- `~/.zshrc_local` — machine-specific aliases
- `~/.config/opencode/opencode.json` — AI provider API keys

## What's Managed

- **zsh** — Oh My Zsh, proxy, mise, Neovim aliases
- **git** — aliases, global ignore, LFS, osxkeychain
- **ghostty** — terminal config (IosevkaTerm Nerd Font Mono)
- **mise** — dev tools version manager (erlang, elixir)
- **lazyvim** — LazyVim with custom tokyonight theme, Elixir/expert LSP, markdown-table-mode
- **postgres** — psql display settings (timing, null, pager, expanded)

## License

MIT
