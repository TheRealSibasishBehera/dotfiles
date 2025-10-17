-- Utils module for custom helper functions
local M = {}

-- Toggle between Go file and its test file
function M.toggle_go_test()
  local file = vim.fn.expand('%')

  if file:match('_test%.go$') then
    -- Currently in test file, go to source file
    local source_file = file:gsub('_test%.go$', '.go')
    if vim.fn.filereadable(source_file) == 1 then
      vim.cmd('edit ' .. source_file)
    else
      vim.notify('Source file not found: ' .. source_file, vim.log.levels.WARN)
    end
  elseif file:match('%.go$') then
    -- Currently in source file, go to test file
    local test_file = file:gsub('%.go$', '_test.go')
    if vim.fn.filereadable(test_file) == 1 then
      vim.cmd('edit ' .. test_file)
    else
      -- Test file doesn't exist, ask if we should create it
      local choice = vim.fn.confirm('Test file does not exist. Create ' .. test_file .. '?', '&Yes\n&No', 2)
      if choice == 1 then
        vim.cmd('edit ' .. test_file)
        -- Add basic test template
        local package_name = vim.fn.fnamemodify(file, ':h:t')
        if package_name == '.' then
          package_name = 'main'
        end
        local lines = {
          'package ' .. package_name,
          '',
          'import "testing"',
          '',
          'func TestExample(t *testing.T) {',
          '\t// Add your test here',
          '}',
        }
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      end
    end
  else
    vim.notify('Not a Go file', vim.log.levels.INFO)
  end
end

return M