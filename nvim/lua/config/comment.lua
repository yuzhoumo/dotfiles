local ok, comment = pcall(require, "Comment")
if not ok then
  vim.notify("plugin not found: Comment")
  return
end

comment.setup()
