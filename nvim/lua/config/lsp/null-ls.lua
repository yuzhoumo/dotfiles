local ok, null_ls = pcall(require, "null-ls")
if not ok then
  vim.notify("plugin not found: null-ls")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  sources = {
    formatting.stylua, -- lua formatter
    formatting.autopep8, -- python formatter
    diagnostics.pylint, -- python linter
    formatting.prettier, -- js/ts formatter
    diagnostics.eslint_d.with { -- js/ts linter
      condition = function(utils)
        -- only enable eslint if root has .eslintrc.js
        return utils.root_has_file(".eslintrc.js")
      end,
    },
    formatting.rustfmt, -- rust formatter
  },
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(client)
              -- only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          }
        end,
      })
    end
  end,
}
