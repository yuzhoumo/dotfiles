local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  vim.notify("colorscheme not found: catppuccin")
  return
end

local o = vim.o
o.termguicolors = true
o.background = "dark"

catppuccin.setup {
  integrations = { telescope = false },
}

vim.cmd.colorscheme("catppuccin")

local function toggle_theme()
  if o.background == "dark" then
    o.background = "light"
  else
    o.background = "dark"
  end
end

vim.keymap.set("n", "<leader>tt", toggle_theme)
