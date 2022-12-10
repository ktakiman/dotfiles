local telescope = require('telescope')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').cycle_previewers_next,
        ['<C-k>'] = require('telescope.actions').cycle_previewers_prev,
      },
    },
  },
})

-- can configure this also, check help I guess
telescope.load_extension('file_browser')

-- stylua: ignore start
vim.keymap.set('n', '<c-p>', function() require('telescope.builtin').git_files() end)
vim.keymap.set('n', '<c-h>', function() require('telescope.builtin').buffers() end)
vim.keymap.set('n', '<c-x>', function() require('telescope.builtin').grep_string() end)
vim.keymap.set('n', '<c-bslash>', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<c-s>', function() require('telescope.builtin').grep_string() end)

vim.keymap.set('n', '<leader>bi', function() require('telescope.builtin').builtin() end)
vim.keymap.set('n', '<leader>km', function() require('telescope.builtin').keymaps() end)
vim.keymap.set('n', '<leader>op', function() require('telescope.builtin').vim_options() end)
vim.keymap.set('n', '<leader>of', function() require('telescope.builtin').oldfiles() end)
vim.keymap.set('n', '<leader>mp', function() require('telescope.builtin').man_pages() end)
vim.keymap.set('n', '<leader>ht', function() require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<leader>dg', function() require('telescope.builtin').diagnostics() end)
vim.keymap.set('n', '<leader>ac', function() require('telescope.builtin').autocommands() end)
vim.keymap.set('n', '<leader>cm', function() require('telescope.builtin').commands() end)
vim.keymap.set('n', '<leader>ts', function() require('telescope.builtin').treesitter() end)
vim.keymap.set('n', '<leader>cb', function() require('telescope.builtin').current_buffer_fuzzy_find() end)

vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end)
vim.keymap.set('n', '<leader>gC', function() require('telescope.builtin').git_bcommits() end)
vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_branches() end)
vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end)
vim.keymap.set('n', '<leader>gS', function() require('telescope.builtin').git_stash() end)

vim.keymap.set('n', '<leader>lr', function() require('telescope.builtin').lsp_references() end)
vim.keymap.set('n', '<leader>ld', function() require('telescope.builtin').lsp_definitions() end)
vim.keymap.set('n', '<leader>li', function() require('telescope.builtin').lsp_implementations() end)

vim.keymap.set('n', '<leader>ffc', function() require('telescope.builtin').find_files({cwd="~/.config/", follow=true}) end)
vim.keymap.set('n', '<leader>ffp', function() require('telescope.builtin').find_files({cwd="~/.local/share/nvim/site/packer"}) end)

-- extension
vim.keymap.set('n', '<leader>fb', function() require("telescope").extensions.file_browser.file_browser() end)

-- [dot]files
vim.keymap.set('n', '<leader>mn', function() require('telescope.builtin').git_files({cwd="~/.dotfiles"}) end)

-- [m]y[n]ote
vim.keymap.set('n', '<leader>mn', function() require('telescope.builtin').git_files({cwd="~/mynote"}) end)

-- [m]ynote [g]rep
vim.keymap.set('n', '<leader>mg', function() require('telescope.builtin').live_grep({cwd="~/mynote"}) end)

-- stylua: ignore end
