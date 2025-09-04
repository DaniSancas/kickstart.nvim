-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Custom mappings
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without loosing the current clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = "Share clipboard with system's one" })
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without replacing current clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>bp', ':bp<CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set({ 'n', 'v' }, '<leader>bn', ':bn<CR>', { desc = '[B]uffer [N]ext' })
vim.keymap.set({ 'n', 'v' }, '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })
-- Insert a link previously copied to clipboard
vim.keymap.set('n', '<leader>p', function()
  local url = vim.fn.getreg '+'
  local text = ' [Link](' .. url .. ')'
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local new_line = line:sub(1, col) .. text .. line:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)
  vim.api.nvim_win_set_cursor(0, { row, col + #text })
end, { desc = 'Insert link from clipboard', noremap = true, silent = true })

-- NOTE: This is specific for `knowledge-base` project
-- Function to open a page with today's date in the journal folder
function OpenJournalPage()
  -- Get the current date in YYYY-MM-DD format
  local date = os.date '%Y-%m-%d'
  -- Construct the file path
  local filepath = './journal/' .. date .. '.md'
  -- Open the file in a left above vertical split
  vim.cmd('leftabove vsplit ' .. filepath)
end
-- Map the function to a key, e.g., <leader>j
vim.keymap.set({ 'n' }, '<leader>j', ':lua OpenJournalPage()<CR>', { noremap = true, silent = true })
-- Reload the config
vim.keymap.set({ 'n' }, '<leader>R', ':so %<CR>', { desc = 'Reload Neovim config' })

-- NOTE: Custom defined user commands

-- Command :Tb will open a terminal in split panel with 8 rows height
vim.api.nvim_create_user_command('Tb', '8split term://zsh', {})
