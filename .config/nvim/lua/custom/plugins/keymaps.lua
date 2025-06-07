-- ~/.config/nvim/lua/custom/plugins/keymaps.lua

return {
  'keymaps-setup',
  name = 'custom-keymaps',
  dir = '.', -- Don't actually try to load a plugin
  config = function()
    local opts = { noremap = true, silent = true }

    -- Keep cursor centered when scrolling
    -- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
    -- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

    -- Move selected line / block of text in visual mode
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

    -- Remap for dealing with visual line wraps
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

    -- Better indenting
    vim.keymap.set('v', '<', '<gv')
    vim.keymap.set('v', '>', '>gv')

    -- Paste over currently selected text without yanking it
    vim.keymap.set('v', 'p', '"_dp')
    vim.keymap.set('v', 'P', '"_dP')

    -- Copy everything between { and } including the brackets
    vim.keymap.set('n', 'YY', 'va{Vy', opts)

    -- Move line on the screen rather than by line in the file
    vim.keymap.set('n', 'j', 'gj', opts)
    vim.keymap.set('n', 'k', 'gk', opts)

    -- Move to start/end of line
    vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^', opts)
    vim.keymap.set({ 'n', 'x', 'o' }, 'L', 'g_', opts)

    -- Navigate buffers
    -- vim.keymap.set('n', '<Right>', ':bnext<CR>', opts)
    -- vim.keymap.set('n', '<Left>', ':bprevious<CR>', opts)

    -- Save and Close buffer
    vim.keymap.set('n', '<leader>w', ':w<CR>:bd<CR>', { noremap = true, silent = true })

    -- Panes resizing
    vim.keymap.set('n', '+', ':vertical resize +5<CR>')
    vim.keymap.set('n', '_', ':vertical resize -5<CR>')
    vim.keymap.set('n', '=', ':resize +5<CR>')
    vim.keymap.set('n', '-', ':resize -5<CR>')

    -- Map enter to ciw in normal mode
    vim.keymap.set('n', '<CR>', 'ciw', opts)
    vim.keymap.set('n', '<BS>', 'ci', opts)

    -- Center search results
    -- vim.keymap.set('n', 'n', 'nzzv', opts)
    -- vim.keymap.set('n', 'N', 'Nzzv', opts)
    -- vim.keymap.set('n', '*', '*zzv', opts)
    -- vim.keymap.set('n', '#', '#zzv', opts)
    -- vim.keymap.set('n', 'g*', 'g*zz', opts)
    -- vim.keymap.set('n', 'g#', 'g#zz', opts)

    -- Save file
    vim.keymap.set('n', '<C-s>', ':w<CR>', opts)

    -- Split line with X
    vim.keymap.set('n', 'X', ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>', { silent = true })

    -- Ctrl + x to cut full line
    vim.keymap.set('n', '<C-x>', 'dd', opts)

    -- Select all
    vim.keymap.set('n', '<C-a>', 'ggVG', opts)

    -- Write file in current directory
    vim.keymap.set('n', '<C-n>', ':w %:h/', opts)

    -- Toggle go test
    vim.keymap.set('n', '<C-P>', ':lua require("config.utils").toggle_go_test()<CR>', opts)

    -- Clear search highlights
    vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', opts)
  end,
  event = 'VeryLazy',
}
