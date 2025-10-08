# Linux Setup Guide

## What's Been Completed

✅ Created `linux-setup` branch with Fedora/Linux support
✅ Created `install-fedora.sh` script (supports Fedora, Debian, Arch)
✅ Cleaned up `.zshrc` - removed all macOS-specific paths
✅ Installed TPM (Tmux Plugin Manager)
✅ Created symlinks for:
- `.tmux.conf`
- `.config/nvim`
- `.config/kitty`
- `.p10k.zsh`

## Remaining Steps (Requires Manual Action)

### 1. Install Zsh and Missing Packages

```bash
# Install zsh and required tools
sudo dnf install -y zsh fd-find util-linux-user

# Install zsh plugins (try package first)
sudo dnf install -y zsh-syntax-highlighting zsh-autosuggestions

# If package installation fails, install manually:
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
```

### 2. Install Oh-My-Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Install Powerlevel10k Theme

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ~/.oh-my-zsh/custom/themes/powerlevel10k
```

### 4. Link Zsh Config

```bash
ln -sf ~/dotfiles/.zshrc ~/.zshrc
```

### 5. Change Default Shell to Zsh

```bash
chsh -s $(which zsh)
```

### 6. Start Using Your New Setup

```bash
# Option 1: Start zsh immediately
exec zsh

# Option 2: Restart your terminal
```

### 7. Install Tmux Plugins

1. Start tmux: `tmux`
2. Press `Ctrl-Space + I` to install all tmux plugins

### 8. Install Neovim Plugins

1. Open nvim: `nvim`
2. Run `:Lazy sync` to install all plugins

### 9. Optional: Customize Powerlevel10k

```bash
p10k configure
```

## Quick Install (All-in-One)

If you want to use the automated script:

```bash
./install-fedora.sh
```

This will handle everything except changing your default shell.

## What's Different from macOS?

- Uses dnf/apt/pacman instead of Homebrew
- Plugin paths adapted for Linux (`/usr/share/` instead of `/opt/homebrew/`)
- Removed macOS-specific aliases (tailscale, gcloud, GoLand)
- All tool checks are now conditional (won't break if not installed)
- Focuses on kitty terminal (already installed on your system)

## Installed Tools (Already on Your System)

- ✅ tmux
- ✅ nvim
- ✅ fzf
- ✅ ripgrep
- ✅ git
- ✅ go
- ✅ kubectl
- ✅ docker
- ✅ kitty

## Missing Tools (Optional)

- jj (Jujutsu VCS) - install if needed
- civo CLI - install if using Civo
- fd (fd-find package in Fedora)
