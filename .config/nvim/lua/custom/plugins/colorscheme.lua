-- ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true, -- Enable transparency
        }
      })
      -- vim.cmd 'colorscheme github_dark_default'
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent = true, -- Enable transparency
        styles = {
          comments = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
      }
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Catppuccin - Excellent with transparency
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        transparent_background = true,
        no_italic = true,
        integrations = {
          telescope = true,
          treesitter = true,
          which_key = true,
          nvimtree = true,
          neotree = true,
          harpoon = true,
          gitsigns = true,
          noice = true,
          notify = true,
          mini = true,
        },
      })
      -- vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Rose Pine - Beautiful minimal theme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'moon', -- auto, main, moon, or dawn
        disable_background = true, -- Perfect for transparency
        disable_float_background = true,
        styles = {
          italic = false,
          transparency = true,
        },
      })
      -- vim.cmd.colorscheme 'rose-pine'
    end,
  },

  -- Gruvbox Material - Modern Gruvbox
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard' -- hard, medium, soft
      vim.g.gruvbox_material_transparent_background = 0 -- Let transparent.nvim handle this
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  -- Kanagawa - Japanese-inspired
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
      })
      -- vim.cmd.colorscheme 'kanagawa'
    end,
  },

  -- Nightfox - Multiple variants
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true,
          styles = {
            comments = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
        },
      })
      -- Variants: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
      -- vim.cmd.colorscheme 'carbonfox'
    end,
  },

  -- Alternative minimal themes
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      require('vscode').setup({
        transparent = true,
        italic_comments = false,
        disable_nvimtree_bg = true,
      })
      -- vim.cmd.colorscheme 'vscode'
    end,
  },
}
