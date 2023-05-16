-- disable netrw (race conditions with nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "kyazdani42/nvim-tree.lua", -- file tree sidebar
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()

    vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>")
    vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>")
    vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
  end
}
