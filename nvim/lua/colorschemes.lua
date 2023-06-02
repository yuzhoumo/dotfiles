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

-- colorscheme picker options
return {
  "carbonfox",
  "catppuccin-frappe",
  "catppuccin-latte",
  "catppuccin-macchiato",
  "catppuccin-mocha",
  "dawnfox",
  "dayfox",
  "duskfox",
  "gruvbox",
  "nightfox",
  "nordfox",
  "oxocarbon",
  "rose-pine",
  "rose-pine-dawn",
  "rose-pine-main",
  "rose-pine-moon",
  "terafox",
  "tokyonight-day",
  "tokyonight-moon",
  "tokyonight-night",
  "tokyonight-storm",
}
