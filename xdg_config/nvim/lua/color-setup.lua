vim.cmd({ cmd = 'colo', args = { 'gruvbox' } })

vim.cmd({ cmd = 'hi', args = { 'Comment', 'cterm=italic' } })

local org_bg = '235' -- how can I capture this on the fly
local cur_bg = org_bg

local function ToggleBg()
  local to_apply = cur_bg == org_bg and 'none' or org_bg
  cur_bg = to_apply
  vim.cmd({ cmd = 'hi', args = { 'Normal', 'ctermbg=' .. to_apply } })
end

vim.keymap.set('n', '<leader>xx', ToggleBg)
