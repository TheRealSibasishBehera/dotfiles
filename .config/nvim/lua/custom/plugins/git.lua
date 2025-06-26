return {
  -- Vim Fugitive for editable diffs
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gread', 'Gwrite', 'Gvdiffsplit' },
  },
  
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',         -- required
      'nvim-telescope/telescope.nvim', -- optional
      'tpope/vim-fugitive',            -- for editable diffs
    },
    config = function()
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
            winbar_info = true,
            disable_diagnostics = false,
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
          DiffviewOpen = { "--imply-local" },
          DiffviewFileHistory = {},
        },
        hooks = {
          diff_buf_read = function(bufnr)
            -- Make sure we can edit the working tree files
            vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
            vim.api.nvim_buf_set_option(bufnr, 'readonly', false)
          end,
        },
        keymaps = {
          disable_defaults = false,
          view = {
            { 'n', '<tab>',      '<cmd>DiffviewToggleFiles<cr>',        { desc = 'Toggle file panel' } },
            { 'n', 'gf',         '<cmd>DiffviewFocusFiles<cr>',          { desc = 'Focus file panel' } },
            { 'n', 'gh',         '<cmd>DiffviewFileHistory<cr>',         { desc = 'Open file history' } },
            { 'n', 'ge',         function() 
                local file = vim.fn.expand('%')
                vim.cmd('DiffviewClose')
                vim.cmd('edit ' .. file)
              end, { desc = 'Edit current file' } },
            -- Hunk staging operations (much easier than manual copying)
            { 'n', 's',          '<cmd>lua require("gitsigns").stage_hunk()<cr>',     { desc = 'Stage hunk' } },
            { 'v', 's',          '<cmd>lua require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>', { desc = 'Stage selection' } },
            { 'n', 'u',          '<cmd>lua require("gitsigns").undo_stage_hunk()<cr>', { desc = 'Unstage hunk' } },
            { 'n', 'S',          '<cmd>lua require("gitsigns").stage_buffer()<cr>',   { desc = 'Stage entire file' } },
            { 'n', 'U',          '<cmd>lua require("gitsigns").reset_buffer_index()<cr>', { desc = 'Unstage entire file' } },
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

      -- Toggle Git status - open if closed, close if open
      map('n', '<leader>gg', function()
        -- Check if there's a fugitive buffer open
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buftype = vim.api.nvim_buf_get_option(buf, 'filetype')
          if buftype == 'fugitive' then
            -- Close the fugitive window
            vim.api.nvim_win_close(win, false)
            return
          end
        end
        -- No fugitive window found, open Git status
        vim.cmd('Git')
      end, 'Git (toggle)')
      
      -- Open git diff split for current file
      map('n', '<leader>ge', function()
        local file = vim.fn.expand('%')
        if file == '' then
          print('No file to diff')
          return
        end
        vim.cmd('Gvdiffsplit!')
      end, 'Git diff split (edit)')
      
      -- Cycle through changed files in diff mode
      map('n', '<leader>gn', function()
        -- Get list of changed files
        local changed_files = vim.fn.systemlist('git diff --name-only HEAD')
        if #changed_files == 0 then
          print('No changed files')
          return
        end
        
        local current_file = vim.fn.expand('%:.')
        local current_index = 1
        
        -- Find current file in the list
        for i, file in ipairs(changed_files) do
          if file == current_file then
            current_index = i
            break
          end
        end
        
        -- Get next file (wrap around)
        local next_index = current_index % #changed_files + 1
        local next_file = changed_files[next_index]
        
        -- Close current diff and open next file diff
        vim.cmd('only')
        vim.cmd('edit ' .. next_file)
        vim.cmd('Gvdiffsplit!')
      end, 'Git [n]ext changed file')
      
      map('n', '<leader>gp', function()
        -- Get list of changed files
        local changed_files = vim.fn.systemlist('git diff --name-only HEAD')
        if #changed_files == 0 then
          print('No changed files')
          return
        end
        
        local current_file = vim.fn.expand('%:.')
        local current_index = 1
        
        -- Find current file in the list
        for i, file in ipairs(changed_files) do
          if file == current_file then
            current_index = i
            break
          end
        end
        
        -- Get previous file (wrap around)
        local prev_index = current_index == 1 and #changed_files or current_index - 1
        local prev_file = changed_files[prev_index]
        
        -- Close current diff and open previous file diff
        vim.cmd('only')
        vim.cmd('edit ' .. prev_file)
        vim.cmd('Gvdiffsplit!')
      end, 'Git [p]revious changed file')
      
      -- Quit git diff splits
      map('n', '<leader>gw', '<cmd>only<cr>', 'Git quit diff (close splits)')
      
      -- Hunk operations (when in diff view) - using ]c/[c for navigation
      vim.keymap.set('n', ']c', ']c', { desc = 'Next diff hunk' })
      vim.keymap.set('n', '[c', '[c', { desc = 'Previous diff hunk' })
      
      -- Diff editing operations (only in diff buffers)
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fugitive',
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set('n', 'do', '<cmd>diffget<cr>', vim.tbl_extend('force', opts, { desc = 'Diff obtain (get)' }))
          vim.keymap.set('n', 'dp', '<cmd>diffput<cr>', vim.tbl_extend('force', opts, { desc = 'Diff put' }))
        end,
      })
    end,
  },
}