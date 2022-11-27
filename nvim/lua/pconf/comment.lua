local ok, comment = pcall(require, "Comment")

if not ok or comment == nil then
  vim.notify("Comment plugin not found!")
  return
end

comment.setup()
