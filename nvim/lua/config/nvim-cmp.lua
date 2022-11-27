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

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<c-k>"] = cmp.mapping.select_prev_item(),
    ["<c-j>"] = cmp.mapping.select_next_item(),
    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<c-e>"] = cmp.mapping.abort(),        -- close completion window
    ["<cr>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  })
})
