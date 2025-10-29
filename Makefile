# Dotfiles Makefile
# Provides convenient commands for managing the dotfiles

.PHONY: help install backup clean test

# Default target
help: ## Show this help message
	@echo "Dotfiles Management Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install all dotfiles configurations
	@./install.sh

backup: ## Create backup of existing configurations
	@./backup.sh

install-tmux: ## Install only tmux configuration
	@./install.sh --tmux

install-nvim: ## Install only neovim configuration
	@./install.sh --nvim

install-ghostty: ## Install only ghostty configuration
	@./install.sh --ghostty

install-kitty: ## Install only kitty configuration
	@./install.sh --kitty

install-zsh: ## Install only zsh configuration
	@./install.sh --zsh

clean: ## Remove all symlinks (restore to pre-dotfiles state)
	@echo "Removing dotfiles symlinks..."
	@find ~ -maxdepth 3 -type l -exec sh -c 'readlink "$$1" | grep -q "$(PWD)" && rm "$$1" && echo "Removed: $$1"' _ {} \;
	@echo "Symlinks removed. You may want to restore from backup."

test: ## Test the installation script (dry run)
	@echo "Testing installation script..."
	@bash -n install.sh && echo "✅ install.sh syntax is valid"
	@bash -n backup.sh && echo "✅ backup.sh syntax is valid"

update: ## Update the repository and reinstall
	@git pull origin main
	@./install.sh
