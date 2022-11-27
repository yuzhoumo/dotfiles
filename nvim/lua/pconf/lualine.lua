local ok, lualine = pcall(require, "lualine")

if not ok then
  vim.notify("lualine plugin not found!")
  return
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = "vscode",
    component_separators = "|",
    section_separators = "",
  },
}
