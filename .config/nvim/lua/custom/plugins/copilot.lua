return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_next = '<c-j>',
            jump_prev = '<c-k>',
            accept = '<c-a>',
            refresh = 'r',
            open = '<M-CR>',
          },
          layout = {
            position = 'bottom', -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<c-a>',
            accept_word = false,
            accept_line = false,
            next = '<c-j>',
            prev = '<c-k>',
            dismiss = '<C-e>',
          },
        },
      }

      -- Keybinding to toggle Copilot
      vim.keymap.set('n', '<leader>tc', function()
        if copilot_enabled then
          vim.cmd 'Copilot disable'
          vim.notify 'Copilot disabled'
          copilot_enabled = false
        else
          vim.cmd 'Copilot enable'
          vim.notify 'Copilot enabled'
          copilot_enabled = true
          -- Force refresh suggestions
          require('copilot.suggestion').refresh()
        end
      end, { desc = '[T]oggle [C]opilot' })
    end,
  },

  -- {
  --     "zbirenbaum/copilot-cmp",
  --     -- after = { "copilot.lua" },
  --     config = function()
  --         require("copilot_cmp").setup()
  --     end,
  -- }
}
