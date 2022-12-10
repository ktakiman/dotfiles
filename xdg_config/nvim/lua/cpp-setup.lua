--------------------------------------------------------------------------------
-- comment style
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('KeiCpp', { clear = true }),
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.opt.cms = '//%s'
  end,
})

--------------------------------------------------------------------------------
-- switch between .c/.cpp/.cxx <-> .h/.hpp/.hxx
--------------------------------------------------------------------------------
local map = {
  cpp = { 'h', 'hpp' },
  cxx = { 'h', 'hxx' },
  h = { 'cpp', 'cxx' },
}

local function try_open_pairing_file()
  -- get current file name
  local path = vim.api.nvim_buf_get_name(0)

  -- change it to .h or .cpp
  --   there should be a better way than doing this manually like this?
  local pos = 1
  while true do
    local new_pos = string.find(path, '%.', pos)
    if new_pos ~= nil then
      pos = new_pos + 1
    else
      break
    end
  end

  local ext = string.sub(path, pos)
  local alt_exts = map[ext]

  local found = false

  if alt_exts ~= nil then
    for _, alt_ext in ipairs(alt_exts) do
      local alt_file = string.sub(path, 1, pos - 1) .. alt_ext
      -- check if that file exists
      if vim.fn.filereadable(alt_file) == 1 then
        vim.cmd({ cmd = 'edit', args = { alt_file } })
        found = true
        break
      end
    end
  end

  if not found then
    print('no pairing file found')
  end
end

-- o[pen] a[lternate]
vim.keymap.set('n', '<leader>oa', try_open_pairing_file)
