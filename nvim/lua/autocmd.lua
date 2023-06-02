vim.api.nvim_create_augroup("misc", { clear = true })

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = "misc",
  pattern = "*",
})

-- strip trailing whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
  group = "misc",
  pattern = '*',
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command("%s/\\s\\+$//e")
    vim.api.nvim_win_set_cursor(0, cursor)
  end,
})
