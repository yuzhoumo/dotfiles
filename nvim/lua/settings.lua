-- disable plugin keymaps
vim.g.no_plugin_maps = 1

-- search start/end of file for vim modelines
vim.opt.modelines = 5

-- indentation
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.expandtab = true

-- invisible trailing characters
vim.opt.list = true
vim.opt.listchars:append("tab:▎ ")
vim.opt.listchars:append("trail:⋅")
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("nbsp:_")

-- highlight matching pairs
vim.opt.matchpairs = "(:),{:},[:],<:>"

-- highlight line cursor is on
vim.opt.cursorline = true

-- text width and rulers
vim.opt.textwidth = 79
vim.opt.colorcolumn = "+1,+31"

-- keep lines around cursor visible while scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- line numbers
vim.opt.number = true

-- line wrap
vim.opt.wrap = false

-- sign column (for plugins that need it)
vim.opt.signcolumn = "yes"

-- terminal true color
vim.opt.termguicolors = true

-- plugin execution timeout (ms after typing)
vim.opt.updatetime = 1000

-- case insensitive search (unless /C or capital in search)
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- highlight on search
vim.opt.hlsearch = false

-- split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- enable mouse in all modes
vim.opt.mouse = "a"

-- enable system clipboard
vim.opt.clipboard = "unnamed,unnamedplus"

-- save undo history between sessions
vim.opt.undofile = true

-- set completevim.opt to have a better completion experience
vim.opt.completeopt = "menu,menuone,noselect"

-- spell suggestion
vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best"

-- auto read/write on file change
vim.opt.autoread = true
vim.opt.autowrite = false
