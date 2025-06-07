#!/bin/bash

# Dotfiles Backup Script
# Creates backups of existing configuration files before installation

set -e

BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Function to backup a file if it exists
backup_file() {
    local source="$1"
    local dest="$2"
    
    if [[ -e "$source" && ! -L "$source" ]]; then
        echo "📦 Backing up $source to $dest"
        mkdir -p "$(dirname "$dest")"
        cp -r "$source" "$dest"
    elif [[ -L "$source" ]]; then
        echo "🔗 Skipping symlink $source (already managed by dotfiles)"
    fi
}

# Backup configuration files
echo "📦 Backing up existing configuration files..."

backup_file "$HOME/.tmux.conf" "$BACKUP_DIR/.tmux.conf"
backup_file "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
backup_file "$HOME/.config/nvim" "$BACKUP_DIR/.config/nvim"
backup_file "$HOME/.config/ghostty" "$BACKUP_DIR/.config/ghostty"

# Additional zsh files
backup_file "$HOME/.zshenv" "$BACKUP_DIR/.zshenv"
backup_file "$HOME/.p10k.zsh" "$BACKUP_DIR/.p10k.zsh"

echo "✅ Backup completed!"
echo "📁 Backup location: $BACKUP_DIR"
echo ""
echo "To restore from backup:"
echo "  cp -r $BACKUP_DIR/.tmux.conf ~/.tmux.conf"
echo "  cp -r $BACKUP_DIR/.zshrc ~/.zshrc"
echo "  cp -r $BACKUP_DIR/.config/nvim ~/.config/nvim"
echo "  cp -r $BACKUP_DIR/.config/ghostty ~/.config/ghostty"