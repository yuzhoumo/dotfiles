local opt = vim.opt

-- disable plugin keymaps
vim.g.no_plugin_maps = 1

-- search start/end of file for vim modelines
opt.modelines = 5

-- indentation
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 4
opt.smarttab = true
opt.autoindent = true
opt.expandtab = true

-- invisible trailing characters
opt.list = true
opt.listchars:append("tab:▸ ")
opt.listchars:append("trail:⋅")
opt.listchars:append("eol:↴")
opt.listchars:append("nbsp:_")

-- highlight matching pairs
opt.matchpairs = "(:),{:},[:],<:>"

-- highlight line cursor is on
opt.cursorline = true

-- text width and rulers
opt.textwidth = 79
opt.colorcolumn = "+1,+31"

-- keep lines around cursor visible while scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- line numbers
opt.number = true

-- line wrap
opt.wrap = false

-- sign column (for plugins that need it)
opt.signcolumn = "yes"

-- terminal true color
opt.termguicolors = true

-- plugin execution timeout (ms after typing)
opt.updatetime = 1000

-- case insensitive search (unless /C or capital in search)
opt.ignorecase = true
opt.smartcase = true

-- highlight on search
opt.hlsearch = false

-- split windows
opt.splitbelow = true
opt.splitright = true

-- enable mouse in all modes
opt.mouse = "a"

-- enable system clipboard
opt.clipboard = "unnamed,unnamedplus"

-- save undo history between sessions
opt.undofile = true

-- set completeopt to have a better completion experience
opt.completeopt = "menu,menuone,noselect"

-- spell suggestion
opt.spelllang = "en_us"
opt.spellsuggest = "best"

-- auto read/write on file change
opt.autoread = true
opt.autowrite = false
