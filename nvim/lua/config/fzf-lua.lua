return {
  "ibhagwan/fzf-lua", -- fzf file search
  keys = { "<Leader>fc", "<Leader>ff", "<Leader>fg", "<Leader>fp" },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    {
      "junegunn/fzf",
      build = "./install --bin",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    local function colorschemes()
      fzf.colorschemes { colors = require("../colorschemes") }
    end

    vim.keymap.set("n", "<Leader>fc", colorschemes)
    vim.keymap.set("n", "<Leader>ff", fzf.files)
    vim.keymap.set("n", "<Leader>fg", fzf.git_files)
    vim.keymap.set("n", "<Leader>fp", fzf.grep_project)
  end
}
