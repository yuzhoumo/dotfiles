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

  -- indent guides
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = "require('config.indent-blankline')",
  }

  -- automatic indent width adjustment
  use("tpope/vim-sleuth")

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

  -- fzf (install dependency)
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

  -- language parse tree api
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update =
        require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
    config = "require('config.treesitter')",
  }

  -- lsp and autocompletion
  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    config = "require('config.lsp')",
    requires = {
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        run = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },

      { "hrsh7th/nvim-cmp" },          -- autocompletion api
      { "hrsh7th/cmp-nvim-lsp" },      -- lsp completions
      { "hrsh7th/cmp-path" },          -- filesystem path completions
      { "hrsh7th/cmp-buffer" },        -- nvim buffer completions
      { "saadparwaiz1/cmp_luasnip" },  -- snippet completions
      { "L3MON4D3/LuaSnip" },          -- snippet provider
      { "onsails/lspkind.nvim" },      -- lsp completion icons
    },
  }
end)
