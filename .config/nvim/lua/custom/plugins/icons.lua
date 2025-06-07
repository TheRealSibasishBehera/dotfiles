return {
  -- nvim-web-devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
    priority = 1000, -- Load early
    config = function()
      require('nvim-web-devicons').setup {
        -- Enable icons by default
        default = true,
        -- Override icons if needed
        override = {
          --[[ go = {
            icon = '',
            color = '#00ADD8',
            name = 'Go',
          }, ]]
          -- Add more overrides for specific file types if needed
        },
        -- Enable folders
        folder = {
          icon = '',
          color = '#7ebae4',
          name = 'Folder',
        },
      }
    end,
  },
}
