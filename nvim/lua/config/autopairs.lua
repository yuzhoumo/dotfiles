local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
  vim.notify("plugin not found: nvim-autopairs")
  return
end

autopairs.setup {
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { "string" }, -- no pairs in lua string treesitter nodes
    javascript = { "template_string" }, -- no pairs in js template_string
    java = false, -- no treesitter check in java
  },
}

local cmp_autopairs_ok, cmp_autopairs =
  pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_ok then
  vim.notify("plugin not found: nvim-autopairs.completion.cmp")
  return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  vim.nofity("plugin not found: nvim-cmp")
  return
end

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
