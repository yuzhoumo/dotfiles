return {
  "numToStr/Comment.nvim", -- "gc" to comment visual regions
  keys = { "gcc", "gbc", "gc", "gb" },
  config = function()
    require("Comment").setup {
      mappings = {
        basic = true,
        extra = false,
      },
      ignore = "^$", -- ignore empty lines
    }
  end
}
