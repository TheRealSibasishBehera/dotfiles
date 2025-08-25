return {
  'xiyaowong/transparent.nvim',
  enabled = false, -- DISABLED: Transparent plugin
  lazy = false, -- Load immediately to avoid conflicts
  priority = 1000, -- High priority to load before colorschemes
  keys = {
    { '<leader>tt', '<cmd>TransparentToggle<cr>', desc = 'Toggle [T]ransparency' },
    { '<leader>te', '<cmd>TransparentEnable<cr>', desc = 'Enable [T]ransparency' },
    { '<leader>td', '<cmd>TransparentDisable<cr>', desc = 'Disable [T]ransparency' },
  },
  config = function()
    require('transparent').setup({
    -- Transparency level control (affects which groups become transparent)
    auto = false,        -- Disable auto transparency on colorscheme change
    enable = true,       -- Enable transparency by default when plugin loads
    groups = {
      'Normal',
      'NormalNC',
      'Comment',
      'Constant',
      'Special',
      'Identifier',
      'Statement',
      'PreProc',
      'Type',
      'Underlined',
      'Todo',
      'String',
      'Function',
      'Conditional',
      'Repeat',
      'Operator',
      'Structure',
      'LineNr',
      'NonText',
      'SignColumn',
      'StatusLine',
      'StatusLineNC',
      'EndOfBuffer',
    },
    extra_groups = {
      'NormalFloat',
      'FloatBorder',
      'TelescopeBorder',
      'TelescopePromptBorder',
      'TelescopeResultsBorder',
      'TelescopePreviewBorder',
      'NvimTreeNormal',
      'NvimTreeNormalNC',
      'NvimTreeWinSeparator',
      'NvimTreeStatusLine',
    },
    exclude_groups = {
      'CursorLine', -- Keep cursor line visible for navigation
      'CursorLineNr', -- Keep cursor line number visible
      'Visual', -- Keep visual selection visible
      'TelescopeSelection', -- Keep Telescope selection visible
      'TelescopeSelectionCaret',
      'NeoTreeCursorLine', -- Keep Neo-tree selection visible
      'PmenuSel', -- Keep completion menu selection visible
    },
    })
    
    -- Ensure transparent.nvim takes precedence over colorscheme transparency
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        require('transparent').clear_prefix('BufferLine')
        require('transparent').clear_prefix('NeoTree')
        require('transparent').clear_prefix('lualine')
      end,
    })
    
    -- Add manual transparency toggle function as backup
    vim.keymap.set('n', '<leader>tb', function()
      local current_bg = vim.api.nvim_get_hl_by_name('Normal', true).background
      if current_bg then
        -- Currently has background, make transparent
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
        print('Transparency enabled (manual)')
      else
        -- Currently transparent, restore background
        vim.cmd('colorscheme gruvbox-material')
        print('Transparency disabled (manual)')
      end
    end, { desc = 'Manual transparency toggle [B]ackup' })
  end,
}
