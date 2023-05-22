vim.o.termguicolors = true
vim.o.background = "dark"

return {
  "catppuccin/nvim", -- pastel theme
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
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
    })

    vim.cmd.colorscheme("catppuccin")
    vim.keymap.set("n", "<leader>tt", function()
      if vim.o.background == "dark" then
        vim.o.background = "light"
      else
        vim.o.background = "dark"
      end
    end)
  end
}
