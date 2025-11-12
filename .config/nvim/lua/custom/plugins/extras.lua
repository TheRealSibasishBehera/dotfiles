return {
  -- Autotags
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },

  -- delete buffer
  {
    'famiu/bufdelete.nvim',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', 'Q', ":lua require('bufdelete').bufdelete(0, false)<cr>", { noremap = true, silent = true, desc = 'Delete buffer' })
    end,
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    opts = {
      -- Add mapping config
      toggler = {
        -- Line comment in normal mode
        line = 'gc',
        -- Block comment in normal mode
        block = 'gb',
      },
      opleader = {
        -- Line comment with motion (e.g., gcj for 2 lines)
        line = 'gc',
        -- Block comment with motion
        block = 'gb',
      },
      extra = {
        -- Add additional mappings if needed
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA', -- Add comment at the end of line
      },
      -- Enable key bindings
      mappings = {
        basic = true,
        extra = true,
      },
    },
    lazy = false,
  },

  -- useful when there are embedded languages in certain types of files (e.g. Vue or React)
  { 'joosepalviste/nvim-ts-context-commentstring', lazy = true },

  -- Neovim plugin to improve the default vim.ui interfaces
  {
    'stevearc/dressing.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    config = function()
      require('dressing').setup()
    end,
  },

  -- Markdown preview in browser (using Deno - works with modern Node.js)
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup {
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = 'dark',
        update_on_change = true,
        app = 'browser', -- Use browser instead of webview
        filetype = { 'markdown' },
        throttle_at = 200000,
        throttle_time = 'auto',
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>mp', function()
        require('peek').open()
      end, { desc = 'Markdown Preview Open' })
      vim.keymap.set('n', '<leader>ms', function()
        require('peek').close()
      end, { desc = 'Markdown Preview Close' })
      vim.keymap.set('n', '<leader>mt', function()
        if require('peek').is_open() then
          require('peek').close()
        else
          require('peek').open()
        end
      end, { desc = 'Markdown Preview Toggle' })
    end,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require('barbecue').setup {
        create_autocmd = false, -- prevent barbecue from updating itself automatically
      }

      vim.api.nvim_create_autocmd({
        'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
        'BufWinEnter',
        'CursorHold',
        'InsertLeave',

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup('barbecue.updater', {}),
        callback = function()
          require('barbecue.ui').update()
        end,
      })
    end,
  },

  {
    'echasnovski/mini.icons',
    enabled = true,
    opts = {},
    lazy = true,
  },

  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }
    end,
  },
}
