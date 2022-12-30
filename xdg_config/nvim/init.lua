-- packer! this require won't load plugins listed in plugins.lua, need to call PackerSync as of now
require('plugins')

if vim.env.PACKERONLY == '1' then
  return
end

-- my lua basic utilities (P,R, etc)
require('lua-util')

-- general options
require('opt')

-- general keymaps
require('keymap')

-- global color setting
require('color-setup')

-- my linting setup (for all languages)
require('lint-setup')

require('fugitive-setup')
require('telescope-setup')
require('harpoon-setup')
require('nvim-cmp-setup')
require('lsp-setup')
require('luasnip-setup')
require('nvim-dap-setup')
require('nvim-dapui-setup')
require('nerdtree-setup')
require('floaterm-setup')
require('treesitter-setup')
require('gitsigns-setup')

-- language specific setup
require('lang')
