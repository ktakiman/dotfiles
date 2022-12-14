-- generic helper which creates a job to run linting app and reload the buffer
local generateFormatFunc = function(createArgs)
  return function(path)
    -- let caller of this function chain the command
    -- I wonder if there is a better approach...
    local hook = {}
    local args = createArgs(path)
    -- P(args)
    vim.fn.jobstart(args, {
      on_exit = function()
        -- print(vim.inspect(hook))
        if hook.callback ~= nil then
          hook.callback()
        else
          -- not chained, ready to reload the buffer
          -- not sure if there is a nvim api way of achieving this
          -- print("about to reload")
          vim.cmd('e')
        end
      end,
      -- on_stdout = P,
      -- on_stderr = P,
    })
    return hook
  end
end

local group = vim.api.nvim_create_augroup('KeiLint', { clear = true })

--------------------------------------------------------------------------------
--  .js
--------------------------------------------------------------------------------
-- white list of which files get linted automatically
-- switch to regex?
-- can black list (no linting should apply) by setting a value to any other text (i.e. "none")
local js_lint = {
  { '/home/kei/temp/pr.js', 'pr' },
  { '/home/kei/temp/es.js', 'es' },
  { '/home/kei/', 'both' },
}

local prettify = generateFormatFunc(function(path)
  return { 'npx', 'prettier', '--write', path }
end)

local eslint = generateFormatFunc(function(path)
  return { 'npx', 'eslint', '--fix', path }
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*.js',
  callback = function(arg)
    for _, ent in ipairs(js_lint) do
      -- just doing a simple string match, maybe switch to regex match for more flexibility?
      -- I saw 'arg.match' contains the full path, not sure it's publicly documented
      local i, _ = string.find(arg.match, ent[1])
      if i == 1 then
        local hook
        if ent[2] == 'both' or ent[2] == 'pr' then
          hook = prettify(arg.file)
        end
        if ent[2] == 'both' or ent[2] == 'es' then
          if hook then
            hook.callback = function()
              eslint(arg.file)
            end
          else
            eslint(arg.file)
          end
        end
        break -- make sure I only do the first match
      end
    end
  end,
})

--------------------------------------------------------------------------------
--  .c/cpp/cxx, .h/hpp
--------------------------------------------------------------------------------

local clang_format = generateFormatFunc(function(path)
  return { 'clang-format', '-i', path }
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = { '*.cpp', '*.cxx', '*.c', '*.h' },
  callback = function(arg)
    clang_format(arg.file)
  end,
})

--------------------------------------------------------------------------------
--  .lua
--------------------------------------------------------------------------------

local stylua = generateFormatFunc(function(path)
  return { 'stylua', '-v', '-f', '/home/kei/.config/stylua/.stylua.toml', path }
end)

vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*.lua',
  callback = function(arg)
    stylua(arg.file)
  end,
})
