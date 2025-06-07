return {
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    -- config = function()
    --   vim.g.rustaceanvim = {
    --     -- Set rustaceanvim's specific settings to match your preferences
    --     tools = {
    --       hover_actions = {
    --         auto_focus = true,
    --       },
    --       inlay_hints = {
    --         show_parameter_hints = true,
    --       },
    --       -- This is the important part:
    --       diagnostic = {
    --         virtual_text = false,
    --         signs = true,
    --         underline = true,
    --       },
    --     },
    --   }
    --   -- Also hook into rustaceanvim's internal setup
    --   vim.api.nvim_create_autocmd('BufEnter', {
    --     pattern = '*.rs',
    --     callback = function()
    --       -- Force diagnostic settings for Rust files
    --       vim.diagnostic.config {
    --         virtual_text = false,
    --         -- other settings...
    --       }
    --     end,
    --     group = vim.api.nvim_create_augroup('RustDiagnosticSettings', { clear = true }),
    --   })
    -- end,
    lazy = false, -- This plugin is already lazy
  },
  -- {
  --   'neovim/nvim-lspconfig',
  --   opts = {
  --     servers = {
  --       bacon_ls = {
  --         enabled = diagnostics == 'bacon-ls',
  --       },
  --       rust_analyzer = { enabled = false },
  --     },
  --   },
  -- },
  {
    'nvim-neotest/neotest',
    optional = true,
    opts = {
      adapters = {
        ['rustaceanvim.neotest'] = {},
      },
    },
  },
}
