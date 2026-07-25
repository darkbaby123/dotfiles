.PHONY: all install stow clean adopt check

STOW := $(PWD)/.stow-local/bin/stow
STOW_DIR := $(PWD)
PACKAGES := zsh git nvim ghostty mise psqlrc editorconfig opencode

all: install

# Full bootstrap: brew bundle → stow all packages
install:
	@echo "==> Running bootstrap.sh..."
	@bash bin/bootstrap.sh

# Stow (link) all packages - idempotent, safe to re-run
stow:
	@echo "==> Stowing packages: $(PACKAGES)"
	@for pkg in $(PACKAGES); do \
		echo "  stow $$pkg..."; \
		cd "$(STOW_DIR)" && $(STOW) -R $$pkg 2>/dev/null || \
		cd "$(STOW_DIR)" && $(STOW) $$pkg; \
	done
	@echo "==> Done"

# Adopt: pull existing $HOME files into the repo
# Use with caution - it overwrites repo files with $HOME versions
adopt:
	@echo "==> Adopting files from HOME (use with caution!)"
	@for pkg in $(PACKAGES); do \
		echo "  stow --adopt $$pkg..."; \
		cd "$(STOW_DIR)" && $(STOW) --adopt -R $$pkg; \
	done
	@echo "==> Done - review changes with 'git diff' before committing"

# Unstow (remove) all symlinks
clean:
	@echo "==> Removing stow symlinks..."
	@for pkg in $(PACKAGES); do \
		echo "  unstow $$pkg..."; \
		cd "$(STOW_DIR)" && $(STOW) -D $$pkg 2>/dev/null || true; \
	done
	@echo "==> Done"

# Check current symlink status
check:
	@echo "==> Checking stow status..."
	@cd "$(STOW_DIR)" && $(STOW) -n -R $(PACKAGES) 2>&1 || true
	@echo "==> Done"
