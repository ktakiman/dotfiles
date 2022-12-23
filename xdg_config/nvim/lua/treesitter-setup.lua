require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- highlight (default highlight is too colorful...)
local function link_hl(name, link_to)
  vim.api.nvim_set_hl(0, name, { link = link_to })
end

-- all languages
link_hl('@punctuation', 'Normal')
link_hl('@variable', 'Normal')
link_hl('@function', 'Normal')
link_hl('@tag.delimiter', 'Normal')
link_hl('@tag', 'Type')

-- json
-- link_hl('@label.json', 'Normal')

local capture_highlight = function()
  P(vim.treesitter.get_captures_at_cursor(0))
end

-- stylua: ignore start
vim.keymap.set('n', '<leader>tp', function() vim.cmd('TSPlaygroundToggle') end, { desc = 'Treesitter: toggle playground' })
vim.keymap.set('n', '<leader>hi', capture_highlight, { desc = 'Treesitter: show highlight group under cursor' })
-- stylua: ignore end
