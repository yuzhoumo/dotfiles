-- install packer if not already installed
local install_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  vim.cmd("packadd packer.nvim")
end

return require("packer").startup(function(use)
  -- package manager
  use("wbthomason/packer.nvim")

  -- pastel theme
  use {
    "catppuccin/nvim",
    as = "catpuccin",
  }

  -- git commands in nvim
  use("tpope/vim-fugitive")

  -- fugitive-companion for github
  use("tpope/vim-rhubarb")

  -- git info in sign column/popups
  use {
    "lewis6991/gitsigns.nvim",
    config = "require('config.gitsigns')",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- language parsing abstraction layer
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update =
        require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
    config = "require('config.treesitter')",
  }

  -- autoclose parentheses, quotes, etc
  use {
    "windwp/nvim-autopairs",
    after = { "nvim-treesitter", "nvim-cmp" },
    config = 'require("config.autopairs")',
  }

  -- autoclose html tags
  use {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  }

  -- configure linters
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = "require('config.lsp.null-ls')",
  }

  -- configure lsp servers
  use {
    "neovim/nvim-lspconfig",
    config = "require('config.lsp.lspconfig')",
    requires = { "hrsh7th/cmp-nvim-lsp" },
  }

  -- manage lsp servers and linters
  use {
    "williamboman/mason.nvim",
    config = "require('config.lsp.mason')",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
  }

  -- autocompletions
  use {
    "hrsh7th/nvim-cmp",
    config = "require('config.nvim-cmp')",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
    },
  }

  -- fzf (dependency)
  use {
    "junegunn/fzf",
    run = "./install --bin",
  }

  -- fzf file search
  use {
    "ibhagwan/fzf-lua",
    config = "require('config.fzf-lua')",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  -- file tree sidebar
  use {
    "kyazdani42/nvim-tree.lua",
    config = "require('config.nvim-tree')",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  -- fancier statusline
  use {
    "nvim-lualine/lualine.nvim",
    config = "require('config.lualine')",
  }

  -- "gc" to comment visual regions
  use {
    "numToStr/Comment.nvim",
    config = "require('config.comment')",
  }
end)
