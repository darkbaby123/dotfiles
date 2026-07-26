#!/usr/bin/env bash
#
# bootstrap.sh — Idempotent dotfiles bootstrap.
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ------------------------------------------------------------------
#  Helpers
# ------------------------------------------------------------------

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

# ------------------------------------------------------------------
#  Homebrew — all packages in one go
# ------------------------------------------------------------------

echo "==> [1] Homebrew..."
if command -v brew &>/dev/null && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
else
  echo "  Skipping (brew or Brewfile not found)"
fi

# ------------------------------------------------------------------
#  zsh
# ------------------------------------------------------------------

echo "==> [2] zsh..."
backup ".zshrc"
link_file "zsh/.zshrc" ".zshrc"

# ------------------------------------------------------------------
#  Git
# ------------------------------------------------------------------

echo "==> [3] git..."
backup ".gitconfig"
link_file "git/.gitconfig" ".gitconfig"
backup ".gitignore_global"
link_file "git/.gitignore_global" ".gitignore_global"

# ------------------------------------------------------------------
#  Neovim (LazyVim)
# ------------------------------------------------------------------

echo "==> [4] lazyvim..."
backup ".config/lazyvim"
link_file "lazyvim" ".config/lazyvim"

# LazyVim plugins auto-install on first launch
if command -v nvim &>/dev/null; then
  echo "  Installing LazyVim plugins (headless)..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
fi

# ------------------------------------------------------------------
#  Done
# ------------------------------------------------------------------

echo ""
echo "Done. Review any manual steps in LOCAL.md."
