-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle UI',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason DAP setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve', -- Go debugger
      },
    }

    -- DAP UI setup with compact configuration
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
      mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      element_mappings = {},
      expand_lines = vim.fn.has 'nvim-0.7' == 1,
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          size = 40, -- columns
          position = 'left',
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 0.25, -- 25% of editor height
          position = 'bottom',
        },
      },
      controls = {
        enabled = true,
        element = 'console',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
      },
    }

    -- Configure breakpoint signs (compact icons)
    vim.fn.sign_define('DapBreakpoint', {
      text = '●',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '◆',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = '✖',
      texthl = 'DapBreakpointRejected',
      linehl = '',
      numhl = '',
    })
    vim.fn.sign_define('DapStopped', {
      text = '→',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = '',
    })

    -- Set breakpoint colors
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e06c75' })
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#d19a66' })
    vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#be5046' })
    vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })

    -- Auto-open DAP UI when debugging starts
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    -- Optional: Auto-close only on session end (comment out if you want manual control)
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go-specific configuration
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
