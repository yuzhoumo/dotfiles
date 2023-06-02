local function toggle_mode()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end

vim.keymap.set("n", "<Leader>cc", toggle_mode)
vim.o.termguicolors = true
vim.o.background = "dark"

-- set default colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- list of available colorschemes
return {
  "catppuccin",
  "gruvbox",
}
