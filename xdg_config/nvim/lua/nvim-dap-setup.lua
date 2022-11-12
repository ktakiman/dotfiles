-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

local dap =  require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/home/kei/.local/bin/lldb-vscode',
  name = 'lldb'
}

-- this is my stuff to remember the last used executable (if 'Launch' option is used) or
-- rmember the last used pid (if 'Attach' option is used)
local cache = { cpp = {} }

local function getCache(key, callback)
  local cwd = vim.fn.getcwd()
  if not cache.cpp[cwd] then
    cache.cpp[cwd] = {}
  end
  local cached = cache.cpp[cwd][key]

  -- get the new value, callback can just return the cached value, overwrite with new value
  -- or get the value if not cached yet
  local newValue = callback(cached, cached ~= nil)
  cache.cpp[cwd][key] = newValue

  return newValue
end

local function getProgram()
  -- P('program')
  local v = getCache('program', function(cache, wasCached)
    if wasCached then
      return cache
    else
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end
  end)

  print('getProgram = ' .. v)

  return v
end

local function getPid()
  local v = getCache('pid', function(cache, wasCached)
    return tonumber(vim.fn.input('PID: ', cache == nil and '' or cache))
  end)

  print('getPid = ' .. v)

  return v
end

dap.clearCache = function ()
  cache.cpp = {}
end

dap.printCache = function ()
  P(cache)
end


dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = getProgram,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    -- 
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
  {
    name = 'Attach',
    type = 'lldb',
    request = 'attach',
    program = getProgram,
    pid = getPid,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local widgets = require('dap.ui.widgets')

-- my custom functions
dap.toggleScopes = function ()
  widgets.centered_float(widgets.scopes).toggle()
end

vim.keymap.set('n', '<f5>', function() require('dap').continue() end)
vim.keymap.set('n', '<f10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<f11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<s-f11>', function() require('dap').step_out() end)
vim.keymap.set('n', '<f8>', function() require('dap').step_out() end)
vim.keymap.set('n', '<f9>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dbs', function() require('dap').toggle_breakpoint() end)

