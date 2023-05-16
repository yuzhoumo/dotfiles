return {
  "ibhagwan/fzf-lua", -- fzf file search
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    {
      "junegunn/fzf",
      build = "./install --bin",
    },
  },
  config = function()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<c-p>", fzf.files)
    vim.keymap.set("n", "<c-s-p>", fzf.grep_project)
  end
}
