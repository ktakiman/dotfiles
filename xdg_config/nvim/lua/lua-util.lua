R = function(pack)
 package.loaded[pack] = nil
 return require(pack)
end

Q = function(pack)
  return require(pack)
end

P = function(what)
  print(vim.inspect(what))
  return what
end

local autocmd = {}

autocmd.on_filetype = function (filetype, callback)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("KeiFileType_" .. filetype, { clear = true }),
    pattern = filetype,
    callback = callback
  })
end

return {
  autocmd = autocmd
}


