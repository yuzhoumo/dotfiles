return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  config = function()
    require("rose-pine").setup {
      dark_variant = "main",
      variant = "auto"
    }
  end
}
