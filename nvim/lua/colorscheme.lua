local colorscheme = "vscode"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not ok then
  vim.notify("colorscheme not found: " .. colorscheme)
  return
end

vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1

