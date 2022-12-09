local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  vim.notify("plugin not found: treesitter")
  return
end

treesitter.setup {
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  ensure_installed = {
    "lua",
    "python",
    "c",
    "cpp",
    "java",
    "go",
    "bash",
    "json",
    "javascript",
    "rust",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "vim",
  },
  auto_install = true,
}
