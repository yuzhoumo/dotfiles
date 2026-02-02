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
  config = function()
    -- enable treesitter-based highlighting for all supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- enable treesitter-based indentation
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
