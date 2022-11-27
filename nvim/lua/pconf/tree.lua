local ok, nvimtree = pcall(require, "nvim-tree")

if not ok then
  vim.notify("nvim-tree plugin not found!")
  return
end

nvimtree.setup()

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
