local lspzero_ok, lspzero = pcall(require, "lsp-zero")
if not lspzero_ok then
  vim.notify("plugin not found: lsp-zero")
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("plugin not found: lspconfig")
  return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  vim.notify("plugin not found: nvim-cmp")
  return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
  vim.notify("plugin not found: luasnip")
  return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  return
end

-- minimal preset
lspzero.preset({})

-- install language servers
lspzero.ensure_installed {
  "bashls",
  "clangd",
  "cssls",
  "html",
  "jdtls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "tsserver",
}

-- setup nvim-cmp
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format { -- vscode-like icons
      maxwidth = 50,
      ellipsis_char = "...",
    },
  },
}

-- set lsp keymaps for current buffer with lsp associated with it
-- (do not set keymaps if no lsp server for current file)
lspzero.on_attach(function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

-- configure lua language server for nvim
lspconfig.lua_ls.setup(lspzero.nvim_lua_ls())

lspzero.setup()
