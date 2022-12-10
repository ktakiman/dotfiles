-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = bufnr }

  -- stylua: ignore start
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>k', function() vim.lsp.buf.signature_help() end, opts)
  -- vim.keymap.set('n', '<space>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  -- vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end, opts)
  -- vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
  -- vim.keymap.set('n', '<space>ca', function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set('n', '<space>e', function() vim.lsp.diagnostic.show_line_diagnostics() end, opts)
  -- vim.keymap.set('n', '[d', function() vim.lsp.diagnostic.goto_prev() end, opts)
  -- vim.keymap.set('n', ']d', function() vim.lsp.diagnostic.goto_next() end, opts)
  -- vim.keymap.set('n', '<space>q', function() vim.lsp.diagnostic.set_loclist() end, opts)
  -- vim.keymap.set("n", "<space>f", function() vim.lsp.buf.formatting() end, opts)

  vim.keymap.set('n', '<leader>dn', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '<leader>dp', function() vim.diagnostic.goto_prev() end, opts)

  vim.keymap.set('n', '<leader>mm', function() vim.lsp.buf.rename() end, opts)
  -- stylua: ignore end
end

-- nvim-cmp integration
local capabilities =
  require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "clangd", "html", "cssls", "dockerls" }
local servers = { 'clangd', 'cmake' }
local nvim_lsp = require('lspconfig')
local util = nvim_lsp.util

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- ## this does not work yet... ##
-- nvim_lsp.dockerls.setup({
--   cmd = { '/home/kei/.nvm/versions/node/v18.12.1/bin/docker-langserver', '--stdio' },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- local sumneko_root_path = "/home/kei/dev/lua-language-server"
-- local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
local sumneko_binary = '/home/kei/.local/lua-language-server/bin/lua-language-server'
nvim_lsp.sumneko_lua.setup({
  cmd = { sumneko_binary },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim', 'love' },
      },
      workspace = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})
