-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode

local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/home/kei/.local/bin/lldb-vscode',
  name = 'lldb',
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
  local newValue = callback(cached)
  cache[lang][cwd][key] = newValue

  return newValue
end

local function prompt(skip, cur_value, def_value, msg, kind)
  if skip and cur_value then
    return cur_value
  end

  local value_to_show = cur_value and cur_value or def_value
  if kind then
    return vim.fn.input(msg, value_to_show, kind)
  else
    return vim.fn.input(msg, value_to_show) -- pass 'nil' for 'kind' results in an error
  end
end

local function getProgram(lang, skip_prompt)
  return getCache(lang, 'program', function(cached_value)
    return prompt(skip_prompt, cached_value, vim.fn.getcwd() .. '/', 'Path to executable: ', 'file')
  end)
end

local function getPid(lang, skip_prompt)
  return getCache(lang, 'pid', function(cached_value)
    return tonumber(prompt(skip_prompt, cached_value, '', 'PID: '))
  end)
end

local function getArgs(lang, skip_prompt)
  return getCache(lang, 'args', function(cached_value)
    return prompt(skip_prompt, cached_value, '', 'Args: ')
  end)
end

dap.clearCache = function()
  cache = {}
end

dap.printCache = function()
  P(cache)
end

local g_skip_prompt = false

local launch = {
  name = 'Launch',
  type = 'lldb',
  request = 'launch',
  program = function()
    print('g_skip_prompt', g_skip_prompt)
    return getProgram('cpp', g_skip_prompt)
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  args = function()
    return getArgs('cpp', g_skip_prompt)
  end,
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
}

local attach = {
  name = 'Attach',
  type = 'lldb',
  request = 'attach',
  program = function()
    return getProgram('cpp')
  end,
  pid = function()
    return getPid('cpp', g_skip_prompt)
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  args = {},
}

dap.configurations.cpp = {
  launch,
  attach,
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- the goal here is start debug session as last run without prompting for input
local function StartNoPrompt()
  if dap.session() then
    dap.continue()
  else
    g_skip_prompt = true
    dap.run(launch)
  end
end

local function StartWithPrompt()
  if not dap.session() then
    g_skip_prompt = false
    dap.continue()
  end
end

-- my custom functions
local widgets = require('dap.ui.widgets')
dap.toggleScopes = function()
  widgets.centered_float(widgets.scopes).toggle()
end

vim.keymap.set('n', '<f5>', StartNoPrompt)
vim.keymap.set('n', '<f6>', StartWithPrompt)
vim.keymap.set('n', '<f10>', dap.step_over)
vim.keymap.set('n', '<f11>', dap.step_into)
vim.keymap.set('n', '<s-f11>', dap.step_out)
vim.keymap.set('n', '<f8>', dap.step_out)
vim.keymap.set('n', '<f9>', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dbs', dap.toggle_breakpoint)

local dapui = require('dapui')

vim.keymap.set('n', '<f4>', dapui.toggle)

-- hook dap events to dapui actions (ui config is in nvim-dapui-setup.lua)
-- dap.listeners.after['event_initialized']['dapui_config'] = dapui.open
dap.listeners.before['event_terminated']['dapui_config'] = dapui.close
dap.listeners.before['event_exited']['dapui_config'] = dapui.close
