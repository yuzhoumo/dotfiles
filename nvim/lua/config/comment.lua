return {
  "numToStr/Comment.nvim", -- "gc" to comment visual regions
  keys = { "gcc", "gbc", { "gc", mode = "v" }, { "gb", mode = "v" } },
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
