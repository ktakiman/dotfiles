-- vim-floaterm is vim plugin
-- is there better nvim-native alternative
vim.g.floaterm_borderchars = '        '
vim.g.floaterm_width = 0.99
vim.g.floaterm_height = 0.99

vim.cmd({ cmd = 'hi', args = { 'link', 'FloatermBorder', 'NonText' } })
