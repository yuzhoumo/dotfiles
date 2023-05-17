vim.o.termguicolors = true
vim.o.background = "dark"

return {
  "catppuccin/nvim", -- pastel theme
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      integrations = { telescope = false },
    }

    vim.cmd.colorscheme("catppuccin")
    vim.keymap.set("n", "<leader>tt", function()
      if vim.o.background == "dark" then
        vim.o.background = "light"
      else
        vim.o.background = "dark"
      end
    end)
  end
}
