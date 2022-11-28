local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  vim.notify("plugin not found: nvim-tree")
  return
end

-- disable netrw (race conditions with nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup()

vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
