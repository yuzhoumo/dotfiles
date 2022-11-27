local ok, cmp = pcall(require, "cmp")
if not ok then
  vim.notify("plugin not found: nvim-cmp")
  return
end

cmp.setup()
