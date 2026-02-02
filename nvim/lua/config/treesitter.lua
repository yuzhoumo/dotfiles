return {
  "nvim-treesitter/nvim-treesitter", -- language parse tree api
  lazy = false,
  build = function()
    require("nvim-treesitter").install {
      "bash",
      "bicep",
      "c",
      "cpp",
      "css",
      "glsl",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "python",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    }
  end,
}
