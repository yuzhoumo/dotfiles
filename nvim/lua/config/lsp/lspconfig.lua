local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("plugin not found: lspconfig")
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  vim.notify("plugin not found: cmp_nvim_lsp")
  return
end

-- use to enable autocompletion on all servers
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure python server
lspconfig["pyright"].setup {
  capabilities = capabilities,
}

-- configure java server
lspconfig["jdtls"].setup {
  capabilities = capabilities,
}

-- configure javascript server
lspconfig["tsserver"].setup {
  capabilities = capabilities,
}

-- configure c server
lspconfig["clangd"].setup {
  capabilities = capabilities,
}

-- configure bash server
lspconfig["bashls"].setup {
  capabilities = capabilities,
}

-- configure html server
lspconfig["html"].setup {
  capabilities = capabilities,
}

-- configure css server
lspconfig["cssls"].setup {
  capabilities = capabilities,
}

-- configure rust server
lspconfig["rust_analyzer"].setup {
  capabilities = capabilities,
}

-- configure lua server
lspconfig["sumneko_lua"].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- recognize "vim" global
        globals = { "vim" },
      },
      workspace = {
        -- awareness runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
