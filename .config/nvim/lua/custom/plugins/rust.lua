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
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy by design
    -- NOTE: Configuration is in init.lua before lazy.nvim loads
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
