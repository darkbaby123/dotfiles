#!/usr/bin/env bash
#
# bootstrap.sh — Idempotent dotfiles bootstrap.
#
# Installs Homebrew packages, creates symlinks for all managed config
# files, and runs any post-link initialization.
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ----- helpers -----

link_file() {
  local src="$DOTFILES_DIR/$1"
  local dest="$HOME/$2"
  mkdir -p "$(dirname "$dest")"
  ln -sfv "$src" "$dest"
}

backup() {
  local file="$HOME/$1"
  if [ -f "$file" ] && [ ! -L "$file" ]; then
    cp "$file" "${file}.bak.$(date +%Y%m%d)"
    echo "  backed up $file → ${file}.bak.$(date +%Y%m%d)"
  fi
}

# ----- Homebrew -----

echo "==> [1/3] Homebrew bundle..."
if command -v brew &>/dev/null && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
else
  echo "  Skipping (brew or Brewfile not found)"
fi

# ----- Symlinks -----

echo ""
echo "==> [2/3] Creating symlinks..."

# zsh
backup ".zshrc"
link_file "zsh/.zshrc" ".zshrc"

# git
backup ".gitconfig"
link_file "git/.gitconfig" ".gitconfig"
backup ".gitignore_global"
link_file "git/.gitignore_global" ".gitignore_global"

# ghostty
backup ".config/ghostty/config"
link_file "ghostty/.config/ghostty/config" ".config/ghostty/config"

# mise
backup ".config/mise/config.toml"
link_file "mise/.config/mise/config.toml" ".config/mise/config.toml"

# neovim
backup ".config/lazyvim"
link_file "nvim/.config/lazyvim" ".config/lazyvim"

# psqlrc
backup ".psqlrc"
link_file "psqlrc/.psqlrc" ".psqlrc"

# editorconfig
backup ".editorconfig"
link_file "editorconfig/.editorconfig" ".editorconfig"

# opencode
backup ".config/opencode"
link_file "opencode/.config/opencode" ".config/opencode"

# ----- Post-link -----

echo ""
echo "==> [3/3] Post-link..."

# mise: install tools listed in config
if command -v mise &>/dev/null && [ -f "$HOME/.config/mise/config.toml" ]; then
  echo "  Running mise install..."
  mise install || true
fi

# neovim: LazyVim auto-installs on first launch
if command -v nvim &>/dev/null; then
  echo "  LazyVim plugins will auto-install on first nvim launch."
fi

echo ""
echo "Done. Review any manual steps in LOCAL.md."
