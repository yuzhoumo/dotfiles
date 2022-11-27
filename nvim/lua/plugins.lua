-- install packer if not already installed
local install_path =
  vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd "packadd packer.nvim"
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"        -- package manager

  use "Mofiqul/vscode.nvim"           -- vscode inspired theme
  use "tpope/vim-fugitive"            -- git commands in nvim
  use "tpope/vim-rhubarb"             -- fugitive-companion for github
  use "ludovicchabant/vim-gutentags"  -- automatic tags management

  use { -- autocompletion plugin
    "hrsh7th/nvim-cmp",
    config = "require('config.nvim-cmp')"
  }

  use { -- fzf dependency
    "junegunn/fzf",
    run = "./install --bin"
  }

  use { -- fzf file search
    "ibhagwan/fzf-lua",
    config = "require('config.fzf-lua')",
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  use { -- file tree sidebar
    "kyazdani42/nvim-tree.lua",
    config = "require('config.nvim-tree')",
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  use { -- git info in sign column/popups
    "lewis6991/gitsigns.nvim",
    config = "require('config.gitsigns')",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use { -- fancier statusline
    "nvim-lualine/lualine.nvim",
    config = "require('config.lualine')"
  }

  use { -- "gc" to comment visual regions
    "numToStr/Comment.nvim",
    config = "require('config.comment')"
  }
end)
