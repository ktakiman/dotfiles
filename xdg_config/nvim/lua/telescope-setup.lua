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
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.git_files, { desc = 'Telescope: git files' })
vim.keymap.set('n', '<c-h>', builtin.buffers, { desc = 'Telescope: buffers' })
vim.keymap.set('n', '<c-bslash>', builtin.live_grep, { desc = 'Telescope: live grep' })
vim.keymap.set('n', '<c-s>', builtin.grep_string, { desc = 'Telescope: grep string' })

vim.keymap.set('n', '<leader>bi', builtin.builtin, { desc = 'Telescope: [b]uilt [i]n' })
vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'Telescope: [k]ey [m]aps' })
vim.keymap.set('n', '<leader>op', builtin.vim_options, { desc = 'Telescope: vim [op]tions' })
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = 'Telescope: [o]ld [f]iles' })
vim.keymap.set('n', '<leader>mp', builtin.man_pages, { desc = 'Telescope: [m]an [p]age' })
vim.keymap.set('n', '<leader>ht', builtin.help_tags, { desc = 'Telescope: [h]elp [t]ags' })
vim.keymap.set('n', '<leader>dg', builtin.diagnostics, { desc = 'Telescope: [d]ia[g]nostics' })
vim.keymap.set('n', '<leader>ac', builtin.autocommands, { desc = 'Telescope: [a]uto [c]ommands' })
vim.keymap.set('n', '<leader>cm', builtin.commands, { desc = 'Telescope: [c]o[m]mands' })
vim.keymap.set('n', '<leader>ts', builtin.treesitter, { desc = 'Telescope: [t]ree[s]itter' })
vim.keymap.set('n', '<leader>cb', builtin.current_buffer_fuzzy_find, { desc = 'Telescope: [c]urrent [b]uffer fuzzy find' })

vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope: [g]it [c]ommits' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Telescope: [g]it b[C]ommits' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope: [g]it [b]ranches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope: [g]it [s]tatus' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope: [g]it [S]tash' })

vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope: [l]sp [r]eferences' })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope: [l]sp [d]efinitions' })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope: [l]sp [i]mplementations' })

vim.keymap.set('n', '<leader>ffc', function() builtin.find_files({cwd="~/.config/", follow=true}) end, { desc = 'Telescope: find config files' })
vim.keymap.set('n', '<leader>ffp', function() builtin.find_files({cwd="~/.local/share/nvim/site/pack/packer"}) end, { desc = 'Telescope: find packer files' })

-- extensions
vim.keymap.set('n', '<leader>fb', telescope.extensions.file_browser.file_browser, { desc = 'Telescope: [f]ile [b]rowser' })

-- [dot]files
vim.keymap.set('n', '<leader>mn', function() builtin.git_files({cwd="~/.dotfiles"}) end, { desc = 'Telescope: find dotfiles' })

-- [m]y[n]ote
vim.keymap.set('n', '<leader>mn', function() builtin.git_files({cwd="~/mynote"}) end, { desc = 'Telescope: find mynote files' })

-- [m]ynote [g]rep
vim.keymap.set('n', '<leader>mg', function() builtin.live_grep({cwd="~/mynote"}) end, { desc = 'Telescope: grep mynote files' })

-- stylua: ignore end
