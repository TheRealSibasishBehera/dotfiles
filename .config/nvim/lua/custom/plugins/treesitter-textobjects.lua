-- Commented out to disable treesitter textobjects
-- This plugin provides text objects for functions, classes, parameters, etc.
-- To re-enable, uncomment the code below

--[[
return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
              ['ad'] = '@conditional.outer',
              ['id'] = '@conditional.inner',
              ['am'] = '@call.outer',
              ['im'] = '@call.inner',
              ['ar'] = '@assignment.outer',
              ['ir'] = '@assignment.inner',
            },
            -- You can choose the select mode (default is charwise 'v')
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = 'V', -- linewise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace.
            include_surrounding_whitespace = false,
          },
          
          swap = {
            enable = true,
            swap_next = {
              ['<leader>xn'] = '@parameter.inner', -- swap with next parameter
              ['<leader>xf'] = '@function.outer', -- swap with next function
            },
            swap_previous = {
              ['<leader>xp'] = '@parameter.inner', -- swap with previous parameter
              ['<leader>xF'] = '@function.outer', -- swap with previous function
            },
          },
          
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']f'] = '@function.outer',
              [']c'] = '@class.outer',
              [']l'] = '@loop.outer',
              [']d'] = '@conditional.outer',
              [']m'] = '@call.outer',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']C'] = '@class.outer',
              [']L'] = '@loop.outer',
              [']D'] = '@conditional.outer',
              [']M'] = '@call.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[c'] = '@class.outer',
              ['[l'] = '@loop.outer',
              ['[d'] = '@conditional.outer',
              ['[m'] = '@call.outer',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[C'] = '@class.outer',
              ['[L'] = '@loop.outer',
              ['[D'] = '@conditional.outer',
              ['[M'] = '@call.outer',
            },
          },
          
          lsp_interop = {
            enable = true,
            border = 'rounded',
            floating_preview_opts = {},
            peek_definition_code = {
              ['<leader>df'] = '@function.outer',
              ['<leader>dc'] = '@class.outer',
            },
          },
        },
        
        -- Add incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<S-CR>',
            node_decremental = '<BS>',
          },
        },
      }
    end,
  },
}
--]]

-- Return empty table since this configuration is disabled
return {}