return {
  "nvim-treesitter/nvim-treesitter", -- language parse tree api
  event = "BufReadPre",
  build = function()
    local ts_update =
    require("nvim-treesitter.install").update { with_sync = true }
    ts_update()
  end,
  config = function()
    require("nvim-treesitter.configs").setup {
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
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
      },
      auto_install = true,
    }
  end
}
