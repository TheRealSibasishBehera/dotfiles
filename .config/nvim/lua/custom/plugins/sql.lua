return {
  -- SQL language server and treesitter
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        'sqls',        -- SQL language server
        'sqlfluff',    -- SQL linter and formatter
      })
    end,
  },
}