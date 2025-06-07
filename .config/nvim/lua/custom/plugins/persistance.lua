-- Session management via persistence.nvim
return {
    {
    "folke/persistence.nvim",
    -- load it just before reading or creating a buffer
    event = { "BufReadPre", "BufNewFile" },
    -- optional: only load the module when you call it
    module = "persistence",
    config = function()
      require("persistence").setup{
        -- directory where session files are saved
        dir = vim.fn.stdpath("data") .. "/sessions/", 
        -- you can tweak additional options here
      }
    end,
  },
}
  