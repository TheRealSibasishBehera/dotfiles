# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **kickstart.nvim-based** configuration extended with custom modular plugins. The architecture follows a **base + extensions** pattern:

- **Base**: `init.lua` + `lua/kickstart/plugins/` (teaching foundation)
- **Extensions**: `lua/custom/plugins/` (modular custom configurations)
- **Plugin Manager**: Lazy.nvim with performance-focused lazy loading
- **Auto-import**: `{ import = 'custom.plugins' }` loads all custom plugin files

## Key Configuration Structure

### Core Files
- `init.lua` - Main entry point with core settings, LSP config, and plugin loading
- `lazy-lock.json` - Plugin version lockfile for reproducible installs
- `lua/custom/plugins/*.lua` - Modular plugin configurations

### Language Support
- **Lua**: `lazydev.nvim` for Neovim API completion
- **Rust**: `lua/custom/plugins/rust.lua` with Rustacean + crates.nvim
- **Go**: `lua/custom/plugins/go.lua` with go.nvim toolchain

### Plugin Categories
- **LSP**: `mason.nvim` + `nvim-lspconfig` for language servers
- **Completion**: `blink.cmp` (modern nvim-cmp replacement)
- **Git**: `gitsigns.nvim` + `vim-fugitive` in `lua/custom/plugins/git.lua`
- **UI**: `neo-tree.nvim`, `lualine.nvim`, GitHub Dark theme
- **Navigation**: `telescope.nvim` with fzf-native

## Custom Keymaps

The configuration includes extensive custom keybindings in `lua/custom/plugins/keymaps.lua`:

- **Visual block movement**: `J`/`K` to move selected text up/down
- **Git workflow**: `<leader>gd` (diff), `<leader>gD` (vertical diff), `<leader>gr` (review vs main)
- **Buffer management**: `Q` to delete buffer, `<leader>w` to save and close
- **Window resizing**: `+`/`_` (vertical), `=`/`-` (horizontal)
- **Line editing**: `<CR>` for `ciw`, `X` to split line

## Common Development Tasks

### Plugin Management
```bash
# Launch Neovim (plugins auto-install on first run)
nvim

# Manage plugins
:Lazy

# Tool installation
:Mason
```

### Health Checks
```bash
# Check configuration health
:checkhealth
```

### Git Workflow Integration (Neogit + Diffview)
- `<leader>gs` - Git status (Neogit interface)
- `<leader>gd` - Side-by-side diff current changes (VS Code-like)
- `<leader>gD` - Diff vs last commit
- `<leader>gr` - Review changes vs main branch
- `<leader>gh` - File history for current file
- `<leader>gv` - Close diff view

**Diffview Features**:
- Side-by-side horizontal layout (`diff2_horizontal`)
- File panel on left with tree structure
- Enhanced diff highlighting
- Telescope integration for file selection

## Recent Modifications

Current modified files indicate active development in:
- `lua/custom/plugins/extras.lua` - Utility plugins (comments, scrolling, UI)
- `lua/custom/plugins/git.lua` - Git workflow with Neogit + Diffview (VS Code-like diffs)
- `lua/custom/plugins/keymaps.lua` - Custom key mappings

## Development Environment Requirements

- **Neovim**: Latest stable/nightly
- **Dependencies**: `git`, `make`, `ripgrep`, C compiler, Nerd Font
- **Language Tools**: Managed via Mason (LSPs, formatters, linters)
- **Go Testing**: Custom toggle function at `<C-P>` for test files