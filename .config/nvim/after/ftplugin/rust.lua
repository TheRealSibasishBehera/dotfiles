-- Rust-specific keymaps for rustaceanvim
-- See: https://github.com/mrcjkb/rustaceanvim

local bufnr = vim.api.nvim_get_current_buf()

-- Code Action
vim.keymap.set('n', '<leader>ca', function()
  vim.cmd.RustLsp('codeAction')
end, { silent = true, buffer = bufnr, desc = '[C]ode [A]ction' })

-- Hover Actions (shows types, docs, and actions)
vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp { 'hover', 'actions' }
end, { silent = true, buffer = bufnr, desc = 'Hover Actions' })

-- Explainer (explain error under cursor)
vim.keymap.set('n', '<leader>ce', function()
  vim.cmd.RustLsp('explainError')
end, { silent = true, buffer = bufnr, desc = '[C]ode [E]xplain Error' })

-- Open Cargo.toml
vim.keymap.set('n', '<leader>co', function()
  vim.cmd.RustLsp('openCargo')
end, { silent = true, buffer = bufnr, desc = '[C]argo [O]pen' })

-- Parent Module
vim.keymap.set('n', '<leader>cp', function()
  vim.cmd.RustLsp('parentModule')
end, { silent = true, buffer = bufnr, desc = '[C]ode [P]arent Module' })

-- Join Lines (smart join)
vim.keymap.set('n', '<leader>cj', function()
  vim.cmd.RustLsp('joinLines')
end, { silent = true, buffer = bufnr, desc = '[C]ode [J]oin Lines' })

-- Structural Search Replace
vim.keymap.set('n', '<leader>csr', function()
  vim.cmd.RustLsp('ssr')
end, { silent = true, buffer = bufnr, desc = '[C]ode [S]SR' })

-- View Crate Graph
vim.keymap.set('n', '<leader>cg', function()
  vim.cmd.RustLsp('crateGraph')
end, { silent = true, buffer = bufnr, desc = '[C]rate [G]raph' })

-- Expand Macro
vim.keymap.set('n', '<leader>cm', function()
  vim.cmd.RustLsp('expandMacro')
end, { silent = true, buffer = bufnr, desc = '[C]ode Expand [M]acro' })

-- Rebuild Proc Macros (useful when they fail to load)
vim.keymap.set('n', '<leader>crm', function()
  vim.cmd.RustLsp('rebuildProcMacros')
end, { silent = true, buffer = bufnr, desc = '[C]ode [R]ebuild [M]acros' })

-- Move Item Up/Down
vim.keymap.set('n', '<leader>cmu', function()
  vim.cmd.RustLsp('moveItem', 'up')
end, { silent = true, buffer = bufnr, desc = '[C]ode [M]ove [U]p' })

vim.keymap.set('n', '<leader>cmd', function()
  vim.cmd.RustLsp('moveItem', 'down')
end, { silent = true, buffer = bufnr, desc = '[C]ode [M]ove [D]own' })

-- Runnables (run/debug specific test or binary)
vim.keymap.set('n', '<leader>cr', function()
  vim.cmd.RustLsp('runnables')
end, { silent = true, buffer = bufnr, desc = '[C]ode [R]unnables' })

-- Debuggables (requires nvim-dap)
vim.keymap.set('n', '<leader>cd', function()
  vim.cmd.RustLsp('debuggables')
end, { silent = true, buffer = bufnr, desc = '[C]ode [D]ebuggables' })

-- Test (runs test under cursor or in current file)
vim.keymap.set('n', '<leader>ct', function()
  vim.cmd.RustLsp('testables')
end, { silent = true, buffer = bufnr, desc = '[C]ode [T]estables' })
