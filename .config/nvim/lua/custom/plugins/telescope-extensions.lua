return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'sopa0/telescope-makefile',
    },
    config = function()
      pcall(require('telescope').load_extension, 'make')
    end,
  },
}