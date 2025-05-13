return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = function(term)
          -- Make the terminal take up the full screen
          return vim.o.lines - 4  -- Adjust the size to occupy the full screen, with a little padding
        end,
        open_mapping = [[<c-t>]],  -- Default toggle terminal mapping
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = false,
        direction = "float",  -- Ensure the terminal opens as a floating window
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",  -- You can change this to "none", "rounded", etc.
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      } 
  end,
  }
  