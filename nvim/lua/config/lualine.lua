return {
  "nvim-lualine/lualine.nvim", -- fancier statusline
  event = "BufReadPre",
  config = function(_)
    require("lualine").setup {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    }
  end,
}
