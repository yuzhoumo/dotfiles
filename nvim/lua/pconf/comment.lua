local ok, comment = pcall(require, "Comment")

if not ok then
  vim.notify("Comment plugin not found!")
  return
end

comment.setup()
