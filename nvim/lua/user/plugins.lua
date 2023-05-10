-- Ensure packer is installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer')

local helpers = require('user.helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd

-- Initialize packer before startup
packer.init({
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- LSP Configuration & Plugins
  use { 'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
    config = [[require('user.lspconfig')]],
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- LSP source
      'hrsh7th/cmp-nvim-lsp',
      -- snippet plugin, integration with nvim-cmp, and vscode-like snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',

      -- path source
      'hrsh7th/cmp-path',
      -- cmdline source
      'hrsh7th/cmp-cmdline',
      -- buffer source
      'hrsh7th/cmp-buffer',
    },
    config = [[require('user.nvim-cmp')]],
  }

  -- Highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    -- run = ':TSUpdate',
    config = [[require('user.treesitter')]],
  }

  -- Additional text objects via treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use { 'lewis6991/gitsigns.nvim',
    config = [[require('user.gitsigns')]]
  }

  -- Colorscheme
  use 'EdenEast/nightfox.nvim'
  use 'navarasu/onedark.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }

  use { 'nvim-tree/nvim-web-devicons',
    config = [[require('user.nvim-web-devicons')]]
  }

  -- Fancier statusline
  use { 'nvim-lualine/lualine.nvim',
    after = { 'nvim-web-devicons' },
    config = [[require('user.lualine')]]
  }

  -- Add indentation guides even on blank lines
  use { 'lukas-reineke/indent-blankline.nvim',
    config = [[require('user.indent_blankline')]],
  }

  -- "gc" to comment visual regions/lines
  use {
    'numToStr/Comment.nvim',
    as = 'comment',
    config = [[require('comment').setup()]]
  }

  -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-sleuth'

  -- Treeview
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = [[require('user.nvim-tree')]]
  }

  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = [[require('nvim-surround').setup()]]
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({})

      -- https://github.com/windwp/nvim-autopairs/wiki/Endwise
      -- npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
      -- npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      -- npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
    end
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[require('user.telescope')]],
  }

  -- Helpers for shell commands like mkdir/mv
  use 'tpope/vim-eunuch'

  -- Markdown
  use {
    'plasticboy/vim-markdown',
    requires = { 'godlygeek/tabular' },
    config = [[require('user.markdown')]]
  }

  -- Markdown preview
  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    config = [[require('user.markdown_preview')]]
  }

  -- GitHub Copilot
  -- use { 'https://github.com/github/copilot.vim' }

  -- Fulltext search
  -- use 'mhinz/vim-grepper'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the file
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return { is_bootstrap = is_bootstrap }
end

-- Reload Neovim whenever you save the plugins.lua file
augroup('Packer', function(group)
  autocmd('BufWritePost', {
    group = group,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile'
  })
end)

return { is_bootstrap = is_bootstrap }
