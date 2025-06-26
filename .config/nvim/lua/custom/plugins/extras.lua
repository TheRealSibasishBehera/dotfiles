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

  -- Smooth scrolling neovim plugin written in lua
  {
    'karb94/neoscroll.nvim',
    -- enabled = false,
    config = function()
      require('neoscroll').setup {
        -- Only map less commonly used scroll commands to avoid conflicts
        mappings = {'<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = 'linear', -- Fastest, most responsive
        duration_multiplier = 0.5, -- Much faster scrolling
        performance_mode = true, -- Enable for better performance
      }
      
      -- Use default vim behavior for Ctrl+U/Ctrl+D (instant, no animation)
      vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half page and center' })
      vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half page and center' })
    end,
  },

  -- find and replace
  {
    'windwp/nvim-spectre',
    enabled = true,
    event = 'BufRead',
    keys = {
      {
        '<leader>Rr',
        function()
          require('spectre').open()
        end,
        desc = 'Replace',
      },
      {
        '<leader>Rw',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        desc = 'Replace Word',
      },
      {
        '<leader>Rf',
        function()
          require('spectre').open_file_search()
        end,
        desc = 'Replace Buffer',
      },
    },
    config = function()
      require('spectre').setup({
        replace_engine = {
          ['sed'] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
        },
        default = {
          find = {
            cmd = "rg",
            options = {"--color=never", "--no-heading", "--with-filename", "--line-number", "--column"},
          },
          replace = {
            cmd = "sed"
          }
        },
      })
      
      -- Quick replace current word in file
      vim.keymap.set('n', '<leader>rw', function()
        local word = vim.fn.expand('<cword>')
        if word == '' then
          print('No word under cursor')
          return
        end
        -- Escape special regex characters
        word = vim.fn.escape(word, '/\\')
        -- Start substitute with confirmation
        vim.api.nvim_feedkeys(':%s/\\<' .. word .. '\\>/', 'n', false)
      end, { desc = 'Replace current word in file' })
      
      -- Quick replace current word globally 
      vim.keymap.set('n', '<leader>rW', function()
        require('spectre').open_visual({ select_word = true })
      end, { desc = 'Replace current word globally' })
      
      -- Replace all occurrences without confirmation
      vim.keymap.set('n', '<leader>ra', function()
        local word = vim.fn.expand('<cword>')
        if word == '' then
          print('No word under cursor')
          return
        end
        word = vim.fn.escape(word, '/\\')
        vim.api.nvim_feedkeys(':%s/\\<' .. word .. '\\>/', 'n', false)
        vim.api.nvim_feedkeys('g', 'n', false)
      end, { desc = 'Replace all occurrences of current word' })
    end,
  },

  -- Heuristically set buffer options
  {
    'tpope/vim-sleuth',
  },

  -- Markdown preview in browser (using Deno - works with modern Node.js)
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup({
        auto_load = true,
        close_on_bdelete = true,
        syntax = true,
        theme = 'dark',
        update_on_change = true,
        app = 'browser', -- Use browser instead of webview
        filetype = { 'markdown' },
        throttle_at = 200000,
        throttle_time = 'auto',
      })
      
      -- Keymaps
      vim.keymap.set('n', '<leader>mp', function() require('peek').open() end, { desc = 'Markdown Preview Open' })
      vim.keymap.set('n', '<leader>ms', function() require('peek').close() end, { desc = 'Markdown Preview Close' })
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
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
    { -- optional completion source for require statements and module annotations
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
  },

  -- Indent guide for Neovim
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    event = { 'BufReadPost', 'BufNewFile' },
    version = '2.1.0',
    opts = {
      char = '┊',
      -- char = "│",
      filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy' },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- -- editor config support
  -- {
  --   'editorconfig/editorconfig-vim',
  -- },

  --[[ -- Enhanced f/t motions for Leap
  {
    'ggandor/flit.nvim',
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs { 'f', 'F', 't', 'T' } do
        ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = 'nx' },
  },

  -- mouse replacement
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
      { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
    },
    config = function(_, opts)
      local leap = require 'leap'
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ 'x', 'o' }, 'x')
      vim.keymap.del({ 'x', 'o' }, 'X')
    end,
  },
]]
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

  -- -- better code annotation
  -- {
  --   'danymat/neogen',
  --   enabled = false,
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'L3MON4D3/LuaSnip',
  --   },
  --   config = function()
  --     local neogen = require 'neogen'
  --
  --     neogen.setup {
  --       snippet_engine = 'luasnip',
  --     }
  --   end,
  --   keys = {
  --     {
  --       '<leader>ng',
  --       function()
  --         require('neogen').generate()
  --       end,
  --       desc = 'Generate code annotations',
  --     },
  --     {
  --       '<leader>nf',
  --       function()
  --         require('neogen').generate { type = 'func' }
  --       end,
  --       desc = 'Generate Function Annotation',
  --     },
  --     {
  --       '<leader>nt',
  --       function()
  --         require('neogen').generate { type = 'type' }
  --       end,
  --       desc = 'Generate Type Annotation',
  --     },
  --   },
  -- },

  -- {
  --   'echasnovski/mini.nvim',
  --   config = function()
  --     -- Better Around/Inside textobjects
  --     --
  --     -- Examples:
  --     --  - va)  - [V]isually select [A]round [)]paren
  --     --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --     --  - ci'  - [C]hange [I]nside [']quote
  --     require('mini.ai').setup { n_lines = 500 }
  --
  --     -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --     --
  --     -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  --     -- - sd'   - [S]urround [D]elete [']quotes
  --     -- - sr)'  - [S]urround [R]eplace [)] [']
  --     require('mini.surround').setup()
  --
  --     require('mini.pairs').setup()
  --
  --     local statusline = require 'mini.statusline'
  --     statusline.setup {
  --       use_icons = vim.g.have_nerd_font,
  --     }
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     statusline.section_location = function()
  --       return '%2l:%-2v'
  --     end
  --   end,
  -- },

  {
    'echasnovski/mini.icons',
    enabled = true,
    opts = {},
    lazy = true,
    -- specs = {
    --   { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    -- },
    -- init = function()
    --   package.preload["nvim-web-devicons"] = function()
    --     -- needed since it will be false when loading and mini will fail
    --     package.loaded["nvim-web-devicons"] = {}
    --     require("mini.icons").mock_nvim_web_devicons()
    --     return package.loaded["nvim-web-devicons"]
    --   end
    -- end,
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
