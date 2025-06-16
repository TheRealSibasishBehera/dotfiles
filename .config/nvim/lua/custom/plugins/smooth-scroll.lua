-- ~/.config/nvim/lua/custom/plugins/smooth-scroll.lua

return {
  'declancm/cinnamon.nvim',
  event = 'VeryLazy',
  opts = {
    -- Enable all default keymaps
    default_keymaps = true,
    
    -- Disable the plugin by default and only enable per-buffer or per-keymap
    disabled = false,
    
    -- Max length of the scrolling animation
    max_length = 500,
    
    -- Scroll step size
    scroll_limit = -1,
    
    -- The scrolling mode
    -- "cursor": animate cursor and window scrolling for any movement
    -- "window": animate window scrolling ONLY when the cursor moves out of view
    mode = "cursor",
    
    -- Only animate scrolling if the count is above or equal to this value
    count_only = false,
    
    -- Disable smooth scrolling for specific filetypes
    disabled_filetypes = {},
    
    -- Override default options for specific keymaps
    keymaps = {
      -- Half-page movements
      ["<C-u>"] = { half = true, count = true },
      ["<C-d>"] = { half = true, count = true },
      -- Full-page movements  
      ["<C-b>"] = { half = false, count = true },
      ["<C-f>"] = { half = false, count = true },
      -- Line movements
      ["<C-y>"] = { half = false, count = true },
      ["<C-e>"] = { half = false, count = true },
      -- Center movements
      ["zt"] = { half = false, count = false },
      ["zz"] = { half = false, count = false },
      ["zb"] = { half = false, count = false },
      -- Search movements
      ["n"] = { half = false, count = false },
      ["N"] = { half = false, count = false },
      ["*"] = { half = false, count = false },
      ["#"] = { half = false, count = false },
      ["g*"] = { half = false, count = false },
      ["g#"] = { half = false, count = false },
    },
    
    -- Extra keymaps for other movements
    extra_keymaps = {
      -- Add smooth scrolling to other movements
      ["gg"] = { half = false, count = false },
      ["G"] = { half = false, count = false },
    },
    
    -- Override default delay
    delay = 4,
    
    -- Use a custom scrolling function
    horizontal = true,
  },
}