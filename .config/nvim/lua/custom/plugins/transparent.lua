return {
  'xiyaowong/transparent.nvim',
  event = 'VeryLazy',
  opts = {
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
  },
}
