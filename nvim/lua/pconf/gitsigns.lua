local ok, gitsigns = pcall(require, "gitsigns")

if not ok then
  vim.notify("gitsigns plugin not found!")
  return
end

gitsigns.setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
}
