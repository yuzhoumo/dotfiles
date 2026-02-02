return {
  "lewis6991/gitsigns.nvim", -- git info in sign column/popups
  event = "BufReadPre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      diff_opts = {
        internal = false,  -- Use external diff (git diff) instead of internal
      },
    }
  end
}
