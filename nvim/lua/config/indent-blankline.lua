local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  vim.notify("plugin not found: indent_blankline")
  return
end

indent_blankline.setup()
