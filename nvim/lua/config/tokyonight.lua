return {
  "folke/tokyonight.nvim", -- colorscheme
  name = "tokyonight",
  lazy = false,
  config = function()
    require("tokyonight").setup {
      style = "night",
      light_style = "day",
      transparent = false,
      terminal_colors = true,
    }
  end
}
