-- disable netrw (race conditions with nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  "kyazdani42/nvim-tree.lua", -- file tree sidebar
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = { "<Leader>tn", "<Leader>tr", "<Leader>tt" },
  config = function()
    require("nvim-tree").setup()
    local api = require("nvim-tree.api")
    local function find_file()
      api.tree.find_file { open = true, focus = true }
    end

    vim.keymap.set("n", "<Leader>tn", find_file)
    vim.keymap.set("n", "<Leader>tr", api.tree.reload)
    vim.keymap.set("n", "<Leader>tt", api.tree.toggle)
  end
}
