local fzf = require("fzf-lua")

vim.keymap.set("n", "<c-P>", fzf.files)
vim.keymap.set("n", "<c-SPACE>", fzf.grep_project)

