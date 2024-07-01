require("utils")

vim.api.nvim_create_augroup("misc", { clear = true })

-- detect minified files (files with long lines)
vim.api.nvim_create_autocmd({ "Syntax" }, {
  callback = function()
    vim.b.has_long_line = buf_has_long_line()
    if vim.b.has_long_line then
      print("Minified file detected: Entering lightweight mode")
      set_lightweight_mode()
    end
  end,
  group = "misc",
  pattern = "*",
})

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = "misc",
  pattern = "*",
})

-- auto-strip trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = strip_trailng_whitespace,
  group = "misc",
  pattern = "*",
})
