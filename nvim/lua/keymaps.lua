-- remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- tab management
vim.keymap.set("n", "<leader>to", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>")
vim.keymap.set("n", "<leader>tl", ":tabn<CR>")
vim.keymap.set("n", "<leader>th", ":tabp<CR>")

-- don't copy single deleted characters
vim.keymap.set("n", "x", '"_x')

-- reselect after using < and > in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
