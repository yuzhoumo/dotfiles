return {
  "numToStr/Comment.nvim", -- "gc" to comment visual regions
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
