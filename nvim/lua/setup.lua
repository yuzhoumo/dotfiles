-- Install packer if not already installed
local install_path =
  vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute(
    '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Add plugins to startup
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'              -- package manager
  use 'tpope/vim-fugitive'                  -- git commands in nvim
  use 'tpope/vim-rhubarb'                   -- fugitive-companion for github
  use 'numToStr/Comment.nvim'               -- "gc" to comment visual regions
  use 'ludovicchabant/vim-gutentags'        -- automatic tags management
  use 'Mofiqul/vscode.nvim'                 -- vscode inspired theme
  use 'nvim-lualine/lualine.nvim'           -- fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- add indent guides on all lines
  use 'hrsh7th/nvim-cmp'                    -- autocompletion plugin
  use { 'junegunn/fzf', run = './install --bin' }   -- get fzf dependency
  use {
    'ibhagwan/fzf-lua',                             -- fzf file search
    requires = { 'kyazdani42/nvim-web-devicons' }   -- for file icons
  }
  use {
    'kyazdani42/nvim-tree.lua',                     -- file tree sidebar
    requires = { 'kyazdani42/nvim-web-devicons' }   -- for file icons
  }
  use {
    'lewis6991/gitsigns.nvim',  -- git related info in signs columns/popups
    requires = { 'nvim-lua/plenary.nvim' }
  }
end)

-- Enable Comment.nvim
require('Comment').setup()

-- Set colorscheme
vim.o.termguicolors = true
vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
vim.cmd [[colorscheme vscode]]

-- Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'vscode',
    component_separators = '|',
    section_separators = '',
  },
}

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Enable nvim-tree (default settings)
require('nvim-tree').setup()
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>')
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')

-- Set fzf-lua keymap
vim.keymap.set('n', '<c-P>',
  "<cmd>lua require('fzf-lua').files()<CR>")

vim.keymap.set('n', '<c-SPACE>',
  "<cmd>lua require('fzf-lua').grep_project()<CR>")

