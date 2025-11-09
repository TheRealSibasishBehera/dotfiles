-- Sticky context (VS Code-like sticky scroll - shows function/class definition at top)
return {
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
    zindex = 20, -- The Z-index of the context window
  },
  config = function(_, opts)
    require('treesitter-context').setup(opts)

    -- Keymap to toggle context
    vim.keymap.set('n', '<leader>ts', '<cmd>TSContextToggle<cr>', { desc = '[T]oggle [S]ticky Scroll' })
  end,
}
