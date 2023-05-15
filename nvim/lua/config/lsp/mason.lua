local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  vim.notify("plugin not found: mason")
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  vim.notify("plugin not found: mason-lspconfig")
  return
end

local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
  vim.notify("plugin not found: mason-null-ls")
  return
end

mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "cssls",
    "html",
    "jdtls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "tsserver",
  },
  automatic_installation = true,
}

mason_null_ls.setup {
  ensure_installed = {
    "autopep8", -- python formatter
    "eslint_d", -- ts/js linter
    "prettier", -- ts/js formatter
    "pylint", -- python linter
    "rustfmt", -- rust formatter
    "stylua", -- lua formatter
  },
  automatic_installation = true,
}
