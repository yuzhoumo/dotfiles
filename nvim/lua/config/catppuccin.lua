local function toggle_theme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

vim.o.termguicolors = true
vim.o.background = "dark"

return {
  "catppuccin/nvim", -- pastel theme
  name = "catpuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      integrations = { telescope = false },
    }

    vim.cmd.colorscheme("catppuccin")
    vim.keymap.set("n", "<leader>tt", toggle_theme)
  end
}
