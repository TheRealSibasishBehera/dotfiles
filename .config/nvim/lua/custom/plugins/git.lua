return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',         -- required
      'sindrets/diffview.nvim',        -- optional - enhanced diffs
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
      local neogit = require('neogit')
      
      neogit.setup({
        -- Use telescope for selection lists
        use_telescope = true,
        -- Integration with diffview for better diff experience
        integrations = {
          telescope = true,
          diffview = true,
        },
        -- Show diff in same window (VS Code-like)
        commit_editor = {
          kind = 'vsplit',
        },
        -- Enhanced diff display
        signs = {
          hunk = { '', '' },
          item = { '>', 'v' },
          section = { '>', 'v' },
        },
      })

      -- Configure diffview for side-by-side comparison
      require('diffview').setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        git_cmd = { 'git' },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        view = {
          default = {
            layout = 'diff2_horizontal', -- Side-by-side like VS Code
          },
          merge_tool = {
            layout = 'diff3_horizontal',
            disable_diagnostics = true,
          },
          file_history = {
            layout = 'diff2_horizontal',
          },
        },
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'left',
            width = 35,
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = 'combined',
              },
              multi_file = {
                diff_merges = 'first-parent',
              },
            },
          },
          win_config = {
            position = 'bottom',
            height = 16,
          },
        },
        commit_log_panel = {
          win_config = {
            position = 'bottom',
            height = 16,
          },
        },
        default_args = {
          DiffviewOpen = { '--imply-local' },
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            { 'n', '<tab>',      '<cmd>DiffviewToggleFiles<cr>',        { desc = 'Toggle file panel' } },
            { 'n', 'gf',         '<cmd>DiffviewFocusFiles<cr>',          { desc = 'Focus file panel' } },
            { 'n', 'gh',         '<cmd>DiffviewFileHistory<cr>',         { desc = 'Open file history' } },
            -- Hunk operations
            { 'n', '<leader>hr', '<cmd>lua require("gitsigns").reset_hunk()<cr>', { desc = 'Reset hunk' } },
            { 'v', '<leader>hr', '<cmd>lua require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>', { desc = 'Reset hunk selection' } },
            { 'n', '<leader>hR', '<cmd>lua require("gitsigns").reset_buffer()<cr>', { desc = 'Reset buffer' } },
            { 'n', '<leader>hp', '<cmd>lua require("gitsigns").preview_hunk()<cr>', { desc = 'Preview hunk' } },
            { 'n', '<leader>hb', '<cmd>lua require("gitsigns").blame_line{full=true}<cr>', { desc = 'Blame line' } },
            { 'n', '<leader>hd', '<cmd>lua require("gitsigns").diffthis()<cr>', { desc = 'Diff this' } },
            { 'n', '<leader>hD', '<cmd>lua require("gitsigns").diffthis("~")<cr>', { desc = 'Diff this ~' } },
            -- Navigation
            { 'n', ']c', '<cmd>lua require("gitsigns").next_hunk()<cr>', { desc = 'Next hunk' } },
            { 'n', '[c', '<cmd>lua require("gitsigns").prev_hunk()<cr>', { desc = 'Previous hunk' } },
            -- Edit mode
            { 'n', '<leader>he', '<cmd>diffget<cr>', { desc = 'Get change from other side' } },
            { 'n', '<leader>ho', '<cmd>diffput<cr>', { desc = 'Put change to other side' } },
            { 'n', 'co', '<cmd>diffget<cr>', { desc = 'Get change (obtain)' } },
            { 'n', 'cp', '<cmd>diffput<cr>', { desc = 'Put change' } },
          },
          file_panel = {
            { 'n', 'j',             '<down>',                           { desc = 'Next entry' } },
            { 'n', 'k',             '<up>',                             { desc = 'Previous entry' } },
            { 'n', '<cr>',          '<cmd>DiffviewOpen<cr>',            { desc = 'Open diff' } },
            { 'n', 'o',             '<cmd>DiffviewOpen<cr>',            { desc = 'Open diff' } },
            { 'n', '<2-LeftMouse>', '<cmd>DiffviewOpen<cr>',            { desc = 'Open diff' } },
            { 'n', 'c',             '<cmd>DiffviewClose<cr>',           { desc = 'Close diffview' } },
            { 'n', 'R',             '<cmd>DiffviewRefresh<cr>',         { desc = 'Refresh' } },
          },
          file_history_panel = {
            { 'n', 'g!',            '<cmd>DiffviewFileHistory --base=LOCAL<cr>', { desc = 'History vs local' } },
            { 'n', 'D',             '<cmd>DiffviewFileHistory --base=LOCAL<cr>', { desc = 'History vs local' } },
            { 'n', 'd',             '<cmd>DiffviewOpen<cr>',                     { desc = 'Open diff' } },
            { 'n', 'o',             '<cmd>DiffviewOpen<cr>',                     { desc = 'Open diff' } },
            { 'n', '<cr>',          '<cmd>DiffviewOpen<cr>',                     { desc = 'Open diff' } },
          },
        },
      })

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc })
      end

      -- Core Neogit commands
      map('n', '<leader>gs', '<cmd>Neogit<cr>', 'Git [s]tatus (Neogit)')
      map('n', '<leader>gc', '<cmd>Neogit commit<cr>', 'Git [c]ommit')
      map('n', '<leader>gp', '<cmd>Neogit push<cr>', 'Git [p]ush')
      map('n', '<leader>gl', '<cmd>Neogit log<cr>', 'Git [l]og')
      
      -- Diffview commands for VS Code-like side-by-side diffs
      map('n', '<leader>gd', '<cmd>DiffviewOpen --imply-local<cr>', 'Git [d]iff current changes')
      map('n', '<leader>gD', '<cmd>DiffviewOpen HEAD~1 --imply-local<cr>', 'Git [D]iff vs last commit')
      map('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', 'Git file [h]istory')
      map('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', 'Git [H]istory all files')
      map('n', '<leader>gr', '<cmd>DiffviewOpen origin/main...HEAD<cr>', 'Git [r]eview changes vs main')
      map('n', '<leader>gv', '<cmd>DiffviewClose<cr>', 'Close diff [v]iew')
      
      -- Quick file operations
      map('n', '<leader>ga', '<cmd>Neogit<cr>', 'Git [a]dd (via status)')
      map('n', '<leader>gb', function()
        vim.cmd('Neogit')
        vim.defer_fn(function()
          vim.cmd('normal! b') -- Navigate to blame in Neogit
        end, 100)
      end, 'Git [b]lame')
    end,
  },
}
