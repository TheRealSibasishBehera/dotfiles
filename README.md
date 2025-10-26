# Dotfiles

My personal development environment configuration files for macOS.

## What's Included

- **Neovim**: Kickstart-based configuration with custom plugins
- **Tmux**: Terminal multiplexer with vim-style navigation and Dracula theme
- **Ghostty**: Terminal emulator with custom font settings
- **Kitty**: Terminal emulator with IosevkaTerm Nerd Font and custom settings
- **Zsh**: Shell configuration with Oh My Zsh, Powerlevel10k, and useful plugins

## Quick Installation

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Manual Installation

If you prefer to install components individually:

```bash
# Backup existing configs (optional)
./backup.sh

# Install all configs
./install.sh

# Or install specific components
./install.sh --tmux
./install.sh --nvim
./install.sh --ghostty
./install.sh --kitty
./install.sh --zsh
```

## Requirements

- macOS
- [Homebrew](https://brew.sh/)
- Git

The installation script will handle installing most dependencies automatically.

## Features

### Neovim
- Based on kickstart.nvim
- Custom plugins for Go, Rust, and web development
- LSP support with Mason
- Fuzzy finding with Telescope
- Git integration

### Tmux
- Prefix key: `Ctrl-Space`
- Vim-style pane navigation (`hjkl`)
- Dracula theme
- TPM plugin manager
- Mouse support enabled

### Ghostty
- Custom Iosevka font
- Semi-transparent background
- Copy on select

### Kitty
- IosevkaTerm Nerd Font Mono (size 20)
- Semi-transparent background (0.9 opacity)
- Copy on select enabled
- Vim-style optimizations
- Powerline tab bar

### Zsh
- Oh My Zsh framework
- Powerlevel10k theme
- Useful aliases and functions
- History optimization
- Fuzzy finding with fzf

## Customization

After installation, you can customize any configuration by editing the files in your home directory. The dotfiles repository uses symlinks, so changes will be reflected in the repo.

## Troubleshooting

1. **Tmux plugins not working**: Run `prefix + I` in tmux to install plugins
2. **Neovim plugins not loading**: Run `:Lazy sync` in Neovim
3. **Zsh theme not loading**: Make sure Powerlevel10k is installed: `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`

## License

MIT License - feel free to use and modify as needed.