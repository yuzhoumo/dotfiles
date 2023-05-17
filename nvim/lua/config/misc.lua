return {
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
  }, -- git commands in nvim
  {
    "tpope/vim-sleuth",
    event = "BufReadPre",
  },   -- automatic indent width adjustment
}
