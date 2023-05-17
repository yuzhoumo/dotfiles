return {
  "lukas-reineke/indent-blankline.nvim", -- indent guides
  event = "BufReadPre",
  config = function()
    require("indent_blankline").setup()
  end
}
