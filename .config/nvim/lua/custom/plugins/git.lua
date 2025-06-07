return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('diffview').setup()
    end,
    -- keys = {
    --   { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open DiffView' },
    --   { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close DiffView' },
    -- },
  },
}
