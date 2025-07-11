return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  enabled = true,
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      cmdline = {
        format = {
          search_down = { view = 'cmdline_popup' }, -- '/' searches in popup
          search_up = { view = 'cmdline_popup' }, -- '?' searches in popup
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = 'none',
            padding = { 2, 2 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
        -- Disable error notifications
        {
          filter = {
            event = 'msg_show',
            kind = 'error',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            kind = 'error',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'lsp',
            kind = 'error',
          },
          opts = { skip = true },
        },
        -- Disable warning notifications
        {
          filter = {
            event = 'msg_show',
            kind = 'warn',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            kind = 'warn',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'lsp',
            kind = 'warn',
          },
          opts = { skip = true },
        },
      },
      -- cmdline = {
      --     view = "cmdline",
      -- },
    }
  end,
}
