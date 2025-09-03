-- Debug Adapter Protocol
return {
  {
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
      'mfussenegger/nvim-dap-python',
    },

    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
          'debugpy',
        },
      }

      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
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
      }

      -- Change breakpoint icons
      -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      -- local breakpoint_icons = vim.g.have_nerd_font
      --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      -- for type, icon in pairs(breakpoint_icons) do
      --   local tp = 'Dap' .. type
      --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      -- end

      --[[ -- No needed? Covered by next config
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
      ]]

      -- Setup UI during Debug
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }
      -- Install python specific config
      require('dap-python').setup 'python'

      -- WARN: Ensure `debugpy` is installed and reacheable
      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' },
      }
      -- BREAKPOINTS
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
      -- Debug toggle breakpoint
      vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = '[B]reakpoint toggle' })

      -- Clear all Debug breakpoints
      vim.keymap.set('n', '<leader>br', dap.clear_breakpoints, { desc = '[B]reakpoint [R]emove (all)' })

      -- DEBUG actions
      -- Debug show hover information
      vim.keymap.set('n', '<leader>?', function()
        ui.eval(nil, { enter = true })
      end, { desc = '[D]ebug [I]nformation' })

      -- Debug start / continue
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]continue / Start' })

      -- Debug step into
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug [I]nto' })

      -- Debug step over
      vim.keymap.set('n', '<leader>dv', dap.step_over, { desc = '[D]ebug o[V]er' })

      -- Debug step out
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = '[D]ebug [O]ut' })

      -- Debug step back
      vim.keymap.set('n', '<leader>db', dap.step_back, { desc = '[D]ebug [B]ack' })

      -- Debug terminate
      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = '[D]ebug [T]erminate' })

      -- Debug restart
      vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]ebug [R]estart' })
    end,
  },
}
