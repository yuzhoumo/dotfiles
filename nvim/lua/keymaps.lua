-- remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- don't copy single deleted characters
vim.keymap.set("n", "x", '"_x')

-- reselect after using < and > in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- buffer/tab management
vim.keymap.set("n", "[b", "<CMD>bprev<CR>")
vim.keymap.set("n", "]b", "<CMD>bnext<CR>")
vim.keymap.set("n", "<C-w><C-n>", "<CMD>tabnew<CR>")
