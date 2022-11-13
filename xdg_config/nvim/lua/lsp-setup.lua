-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- can do this only after 6.1 ???
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer=0})

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  buf_set_keymap('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  buf_set_keymap('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  buf_set_keymap('n', 'K', function() vim.lsp.buf.hover() end, opts)
  buf_set_keymap('n', '<leader>r', function() vim.lsp.buf.references() end, opts)
  buf_set_keymap('n', '<leader>k', function() vim.lsp.buf.signature_help() end, opts)
  -- buf_set_keymap('n', '<space>wa', function() vim.lsp.buf.add_workspace_folder() end, opts)
  -- buf_set_keymap('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end, opts)
  -- buf_set_keymap('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  -- buf_set_keymap('n', '<space>D', function() vim.lsp.buf.type_definition() end, opts)
  -- buf_set_keymap('n', '<space>rn', function() vim.lsp.buf.rename() end, opts)
  -- buf_set_keymap('n', '<space>ca', function() vim.lsp.buf.code_action() end, opts)
  -- buf_set_keymap('n', '<space>e', function() vim.lsp.diagnostic.show_line_diagnostics() end, opts)
  -- buf_set_keymap('n', '[d', function() vim.lsp.diagnostic.goto_prev() end, opts)
  -- buf_set_keymap('n', ']d', function() vim.lsp.diagnostic.goto_next() end, opts)
  -- buf_set_keymap('n', '<space>q', function() vim.lsp.diagnostic.set_loclist() end, opts)
  -- buf_set_keymap("n", "<space>f", function() vim.lsp.buf.formatting() end, opts)

  buf_set_keymap('n', '<leader>dn', function() vim.diagnostic.goto_next() end, opts)
  buf_set_keymap('n', '<leader>dp', function() vim.diagnostic.goto_prev() end, opts)

  buf_set_keymap('n', '<leader>mm', function() vim.lsp.buf.rename() end, opts)

end

-- nvim-cmp integration
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "clangd", "html", "cssls", "dockerls" }
local servers = { "clangd" }
local nvim_lsp = require('lspconfig')
local util = nvim_lsp.util;

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

