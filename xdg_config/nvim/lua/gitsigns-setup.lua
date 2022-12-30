local gs = require('gitsigns')

gs.setup({
  on_attach = function(bufnr)
    -- stylua: ignore start
    vim.keymap.set('n', '<leader>hp', gs.prev_hunk, { desc = 'Gitsigns: previous hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hn', gs.next_hunk, { desc = 'Gitsigns: next hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hv', gs.preview_hunk, { desc = 'Gitsigns: preview hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>df', gs.diffthis, { desc = 'Gitsigns: diffthis', buffer = bufnr })
    vim.keymap.set('n', '<leader>dF', function() gs.diffthis('~') end, { desc = 'Gitsigns: diffthis(~)', buffer = bufnr })
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Gitsigns: stage hunk', buffer = bufnr })
    vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Gitsigns: undo stage hunk', buffer = bufnr })
    -- stylua: ignore end
  end,
})
