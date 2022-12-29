vim.g.mapleader = ' '

vim.keymap.set('n', '<c-k>', '<cmd>cn<cr>')
vim.keymap.set('n', '<c-j>', '<cmd>cp<cr>')

vim.keymap.set('n', '<leader>yp', '<cmd>let @+=expand("%:p")<cr>')

vim.keymap.set('n', '<leader>tv', '<C-w>v:te<cr>')
vim.keymap.set('n', '<leader>tx', '<C-w>s:te<cr>')

vim.keymap.set('t', '<c-w>', '<c-\\><c-n><c-w>')
