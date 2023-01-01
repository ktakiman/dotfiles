vim.cmd('packadd packer.nvim')

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use('vim-scripts/ReplaceWithRegister')
  use('michaeljsmith/vim-indent-object')

  use('kana/vim-textobj-user')

  use({
    'kana/vim-textobj-entire',
    after = {
      'vim-textobj-user',
    },
  })

  use({
    'kana/vim-textobj-line',
    after = {
      'vim-textobj-user',
    },
  })

  use('tpope/vim-repeat')
  use('tpope/vim-surround')
  use('tpope/vim-commentary')
  use('tpope/vim-fugitive')

  use('preservim/nerdtree')

  use('vim-airline/vim-airline')

  use('neovim/nvim-lspconfig')

  use('nvim-lua/plenary.nvim')
  use('nvim-telescope/telescope.nvim')
  use('nvim-telescope/telescope-file-browser.nvim')

  use({
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ color_icons = true, default = true })
    end,
  })

  use('ThePrimeagen/harpoon')

  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/nvim-cmp')

  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('onsails/lspkind-nvim')

  use('mfussenegger/nvim-dap')
  use('rcarriga/nvim-dap-ui')

  use('nvim-treesitter/nvim-treesitter')
  use('nvim-treesitter/playground')

  use('voldikss/vim-floaterm')

  use('lewis6991/gitsigns.nvim')

  use({
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  })

  use('morhetz/gruvbox')
end)
