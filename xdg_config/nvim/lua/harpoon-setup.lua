-- stylua: ignore start
local ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>ha', function() require('harpoon.mark').add_file() end)
vim.keymap.set('n', '<leader>he', function() ui.toggle_quick_menu() end)

vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, { desc = 'Harpoon: file 1' })
vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, { desc = 'Harpoon: file 2' })
vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, { desc = 'Harpoon: file 3' })
vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, { desc = 'Harpoon: file 4' })
vim.keymap.set('n', '<leader>5', function() ui.nav_file(5) end, { desc = 'Harpoon: file 5' })
vim.keymap.set('n', '<leader>6', function() ui.nav_file(6) end, { desc = 'Harpoon: file 6' })
vim.keymap.set('n', '<leader>7', function() ui.nav_file(7) end, { desc = 'Harpoon: file 7' })
vim.keymap.set('n', '<leader>8', function() ui.nav_file(8) end, { desc = 'Harpoon: file 8' })
vim.keymap.set('n', '<leader>9', function() ui.nav_file(9) end, { desc = 'Harpoon: file 9' })

local term = require('harpoon.term')
vim.keymap.set('n', '<leader>t1', function() term.gotoTerminal(1) end, { desc = 'Harpoon: term 1' })
vim.keymap.set('n', '<leader>t2', function() term.gotoTerminal(2) end, { desc = 'Harpoon: term 2' })
-- stylua: ignore end
