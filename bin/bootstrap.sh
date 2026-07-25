#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STOW="$DOTFILES_DIR/.stow-local/bin/stow"
BREWFILE="$DOTFILES_DIR/Brewfile"

echo "========================================"
echo "  Dotfiles Bootstrap"
echo "  Directory: $DOTFILES_DIR"
echo "========================================"

# ----- Step 1: Homebrew bundle -----
if command -v brew &>/dev/null; then
  echo ""
  echo "==> [1/4] Running brew bundle..."
  if [ -f "$BREWFILE" ]; then
    brew bundle --file="$BREWFILE" || echo "  (brew bundle had some issues, continuing...)"
  else
    echo "  No Brewfile found, skipping."
  fi
else
  echo ""
  echo "==> [1/4] Skipping brew bundle - Homebrew not found"
fi

# ----- Step 2: Stow all packages -----
echo ""
echo "==> [2/4] Stowing packages..."

# List all stow packages (directories that aren't bin/ or hidden)
PACKAGES=""
for dir in "$DOTFILES_DIR"/*/; do
  pkg=$(basename "$dir")
  case "$pkg" in
    bin|stow-local) ;;  # skip internal dirs
    *) PACKAGES="$PACKAGES $pkg" ;;
  esac
done

for pkg in $PACKAGES; do
  echo "  Linking: $pkg"
  cd "$DOTFILES_DIR" && "$STOW" -R "$pkg" 2>/dev/null || \
  cd "$DOTFILES_DIR" && "$STOW" "$pkg" || \
    echo "  Warning: failed to stow $pkg"
done

cd "$DOTFILES_DIR"

# ----- Step 3: Post-link initialization -----
echo ""
echo "==> [3/4] Post-link initialization..."

# mise: install tools listed in config
if command -v mise &>/dev/null && [ -f "$HOME/.config/mise/config.toml" ]; then
  echo "  Running mise install..."
  mise install || echo "  (mise install had some issues)"
fi

# Neovim: install plugins (LazyVim auto-installs on first launch)
if command -v nvim &>/dev/null; then
  echo "  Note: LazyVim plugins will auto-install on first nvim launch"
  echo "  Run 'nvim --headless \"+Lazy! sync\" +qa' to pre-install"
fi

# ----- Step 4: Summary -----
echo ""
echo "==> [4/4] Summary"
echo "  Packages stowed: $PACKAGES"
echo ""
echo "  Remaining manual steps (see LOCAL.md for details):"
echo "    1. Setup git local identity:  ~/.gitconfig_local"
echo "    2. Setup SSH config:          ~/.ssh/config"
echo "    3. Setup GPG config:          ~/.gnupg/gpg.conf"
echo "    4. Launch nvim to finish LazyVim plugin install"
echo ""
echo "========================================"
echo "  Bootstrap complete!"
echo "========================================"
