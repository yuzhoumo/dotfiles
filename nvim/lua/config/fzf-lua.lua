return {
  "ibhagwan/fzf-lua", -- fzf file search
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "junegunn/fzf",
      build = "./install --bin",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    local function colorschemes()
      fzf.colorschemes { colors = require("../colorschemes"), }
    end

    -- register fzf-lua as default ui selector
    fzf.register_ui_select()

    vim.keymap.set("n", "<Leader>fc", colorschemes)
    vim.keymap.set("n", "<Leader>ff", fzf.files)
    vim.keymap.set("n", "<Leader>fg", fzf.git_files)
    vim.keymap.set("n", "<Leader>fp", fzf.grep_project)
    vim.keymap.set("n", "<Leader>fbb", fzf.buffers)
    vim.keymap.set("n", "<Leader>fbl", fzf.blines)
  end
}
