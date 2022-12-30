vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.fixendofline = false

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.scrolloff = 5

vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.clipboard = { 'unnamed', 'unnamedplus' }

vim.opt.listchars = { tab = '»-', space = '.', eol = '↲', trail = '.' }

vim.opt.wildignore = { '*.obj', '*.o', '*.pdb' }

vim.opt.mouse = 'nv'

-- not exactly sure about what this would impacts (default is 4000)
vim.o.updatetime = 250
-- vim.opt.signcolumn = 'yes'
