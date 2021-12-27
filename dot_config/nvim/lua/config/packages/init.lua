local packages = {}

--- Init package manager packer.nvim
function packages.packer_bootstrap()
  local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    packages.packer_bootstrap = vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      packer_install_path,
    })
  end
end

--- Setup packages
function packages.setup()
  return require('packer').startup(function(use)
    --- packer.nvim
    --
    -- Package manager
    use {
      'wbthomason/packer.nvim'
    }

    --- nvim-treesitter
    --
    -- Neovim tree-sitter configuration utility
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
        require('config.packages.nvim_treesitter').setup()
      end,
      run = ':TSUpdate',
    }

    --- nvim-autopairs
    --
    -- Automatically add closing brackets, etc.
    -- Dependency of nvim-cmp
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('config.packages.nvim_autopairs').setup()
      end
    }

    --- LuaSnip
    --
    -- Snippet engine
    -- Dependency of nvim-cmp
    use {
      'L3MON4D3/LuaSnip'
    }

    use {
      'hrsh7th/nvim-cmp',
      config = function()
        require('config.packages.nvim_cmp').setup()
      end,
      requires = {
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-cmdline'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'saadparwaiz1/cmp_luasnip'},
      }
    }

    --- lspconfig
    --
    -- Configuration utility for the Neovim builtin LSP client
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('config.packages.nvim_lspconfig').setup()
      end
    }

    --- indent-blankline.nvim
    --
    -- Indentation guides
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('config.packages.indent_blankline_nvim').setup()
      end,
    }

    --- telescope.nvim
    --
    -- Fuzzy finder for all sorts of things (files, buffers, etc)
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        require('config.packages.telescope_nvim').setup()
      end,
      requires = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      }
    }

    if packages.packer_bootstrap then
      require('packer').sync()
    end
  end)
end

return packages
