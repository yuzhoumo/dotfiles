return {
  "ibhagwan/fzf-lua", -- fzf file search
  keys = { "<C-p>", "<C-S-p>" },
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    {
      "junegunn/fzf",
      build = "./install --bin",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<C-p>", fzf.files)
    vim.keymap.set("n", "<C-S-p>", fzf.grep_project)
  end
}
