-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', function()
        require('neo-tree.command').execute({ 
          action = 'focus',
          source = 'filesystem',
          position = 'left',
          reveal = true,
        })
      end, desc = 'NeoTree sidebar', silent = true },
    { '<leader>\\', function()
        require('neo-tree.command').execute({ 
          action = 'focus',
          source = 'filesystem',
          position = 'float',
          reveal = true,
        })
      end, desc = 'NeoTree float', silent = true },
  },
  opts = {
    popup_border_style = 'rounded',
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db'
        },
        hide_by_pattern = { -- uses glob style patterns
          -- '*.meta',
          -- '*/src/*/tsconfig.json',
        },
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignore',
          '.env',
        },
        never_show = { -- remains hidden even if visible is toggled or other settings would show it
          '.DS_Store',
          'thumbs.db'
        },
      },
      follow_current_file = {
        enabled = false, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      window = {
        position = 'left',
        width = 40,
        mappings = {
          ['\\'] = 'close_window',
          ['H'] = 'toggle_hidden',
        },
      },
    },
    window = {
      position = 'left',
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    -- Ensure float window settings
    float = {
      border = 'rounded',
      max_width = 80,
      max_height = 30,
    },
  },
}
