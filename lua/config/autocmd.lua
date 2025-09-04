-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Force highlight some sytaxis
-- YAML / YML
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.yml', '*.yaml' },
  command = 'set syntax=yaml',
})

-- Avoid auto-comments to new lines
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  command = 'set formatoptions-=cro',
})

-- Resize splits on window resize
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd =',
})
