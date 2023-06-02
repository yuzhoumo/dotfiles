return {
  "catppuccin/nvim", -- pastel theme
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup {
      flavor = "mocha",
      term_colors = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        mason = true,
        nvimtree = true,
        treesitter = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            information = { "underline" },
            warnings = { "underline" },
          },
          virtual_text = {
            errors = { "bold", "italic" },
            hints = { "italic" },
            information = { "italic" },
            warnings = { "italic" },
          },
        },
      },
    }
  end
}
