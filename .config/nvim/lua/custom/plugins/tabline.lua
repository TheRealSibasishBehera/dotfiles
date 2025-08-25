return {
  'akinsho/bufferline.nvim',
  enabled = false, -- Disable bufferline top bar
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'left',
            separator = true,
          }
        }
      },
      highlights = {
        background = {
          fg = vim.api.nvim_get_hl(0, {name = 'Normal'}).fg,
          bg = vim.api.nvim_get_hl(0, {name = 'Normal'}).bg,
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
        tab_selected = {
          bold = true,
        },
      }
    }
  end,
}
