-- Commented out in favor of kickstart's debug configuration
-- This custom debug setup was disabled to use the more widely tested kickstart debug configuration
-- The kickstart debug setup is located in lua/kickstart/plugins/debug.lua
-- 
-- Key differences:
-- - Kickstart uses F1-F3 for stepping (vs F10-F12 here)
-- - Kickstart uses <leader>b for breakpoints (vs <leader>db here)
-- - Kickstart has simpler, more standard keymaps
--
-- To re-enable this configuration, uncomment the code below and comment out
-- the debug plugin in init.lua

--[[
return {
  -- Debug Adapter Protocol
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Setup dap-go with enhanced configuration
      require('dap-go').setup({
        -- Additional dap configurations
        dap_configurations = {
          {
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        -- delve configurations
        delve = {
          -- time to wait for delve to initialize the debug session.
          initialize_timeout_sec = 20,
          -- port to start delve debugger.
          port = '${port}',
          -- additional args to pass to dlv
          args = {},
          -- build flags that are passed to delve.
          build_flags = '',
          -- detached must be false on windows
          detached = vim.fn.has('win32') == 0,
        },
      })

      -- Setup dap-ui
      dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      })

      -- Setup virtual text
      require('nvim-dap-virtual-text').setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
      })

      -- Automatically open/close dap-ui
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Setup breakpoint signs
      vim.fn.sign_define('DapBreakpoint', {
        text = '🔴',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '🟡',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '🟢',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = '',
      })
      vim.fn.sign_define('DapStopped', {
        text = '▶️',
        texthl = 'DapStopped',
        linehl = 'DapStoppedLine',
        numhl = '',
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '🚫',
        texthl = 'DapBreakpointRejected',
        linehl = '',
        numhl = '',
      })

      -- Key mappings
      local map = vim.keymap.set
      
      -- Basic debugging
      map('n', '<F5>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })
      map('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
      map('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
      map('n', '<F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
      
      -- Breakpoints
      map('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
      map('n', '<leader>dB', function() 
        dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end, { desc = 'Debug: Set Conditional Breakpoint' })
      map('n', '<leader>dL', function() 
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end, { desc = 'Debug: Set Log Point' })
      
      -- Debug session control
      map('n', '<leader>dr', function() dap.restart() end, { desc = 'Debug: Restart' })
      map('n', '<leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })
      map('n', '<leader>dt', function() dap.terminate() end, { desc = 'Debug: Terminate' })
      
      -- Go-specific debugging
      map('n', '<leader>dgt', function() require('dap-go').debug_test() end, { desc = 'Debug: Go Test' })
      map('n', '<leader>dgl', function() require('dap-go').debug_last_test() end, { desc = 'Debug: Go Last Test' })
      
      -- UI control
      map('n', '<leader>du', function() dapui.toggle() end, { desc = 'Debug: Toggle UI' })
      map('n', '<leader>de', function() dapui.eval() end, { desc = 'Debug: Evaluate Expression' })
      map('v', '<leader>de', function() dapui.eval() end, { desc = 'Debug: Evaluate Selection' })
      
      -- REPL
      map('n', '<leader>dR', function() dap.repl.open() end, { desc = 'Debug: Open REPL' })
      
      -- Scopes and variables
      map('n', '<leader>ds', function() dapui.float_element('scopes') end, { desc = 'Debug: Show Scopes' })
      map('n', '<leader>dS', function() dapui.float_element('stacks') end, { desc = 'Debug: Show Stacks' })
      map('n', '<leader>dw', function() dapui.float_element('watches') end, { desc = 'Debug: Show Watches' })
      map('n', '<leader>db', function() dapui.float_element('breakpoints') end, { desc = 'Debug: Show Breakpoints' })
    end,
  },
}
--]]

-- Return empty table since this configuration is disabled
return {}