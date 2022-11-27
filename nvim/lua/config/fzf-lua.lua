local ok, fzf = pcall(require, "fzf-lua")
if not ok then
  vim.notify("plugin not found: fzf-lua")
  return
end

vim.keymap.set("n", "<c-p>", fzf.files)
vim.keymap.set("n", "<c-s-p>", fzf.grep_project)
