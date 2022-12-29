R = function(pack)
  package.loaded[pack] = nil
  return require(pack)
end

Q = function(pack)
  return require(pack)
end

P = function(what)
  if type(what) == 'table' then
    print(vim.inspect(what))
  else
    print(what)
  end
  return what
end

local autocmd = {}

autocmd.on_filetype = function(filetype, callback)
  -- assuming filetype is an array or string
  local type_str = type(filetype) == 'table' and filetype[1] or filetype
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('KeiFileType_' .. type_str, { clear = true }),
    pattern = filetype,
    callback = callback,
  })
end

return {
  autocmd = autocmd,
}
