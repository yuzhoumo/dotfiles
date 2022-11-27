-- install packer if not already installed
local install_path =
  vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"        -- package manager

  use "Mofiqul/vscode.nvim"           -- vscode inspired theme
  use "tpope/vim-fugitive"            -- git commands in nvim
  use "tpope/vim-rhubarb"             -- fugitive-companion for github
  use "ludovicchabant/vim-gutentags"  -- automatic tags management
  use "hrsh7th/nvim-cmp"              -- autocompletion plugin

  use { -- get fzf dependency
    "junegunn/fzf",
    run = "./install --bin"
  }

  use { -- fzf file search
    "ibhagwan/fzf-lua",
    config = "require('pconf.fzf')",
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  use { -- file tree sidebar
    "kyazdani42/nvim-tree.lua",
    config = "require('pconf.tree')",
    requires = { "kyazdani42/nvim-web-devicons" }
  }

  use { -- git info in sign column/popups
    "lewis6991/gitsigns.nvim",
    config = "require('pconf.gitsigns')",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use { -- fancier statusline
    "nvim-lualine/lualine.nvim",
    config = "require('pconf.lualine')"
  }

  use { -- "gc" to comment visual regions
    "numToStr/Comment.nvim",
    config = "require('pconf.comment')"
  }
end)

