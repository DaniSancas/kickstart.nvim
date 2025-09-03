-- Plugin for launching tests
return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            args = { '-vv' },
          },
        },
      }

      -- Run
      -- Run nearest test
      vim.keymap.set('n', '<leader>tr', require('neotest').run.run, { desc = '[T]est [R]un nearest' })
      -- Run last test
      vim.keymap.set('n', '<leader>tl', require('neotest').run.run_last, { desc = '[T]est run [L]ast' })
      -- Run tests in file
      vim.keymap.set('n', '<leader>tf', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, { desc = '[T]est [F]ile' })
      -- Run all tests
      vim.keymap.set('n', '<leader>ta', function()
        require('neotest').run.run(vim.loop.cwd())
      end, { desc = '[T]est [A]ll' })

      -- Debug
      -- Debug nearest test
      vim.keymap.set('n', '<leader>tR', function()
        require('neotest').run.run { strategy = 'dap' }
      end, { desc = '[T]est debug [R]un nearest' })
      -- Debug last test
      vim.keymap.set('n', '<leader>tL', function()
        require('neotest').run.run_last { strategy = 'dap' }
      end, { desc = '[T]est debug run [L]ast' })
      -- Debug tests in file
      vim.keymap.set('n', '<leader>tF', function()
        require('neotest').run.run { vim.fn.expand '%', strategy = 'dap' }
      end, { desc = '[T]est debug [F]ile' })
      -- Debug all tests
      vim.keymap.set('n', '<leader>tA', function()
        require('neotest').run.run { vim.loop.cwd(), strategy = 'dap' }
      end, { desc = '[T]est debug [A]ll' })

      -- Outputs and summaries
      vim.keymap.set('n', '<leader>ts', require('neotest').summary.toggle, { desc = '[T]est toggle [S]ummary' })
      --vim.keymap.set('n', '<leader>to', require('neotest').output_panel.toggle, { desc = '[T]est toggle [O]utput' })
      vim.keymap.set('n', '<leader>to', function()
        require('neotest').output.open { enter = true, auto_close = true }
      end, { desc = '[T]est [O]utput window' })

      -- During test
      vim.keymap.set('n', '<leader>tS', require('neotest').run.stop, { desc = '[T]est [S]top' })
      vim.keymap.set('n', '<leader>tA', require('neotest').run.attach, { desc = '[T]est [A]ttach' })
    end,
  },
}
