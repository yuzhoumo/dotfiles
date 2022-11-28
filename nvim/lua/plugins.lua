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
  use("wbthomason/packer.nvim") -- package manager
  use("Mofiqul/vscode.nvim") -- vscode inspired theme

  use("tpope/vim-fugitive") -- git commands in nvim
  use("tpope/vim-rhubarb") -- fugitive-companion for github
  use { -- git info in sign column/popups
    "lewis6991/gitsigns.nvim",
    config = "require('config.gitsigns')",
    requires = { "nvim-lua/plenary.nvim" },
  }

  use { -- language parsing abstraction layer
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update =
        require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
    config = "require('config.treesitter')",
  }
  use { -- autoclose parentheses, quotes, etc
    "windwp/nvim-autopairs",
    after = { "nvim-treesitter", "nvim-cmp" },
    config = 'require("config.autopairs")',
  }
  use { -- autoclose html tags
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  }

  use { -- configure linters
    "jose-elias-alvarez/null-ls.nvim",
    config = "require('config.lsp.null-ls')",
  }
  use { -- configure lsp servers
    "neovim/nvim-lspconfig",
    config = "require('config.lsp.lspconfig')",
    requires = { "hrsh7th/cmp-nvim-lsp" },
  }
  use { -- manage lsp servers and linters
    "williamboman/mason.nvim",
    config = "require('config.lsp.mason')",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
  }
  use { -- autocompletions
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

  use { -- fzf dependency
    "junegunn/fzf",
    run = "./install --bin",
  }
  use { -- fzf file search
    "ibhagwan/fzf-lua",
    config = "require('config.fzf-lua')",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  use { -- file tree sidebar
    "kyazdani42/nvim-tree.lua",
    config = "require('config.nvim-tree')",
    requires = { "kyazdani42/nvim-web-devicons" },
  }

  use { -- fancier statusline
    "nvim-lualine/lualine.nvim",
    config = "require('config.lualine')",
  }

  use { -- "gc" to comment visual regions
    "numToStr/Comment.nvim",
    config = "require('config.comment')",
  }
end)
