-- ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally, customize github-theme here:
      -- require("github-theme").setup({
      --   -- your settings
      -- })

      -- Load the desired variant:
      vim.cmd 'colorscheme github_dark_default'
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- ensure this loads early
    config = function()
      -- Configure tokyonight styles
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- disable italics in comments
        },
      }

      -- To switch style, uncomment one of:
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'tokyonight-storm'
      -- vim.cmd.colorscheme 'tokyonight-moon'
      -- vim.cmd.colorscheme 'tokyonight-day'
    end,
  },
  --[[ {
    'tiesen243/vercel.nvim',
    config = function()
      require('vercel').setup {
        -- your settings
        transparent = false, -- Boolean: Sets the background to transparent
        italics = {
          comments = true, -- Boolean: Italicizes comments
          keywords = false, -- Boolean: Italicizes keywords
          functions = false, -- Boolean: Italicizes functions
          strings = false, -- Boolean: Italicizes strings
          variables = false, -- Boolean: Italicizes variables
        },
      }
      -- vim.cmd.colorscheme 'vercel'
    end,
  }, ]]
}
