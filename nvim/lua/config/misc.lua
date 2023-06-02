return {
  {
    "tpope/vim-fugitive", -- git commands in nvim
    cmd = { "G", "Git" },
  },
  {
    "tpope/vim-sleuth",   -- automatic indent width adjustment
    event = "BufReadPre",
  },
}
