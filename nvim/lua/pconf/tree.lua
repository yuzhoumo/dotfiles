local nvimtree = require("nvim-tree")

nvimtree.setup()

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")

