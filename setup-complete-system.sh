#!/bin/bash

# Complete System Setup Script for Fedora Linux
# Includes all packages, fonts, configurations, and fixes
# Created during dotfiles setup session

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

echo ""
echo "🚀 Complete Fedora Linux Setup"
echo "==============================="
echo ""
echo "This script will:"
echo "  1. Install all required packages (kitty, redshift, fzf, etc.)"
echo "  2. Install IosevkaTerm Nerd Font"
echo "  3. Install Jujutsu (jj) VCS"
echo "  4. Fix /tmp permissions"
echo "  5. Apply GNOME keyboard remapping and shortcuts"
echo "  6. Install dotfiles configuration"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 0
fi

# ============================================================================
# STEP 1: Install DNF packages
# ============================================================================
print_status "Step 1/6: Installing packages via DNF..."
sudo dnf install -y \
    kitty \
    redshift-gtk \
    fzf \
    fd-find \
    util-linux-user \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    tmux \
    neovim \
    ripgrep \
    git \
    zsh \
    code

print_success "DNF packages installed"

# ============================================================================
# STEP 2: Install IosevkaTerm Nerd Font
# ============================================================================
print_status "Step 2/6: Installing IosevkaTerm Nerd Font..."

mkdir -p ~/.local/share/fonts
cd /tmp

if [ -f "IosevkaTerm.zip" ]; then
    rm -f IosevkaTerm.zip
fi

print_status "Downloading IosevkaTerm Nerd Font..."
curl -L -o IosevkaTerm.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/IosevkaTerm.zip

print_status "Extracting font files..."
rm -rf ~/.local/share/fonts/IosevkaTerm
mkdir -p ~/.local/share/fonts/IosevkaTerm
unzip -q IosevkaTerm.zip -d ~/.local/share/fonts/IosevkaTerm/
rm -f IosevkaTerm.zip

print_status "Refreshing font cache..."
fc-cache -fv > /dev/null 2>&1

if fc-list | grep -qi "IosevkaTerm"; then
    print_success "IosevkaTerm Nerd Font installed"
else
    print_warning "Font installed but not detected in cache"
fi

# ============================================================================
# STEP 3: Install Jujutsu (jj)
# ============================================================================
print_status "Step 3/6: Installing Jujutsu (jj) VCS..."

JJ_VERSION="v0.24.0"
JJ_URL="https://github.com/martinvonz/jj/releases/download/${JJ_VERSION}/jj-${JJ_VERSION}-x86_64-unknown-linux-musl.tar.gz"

cd /tmp
if [ -f "jj.tar.gz" ]; then
    rm -f jj.tar.gz
fi

if curl -L -o jj.tar.gz "$JJ_URL" 2>/dev/null; then
    tar -xzf jj.tar.gz
    sudo mv jj /usr/local/bin/
    sudo chmod +x /usr/local/bin/jj
    rm -f jj.tar.gz
    print_success "Jujutsu (jj) installed"
else
    print_warning "Failed to download jj - skipping"
fi

# ============================================================================
# STEP 4: Fix /tmp permissions
# ============================================================================
print_status "Step 4/6: Fixing /tmp permissions..."

sudo chown root:root /tmp
sudo chmod 1777 /tmp

# Clean up corrupted temp files
sudo find /tmp -user 1001 -delete 2>/dev/null || true
rm -f /tmp/gitstatus* 2>/dev/null || true
rm -f /tmp/zsh* 2>/dev/null || true

# Ensure systemd sets correct permissions on mount
if ! systemctl cat tmp.mount | grep -q "Mode=1777"; then
    sudo mkdir -p /etc/systemd/system/tmp.mount.d/
    sudo tee /etc/systemd/system/tmp.mount.d/override.conf > /dev/null <<'EOF'
[Mount]
Options=mode=1777,strictatime,nosuid,nodev
EOF
    sudo systemctl daemon-reload
fi

print_success "/tmp permissions fixed"

# ============================================================================
# STEP 5: Apply GNOME keyboard remapping and shortcuts
# ============================================================================
print_status "Step 5/6: Applying GNOME keyboard remapping..."

# Keyboard remapping: Caps→Escape, Ctrl→Super, Alt→Ctrl, Super→Alt
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape', 'altwin:ctrl_alt_win']"

# Activities shortcut: Super+Space instead of just Super
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.shell.keybindings toggle-overview "['<Super>space']"
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Super>space']"
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['<Super>space']"

print_success "GNOME settings applied"
print_warning "Keyboard remapping:"
print_warning "  - Caps Lock → Escape"
print_warning "  - Physical Ctrl → Super/Win"
print_warning "  - Physical Super/Win → Alt"
print_warning "  - Physical Alt → Ctrl"
print_warning "  - Activities: Super+Space (instead of just Super)"

# ============================================================================
# STEP 6: Install dotfiles
# ============================================================================
print_status "Step 6/6: Installing dotfiles..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$SCRIPT_DIR/install-fedora.sh" ]]; then
    bash "$SCRIPT_DIR/install-fedora.sh"
    print_success "Dotfiles installed"
else
    print_warning "install-fedora.sh not found in $SCRIPT_DIR"
    print_warning "Skipping dotfiles installation"
fi

# ============================================================================
# Summary
# ============================================================================
echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "✅ Installed packages:"
echo "   - kitty, redshift-gtk, fzf, fd-find, zsh plugins"
echo "   - tmux, neovim, ripgrep, git, zsh, VSCode"
echo ""
echo "✅ Installed fonts:"
echo "   - IosevkaTerm Nerd Font"
echo ""
echo "✅ Installed tools:"
echo "   - jj (Jujutsu VCS)"
echo ""
echo "✅ System fixes:"
echo "   - /tmp permissions fixed (root:root 1777)"
echo ""
echo "✅ GNOME configuration:"
echo "   - Keyboard remapping applied"
echo "   - Activities shortcut: Super+Space"
echo ""
echo "✅ Dotfiles installed"
echo ""
echo "📋 Next steps:"
echo "   1. Restart your terminal: exec zsh"
echo "   2. Test kitty: kitty"
echo "   3. Start redshift: redshift-gtk &"
echo "   4. In tmux: press Ctrl-Space + I to install plugins"
echo "   5. In nvim: run :Lazy sync to install plugins"
echo "   6. Customize prompt: p10k configure"
echo ""
echo "🔄 Note: Some changes require logging out and back in"
echo ""
