-- For your toggleterm.nvim config:
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = function(term)
        -- Make the terminal take up the full screen
        return vim.o.lines - 4 -- Adjust the size to occupy the full screen, with a little padding
      end,
      open_mapping = [[<c-t>]], -- Default toggle terminal mapping
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = false,
      direction = 'float', -- Keep this as your default for regular toggleterm
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved', -- You can keep your existing float settings
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    }

    -- Keep your existing Lazygit terminal
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit_term = Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'tab',
      hidden = true,
      on_open = function(term)
        vim.cmd 'startinsert!'
        vim.opt_local.title = true
        vim.opt_local.titlestring = 'Lazygit'
      end,
    }

    -- Simple keymaps for numbered terminals (works with your <C-t> workflow)
    -- <C-t> opens terminal 1 (your default)
    -- 2<C-t> opens terminal 2, 3<C-t> opens terminal 3, etc.
    vim.keymap.set('n', '<leader>lgt', function() lazygit_term:toggle() end, { desc = 'LazyGit (Tab)' })
    
    -- Add terminal selector for when you have many terminals open
    vim.keymap.set('n', '<leader>tt', '<cmd>TermSelect<cr>', { desc = 'Terminal Select' })

    -- Auto-close all toggleterm terminals before :wqall or session save
    local function close_all_terminals()
      local terms = require('toggleterm.terminal').get_all()
      for _, term in pairs(terms) do
        if term:is_open() then
          term:close()
        end
      end
    end

    -- Create autocommands for various session-saving scenarios
    vim.api.nvim_create_autocmd('VimLeavePre', {
      group = vim.api.nvim_create_augroup('ToggletermAutoClose', { clear = true }),
      callback = function()
        close_all_terminals()
      end,
      desc = 'Close all toggleterm terminals before exit'
    })

    -- Create a command to toggle the Lazygit tab terminal
    vim.api.nvim_create_user_command('LazyGitTab', function()
      lazygit_term:toggle()
    end, {})

    -- Also create a command to manually close all terminals
    vim.api.nvim_create_user_command('CloseAllTerminals', close_all_terminals, {
      desc = 'Close all toggleterm terminals'
    })
  end,
}

