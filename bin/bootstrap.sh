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
  # If dest is an actual directory (not a symlink), remove it first —
  # ln -sf into an existing dir creates the link inside it instead of
  # replacing it, which breaks the intended whole-directory symlink.
  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    echo "  removing real directory $dest → replacing with symlink"
    rm -rf "$dest"
  fi
  ln -sfv "$src" "$dest"
}

backup() {
  local file="$HOME/$1"
  local stamp="$(date +%Y%m%d)"
  if [ -L "$file" ]; then
    : # symlink — no backup needed, link_file will replace it
  elif [ -d "$file" ]; then
    local dest="${file}.bak.${stamp}"
    if [ ! -e "$dest" ]; then
      mv "$file" "$dest"
      echo "  moved directory $file → $dest"
    else
      echo "  skipping backup — $dest already exists"
    fi
  elif [ -f "$file" ]; then
    local dest="${file}.bak.${stamp}"
    cp "$file" "$dest"
    echo "  backed up $file → $dest"
  fi
}

# ------------------------------------------------------------------
#  zsh — Oh My Zsh + symlink
# ------------------------------------------------------------------

echo "==> zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
else
  echo "  Oh My Zsh already installed."
fi
backup ".zshrc"
link_file "zsh/.zshrc" ".zshrc"

# ------------------------------------------------------------------
#  Homebrew — all packages in one go
# ------------------------------------------------------------------

echo "==> Homebrew..."
if command -v brew &>/dev/null && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  brew bundle --file="$DOTFILES_DIR/Brewfile" || true
else
  echo "  Skipping (brew or Brewfile not found)"
fi

# ------------------------------------------------------------------
#  Git
# ------------------------------------------------------------------

echo "==> git..."
backup ".gitconfig"
link_file "git/.gitconfig" ".gitconfig"
backup ".gitignore_global"
link_file "git/.gitignore_global" ".gitignore_global"

# ------------------------------------------------------------------
#  Ghostty
# ------------------------------------------------------------------

echo "==> ghostty..."
backup ".config/ghostty"
link_file "ghostty" ".config/ghostty"

# ------------------------------------------------------------------
#  mise
# ------------------------------------------------------------------

echo "==> mise..."
backup ".config/mise"
link_file "mise" ".config/mise"
if command -v mise &>/dev/null; then
  echo "  Running mise install..."
  mise install || true
fi

# ------------------------------------------------------------------
#  Neovim (LazyVim)
# ------------------------------------------------------------------

echo "==> lazyvim..."
backup ".config/lazyvim"
link_file "lazyvim" ".config/lazyvim"

# LazyVim plugins auto-install on first launch
if command -v nvim &>/dev/null; then
  echo "  Installing LazyVim plugins (headless)..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
fi

# ------------------------------------------------------------------
#  postgres
# ------------------------------------------------------------------

echo "==> postgres..."
backup ".psqlrc"
link_file "postgres/.psqlrc" ".psqlrc"

# ------------------------------------------------------------------
#  Done
# ------------------------------------------------------------------

echo ""
echo "Done. Review any manual steps in LOCAL.md."
