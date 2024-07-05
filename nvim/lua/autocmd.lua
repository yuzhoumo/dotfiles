require("utils")

vim.api.nvim_create_augroup("misc", { clear = true })
vim.api.nvim_create_augroup("lightweight_mode", { clear = true })

-- disable resource-intensive features on minified files
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  callback = function()
    vim.b.has_long_line = buf_has_long_line()
    if vim.b.has_long_line then
      print("Minified file detected: Entering lightweight mode")

      vim.cmd("TSBufDisable highlight")
      vim.cmd("TSBufDisable indent")
      vim.cmd("TSBufDisable autotag")

      vim.opt_local.cursorline = false
      vim.opt_local.spell = false
    end
  end,
  group = "lightweight_mode",
  pattern = "*",
})

-- deferred to prevent "sytax off" from being overridden
vim.api.nvim_create_autocmd({ "UIEnter", "BufEnter" }, {
  callback = function()
    if vim.b.has_long_line then
      vim.cmd("syntax off")
    end
  end,
  group = "lightweight_mode",
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
