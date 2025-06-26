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
          transparent = false, -- Solid background
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
        transparent = false, -- Solid background
        styles = {
          comments = { italic = false },
          sidebars = "dark",
          floats = "dark",
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
        transparent_background = false,
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
        disable_background = false, -- Solid background
        disable_float_background = false,
        styles = {
          italic = false,
          transparency = false,
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
      vim.g.gruvbox_material_transparent_background = 0 -- Solid background
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_better_performance = 1
      -- vim.cmd.colorscheme 'gruvbox-material'
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
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon", -- Set dragon as default
        background = {
          dark = "dragon",
          light = "lotus"
        },
      })
      vim.cmd.colorscheme 'kanagawa-dragon'
    end,
  },

  -- Nightfox - Multiple variants
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = false,
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
        transparent = false,
        italic_comments = false,
        disable_nvimtree_bg = true,
      })
      -- vim.cmd.colorscheme 'vscode'
    end,
  },

  -- More Gruvbox-style themes
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      -- vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- Everforest - Similar warm feel
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_disable_italic_comment = 1
      vim.g.everforest_better_performance = 1
      -- vim.cmd.colorscheme 'everforest'
    end,
  },

  -- Sonokai - Dark theme with warm accents
  {
    'sainnhe/sonokai',
    priority = 1000,
    config = function()
      vim.g.sonokai_style = 'default' -- 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
      vim.g.sonokai_transparent_background = 0
      vim.g.sonokai_disable_italic_comment = 1
      vim.g.sonokai_better_performance = 1
      -- vim.cmd.colorscheme 'sonokai'
    end,
  },
}
