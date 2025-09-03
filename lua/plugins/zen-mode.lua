-- Zoom on buffer for free distraction editing
return {
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.8,
          width = 0.95,
          height = 0.95,
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>z', require('zen-mode').toggle, { desc = '[Z]en mode toggle' })
    end,
  },
}
