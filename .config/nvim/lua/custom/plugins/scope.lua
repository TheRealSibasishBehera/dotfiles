return {
  -- Plugin specifications for scope/folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    event = 'BufReadPost',
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        -- Use treesitter for better code structure awareness when folding
        return { 'treesitter', 'indent' }
      end,
      -- Set to false to use the default fillchars from Neovim
      open_fold_hl_timeout = 150,
      -- Maximum number of folds that will be displayed in a single screen line
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
      },
      preview = {
        win_config = {
          border = 'rounded',
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
    },
    init = function()
      -- Folding settings that work well with ufo
      vim.o.foldcolumn = '1' -- Show fold column
      vim.o.foldlevel = 99 -- Don't fold by default when opening files
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Use new Neovim 0.10+ fold column if available
      vim.opt.fillchars:append {
        foldsep = '│', -- Vertical line between fold levels
        fold = ' ', -- Character used for the fold indicator
        foldopen = '-', -- Character used for open folds
        foldclose = '+', -- Character used for closed folds
      }
    end,
    config = function(_, opts)
      -- Setup ufo with options
      require('ufo').setup(opts)

      -- Keybindings for folding with nvim-ufo
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zr', function()
        require('ufo').openFoldsExceptKinds()
      end, { desc = 'Open folds except specific kinds' })
      vim.keymap.set('n', 'zm', function()
        require('ufo').closeFoldsWith()
      end, { desc = 'Close folds with specific level' })
      vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Preview fold' })

      -- Use K for fold preview or hover documentation
      vim.keymap.set('n', 'K', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          -- Default hover behavior if not on a fold
          vim.lsp.buf.hover()
        end
      end, { desc = 'Preview fold or hover doc' })
    end,
  },

  -- Pretty fold display (disabled due to compatibility issues)
  --[[
  {
    'anuvyklack/pretty-fold.nvim',
    event = 'BufReadPost',
    config = function()
      require('pretty-fold').setup {
        sections = {
          left = {
            'content',
          },
          right = {
            ' ',
            'number_of_folded_lines',
            ': ',
            'percentage',
            ' ',
            function(config)
              return config.fill_char:rep(3)
            end,
          },
        },
        fill_char = '•',
        remove_fold_markers = true,
        keep_indentation = true,

        -- Additional configuration options
        ft_ignore = { 'neorg' },
        matchup_patterns = {
          { '{', '}' },
          { '%(', ')' }, -- % to escape lua pattern char
          { '%[', ']' }, -- % to escape lua pattern char
          { 'if%s.+%sthen%s', 'end' },
          { 'for%s.+%sdo%s', 'end' },
          { 'function.+end', 'end' },
        },
      }

      -- Session-specific fold decorations
      require('pretty-fold').ft_setup('lua', {
        matchup_patterns = {
          { '^%s*do$', 'end' },
          { '^%s*if', 'end' },
          { '^%s*for', 'end' },
          { 'function%s*%(', 'end' },
          { '{', '}' },
          { '%[', ']' },
        },
      })
    end,
  },
  --]]

  -- Preview folded text
  {
    'anuvyklack/fold-preview.nvim',
    dependencies = 'anuvyklack/keymap-amend.nvim',
    event = 'BufReadPost',
    opts = {
      default_keybindings = false, -- Set to false to define your own keybindings
      border = 'rounded', -- Border style for the preview window
    },
    config = function(_, opts)
      require('fold-preview').setup(opts)

      -- Custom keybinding for fold preview using h key when on a closed fold
      local keymap = vim.keymap
      local amend = require 'keymap-amend'

      -- Original h behavior preserved, but adds fold preview when on a closed fold
      amend('n', 'h', function(original)
        local fold_preview = require 'fold-preview'
        -- When on a closed fold, preview it
        if vim.fn.foldclosed(vim.fn.line '.') > 0 then
          fold_preview.show_preview()
          return
        end
        -- Otherwise, regular h behavior (move left)
        return original()
      end)

      -- Define custom keybindings
      keymap.set('n', 'zP', function()
        require('fold-preview').toggle_preview()
      end, { desc = 'Toggle fold preview' })
    end,
   },
}
