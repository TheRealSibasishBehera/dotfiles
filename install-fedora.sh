#!/bin/bash

# Dotfiles Installation Script for Fedora/Linux
# Installs development environment configurations with plug-and-play setup

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_ALL=true
INSTALL_TMUX=false
INSTALL_NVIM=false
INSTALL_KITTY=false
INSTALL_ZSH=false
SKIP_DEPS=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --tmux)
            INSTALL_ALL=false
            INSTALL_TMUX=true
            shift
            ;;
        --nvim)
            INSTALL_ALL=false
            INSTALL_NVIM=true
            shift
            ;;
        --kitty)
            INSTALL_ALL=false
            INSTALL_KITTY=true
            shift
            ;;
        --zsh)
            INSTALL_ALL=false
            INSTALL_ZSH=true
            shift
            ;;
        --skip-deps)
            SKIP_DEPS=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --tmux      Install only tmux configuration"
            echo "  --nvim      Install only neovim configuration"
            echo "  --kitty     Install only kitty configuration"
            echo "  --zsh       Install only zsh configuration"
            echo "  --skip-deps Skip dependency installation"
            echo "  -h, --help  Show this help message"
            echo ""
            echo "Without options, installs all configurations."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Helper functions
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

# Check if running on Linux
check_linux() {
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        print_error "This script is designed for Linux only."
        exit 1
    fi
}

# Detect package manager
detect_package_manager() {
    if command -v dnf &> /dev/null; then
        PKG_MANAGER="dnf"
    elif command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
    elif command -v pacman &> /dev/null; then
        PKG_MANAGER="pacman"
    else
        print_error "No supported package manager found (dnf, apt, or pacman)"
        exit 1
    fi
    print_status "Detected package manager: $PKG_MANAGER"
}

# Install dependencies
install_dependencies() {
    if [[ "$SKIP_DEPS" == true ]]; then
        print_warning "Skipping dependency installation"
        return
    fi

    print_status "Installing dependencies via $PKG_MANAGER..."

    case $PKG_MANAGER in
        dnf)
            sudo dnf install -y \
                tmux \
                neovim \
                fzf \
                ripgrep \
                fd-find \
                git \
                zsh \
                util-linux-user \
                kitty

            # Install zsh plugins from COPR or manual install
            print_status "Installing zsh plugins..."

            # Check if zsh-syntax-highlighting is available
            if ! sudo dnf install -y zsh-syntax-highlighting 2>/dev/null; then
                print_warning "Installing zsh-syntax-highlighting manually..."
                if [[ ! -d /usr/share/zsh-syntax-highlighting ]]; then
                    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
                        /usr/share/zsh-syntax-highlighting
                fi
            fi

            # Check if zsh-autosuggestions is available
            if ! sudo dnf install -y zsh-autosuggestions 2>/dev/null; then
                print_warning "Installing zsh-autosuggestions manually..."
                if [[ ! -d /usr/share/zsh-autosuggestions ]]; then
                    sudo git clone https://github.com/zsh-users/zsh-autosuggestions \
                        /usr/share/zsh-autosuggestions
                fi
            fi
            ;;
        apt)
            sudo apt update
            sudo apt install -y \
                tmux \
                neovim \
                fzf \
                ripgrep \
                fd-find \
                git \
                zsh \
                kitty \
                zsh-syntax-highlighting \
                zsh-autosuggestions
            ;;
        pacman)
            sudo pacman -Sy --noconfirm \
                tmux \
                neovim \
                fzf \
                ripgrep \
                fd \
                git \
                zsh \
                kitty \
                zsh-syntax-highlighting \
                zsh-autosuggestions
            ;;
    esac

    # Install fzf shell integration
    if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
        print_success "fzf shell integration available"
    fi

    print_success "Dependencies installed"
}

# Create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"

    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Backup existing file if it exists and is not a symlink
    if [[ -e "$target" && ! -L "$target" ]]; then
        print_warning "Backing up existing $target to ${target}.backup"
        mv "$target" "${target}.backup"
    fi

    # Remove existing symlink
    if [[ -L "$target" ]]; then
        rm "$target"
    fi

    # Create symlink
    ln -sf "$source" "$target"
    print_success "Linked $source -> $target"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_status "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        print_success "Oh My Zsh already installed"
    fi
}

# Install Powerlevel10k theme
install_powerlevel10k() {
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        print_status "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    else
        print_success "Powerlevel10k already installed"
    fi
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        print_status "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        print_warning "Don't forget to run 'prefix + I' in tmux to install plugins"
    else
        print_success "TPM already installed"
    fi
}

# Install configurations
install_tmux() {
    print_status "Installing tmux configuration..."
    create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
    install_tpm
}

install_nvim() {
    print_status "Installing Neovim configuration..."
    create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
    print_warning "Run ':Lazy sync' in Neovim to install plugins"
}

install_kitty() {
    print_status "Installing Kitty configuration..."
    create_symlink "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
}

install_zsh() {
    print_status "Installing Zsh configuration..."
    install_oh_my_zsh
    install_powerlevel10k
    create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    # Install optimized p10k config if it exists
    if [[ -f "$DOTFILES_DIR/.p10k.zsh" ]]; then
        create_symlink "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
        print_success "Installed optimized Powerlevel10k configuration"
    fi

    # Change default shell to zsh
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        print_status "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (will take effect on next login)"
    fi

    print_warning "Restart your terminal and run 'p10k configure' if you want to customize your prompt"
}

# Main installation
main() {
    echo ""
    echo "🚀 Dotfiles Installation Script (Fedora/Linux)"
    echo "=============================================="
    echo ""

    check_linux
    detect_package_manager

    # Create backup
    if [[ -f "$DOTFILES_DIR/backup.sh" ]]; then
        print_status "Creating backup of existing configurations..."
        "$DOTFILES_DIR/backup.sh"
    fi

    install_dependencies

    if [[ "$INSTALL_ALL" == true || "$INSTALL_TMUX" == true ]]; then
        install_tmux
    fi

    if [[ "$INSTALL_ALL" == true || "$INSTALL_NVIM" == true ]]; then
        install_nvim
    fi

    if [[ "$INSTALL_ALL" == true || "$INSTALL_KITTY" == true ]]; then
        install_kitty
    fi

    if [[ "$INSTALL_ALL" == true || "$INSTALL_ZSH" == true ]]; then
        install_zsh
    fi

    echo ""
    echo "🎉 Installation completed!"
    echo ""
    echo "Next steps:"
    echo "1. Restart your terminal or run 'exec zsh' to start using zsh"
    echo "2. In tmux, press 'Ctrl-Space + I' to install plugins"
    echo "3. In Neovim, run ':Lazy sync' to install plugins"
    echo "4. Run 'p10k configure' to customize your prompt"
    echo ""
    echo "Enjoy your new development environment! 🚀"
}

main "$@"
