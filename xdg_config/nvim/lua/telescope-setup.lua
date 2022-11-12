local telescope = require('telescope')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').cycle_previewers_next,
        ["<C-k>"] = require('telescope.actions').cycle_previewers_prev,
      }
    }
  },
})

-- can configure this also, check help I guess
telescope.load_extension "file_browser"

vim.keymap.set('n', '<leader>bi', [[<cmd>lua require('telescope.builtin').builtin()<cr>]])
vim.keymap.set('n', '<leader>km', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]])
vim.keymap.set('n', '<leader>op', [[<cmd>lua require('telescope.builtin').vim_options()<cr>]])
vim.keymap.set('n', '<leader>of', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]])
vim.keymap.set('n', '<leader>mp', [[<cmd>lua require('telescope.builtin').man_pages()<cr>]])
vim.keymap.set('n', '<leader>ht', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]])
vim.keymap.set('n', '<leader>dg', [[<cmd>lua require('telescope.builtin').diagnostics()<cr>]])
vim.keymap.set('n', '<leader>ac', [[<cmd>lua require('telescope.builtin').autocommands()<cr>]])
vim.keymap.set('n', '<leader>cm', [[<cmd>lua require('telescope.builtin').commands()<cr>]])
vim.keymap.set('n', '<leader>ts', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]])
vim.keymap.set('n', '<leader>cb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])

vim.keymap.set('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]])
vim.keymap.set('n', '<leader>gC', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]])
vim.keymap.set('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]])
vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]])
vim.keymap.set('n', '<leader>gS', [[<cmd>lua require('telescope.builtin').git_stash()<cr>]])

vim.keymap.set('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]])
vim.keymap.set('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]])
vim.keymap.set('n', '<leader>li', [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]])

vim.keymap.set('n', '<leader>ffc', [[<cmd>lua require('telescope.builtin').find_files({cwd="~/.config/"})<cr>]])
vim.keymap.set('n', '<leader>ffp', [[<cmd>lua require('telescope.builtin').find_files({cwd="~/.local/share/nvim/site/packer"})<cr>]])

-- extension
vim.keymap.set('n', '<leader>fb', [[<cmd>Telescope file_browser<cr>]])


