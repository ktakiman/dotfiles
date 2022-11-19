-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

local dap =  require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/home/kei/.local/bin/lldb-vscode',
  name = 'lldb'
}

-- this is my stuff to remember the last used executable (if 'Launch' option is used) or
-- rmember the last used pid (if 'Attach' option is used)
local cache = {}

local function getCache(lang, key, callback)
  local cwd = vim.fn.getcwd()
  if not cache[lang] then
    cache[lang] = {}
  end
  if not cache[lang][cwd] then
    cache[lang][cwd] = {}
  end

  local cached = cache[lang][cwd][key]

  -- get the new value, callback can just return the cached value, overwrite with new value
  -- or get the value if not cached yet
  local newValue = callback(cached, cached ~= nil)
  cache[lang][cwd][key] = newValue

  return newValue
end

local function getProgram(lang)
  -- P('program')
  local v = getCache(lang, 'program', function(cached_value, was_cached)
    local value_to_show = was_cached and cached_value or vim.fn.getcwd() .. '/'
    return vim.fn.input('Path to executable: ', value_to_show, 'file')
  end)

  print('program = ' .. v)

  return v
end

local function getPid(lang)
  local v = getCache(lang, 'pid', function(cached_value, was_cached)
    local value_to_show = was_cached and cached_value or ''
    return tonumber(vim.fn.input('PID: ', value_to_show))
  end)

  print('pid = ' .. v)

  return v
end

local function getArgs(lang)
  local v = getCache(lang, 'args', function(cached_value, was_cached)
    local value_to_show = was_cached and cached_value or ''
    return vim.fn.input('args: ', value_to_show)
  end)

  print('args = ' .. v)
  return v == '' and nil or { v }
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
    program = function() return getProgram('cpp') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function() return getArgs('cpp') end,
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
    program = function() return getProgram('cpp') end,
    pid = function() return getPid('cpp') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- my custom functions
local widgets = require('dap.ui.widgets')
dap.toggleScopes = function ()
  widgets.centered_float(widgets.scopes).toggle()
end

vim.keymap.set('n', '<f5>', dap.continue)
vim.keymap.set('n', '<f10>', dap.step_over)
vim.keymap.set('n', '<f11>', dap.step_into)
vim.keymap.set('n', '<s-f11>', dap.step_out)
vim.keymap.set('n', '<f8>', dap.step_out)
vim.keymap.set('n', '<f9>', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dbs', dap.toggle_breakpoint)

-- some dapui config (ui configuration is in nvim-dapui-setup.lua)
local dapui = require('dapui');

vim.keymap.set('n', '<f4>', dapui.toggle)

dap.listeners.after['event_initialized']['dapui_config'] = dapui.open
dap.listeners.before['event_terminated']['dapui_config'] = dapui.close
dap.listeners.before['event_exited']['dapui_config'] = dapui.close

