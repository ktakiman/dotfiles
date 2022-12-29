local autocmd = require('lua-util').autocmd

autocmd.on_filetype('json', function()
  vim.keymap.set('n', '<leader>jf', '<cmd>%!jq .<cr>')
  vim.keymap.set('n', '<leader>ju', '<cmd>%!jq -c .<cr>')
end)
