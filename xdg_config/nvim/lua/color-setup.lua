-- some colors are off with this option
-- vim.opt.termguicolor = true

vim.cmd({ cmd = 'colo', args = { 'gruvbox' } })

vim.cmd({ cmd = 'hi', args = { 'Comment', 'cterm=italic' } })
vim.api.nvim_set_hl(0, 'Operator', { link = 'GruvboxBlueBold' })

local org_bg = '235' -- how can I capture this on the fly
local cur_bg = org_bg

-- transparent gb
local function ToggleBg()
  local to_apply = cur_bg == org_bg and 'none' or org_bg
  cur_bg = to_apply
  vim.cmd({ cmd = 'hi', args = { 'Normal', 'ctermbg=' .. to_apply } })
end

vim.keymap.set('n', '<leader>xx', ToggleBg)
