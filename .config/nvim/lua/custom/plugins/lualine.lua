return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          always_divide_middle = true,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          disabled_filetypes = { 'snacks_dashboard', 'neo-tree' },
        },
        sections = {
          lualine_a = { {
            'mode',
            fmt = function(str)
              return ' ' .. str
            end,
          } },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = '', -- nf-fa-times_circle
                warn = '', -- nf-fa-warning
                info = '', -- nf-fa-info_circle
                hint = '', -- nf-fa-lightbulb_o
              },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            --[[             { 'filename', file_status = true, path = 1 }, ]]
            --[[ {
              function()
                local ok, navic = pcall(require, 'nvim-navic')
                return ok and navic.get_location() or ''
              end,
                local ok, navic = pcall(require, 'nvim-navic')
              cond = function()
                return ok and navic.is_available()
              end,
              padding = { left = 1, right = 0 },
            }, ]]
          },
          lualine_x = {
            {
              'diff',
              symbols = {
                added = '', -- nf-fa-plus_square
                modified = '柳', -- nf-fa-pencil_square
                removed = '', -- nf-fa-minus_square
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            { 'selectioncount', padding = { left = 1, right = 1 } },
            { 'searchcount', padding = { left = 1, right = 1 } },
          },
          lualine_y = {
            { 'progress', separator = '' },
            { 'location' },
          },
          lualine_z = {
            {
              function()
                return os.date '%a %d %b %Y, %I:%M %p'
              end,
            },
          },
        },
      }
    end,
  },
}
