return {
  "VonHeikemen/lsp-zero.nvim", -- lsp and autocompletion
  branch = "v3.x",
  event = "BufReadPre",
  dependencies = {
    {"neovim/nvim-lspconfig"},
    {
      "williamboman/mason.nvim",
      build = function()
        pcall(vim.cmd["MasonUpdate"])
      end,
    },
    {"williamboman/mason-lspconfig.nvim"},

    { "hrsh7th/nvim-cmp" },          -- autocompletion api
    { "hrsh7th/cmp-buffer" },        -- nvim buffer completions
    { "hrsh7th/cmp-nvim-lsp" },      -- lsp completions
    { "hrsh7th/cmp-path" },          -- filesystem path completions
    { "saadparwaiz1/cmp_luasnip" },  -- snippet completions
    { "L3MON4D3/LuaSnip" },          -- snippet provider
    { "onsails/lspkind.nvim" },      -- lsp completion icons
  },
  config = function()
    local lsp_zero = require("lsp-zero")
    local lsp_kind = require("lspkind")
    local cmp = require("cmp")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig");

    -- setup mason
    mason.setup({})
    mason_lspconfig.setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html",
        "jdtls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "tsserver",
      },
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end, -- configure lua language server for nvim
      },
    })

    -- setup nvim-cmp
    cmp.setup {
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
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
        format = lsp_kind.cmp_format { -- vscode-like icons
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        },
      },
    }

    -- set lsp keymaps for current buffer with an associated lsp server
    -- (does not set keymaps if no lsp server for current file)
    lsp_zero.on_attach(function(_, bufnr)
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

  end
}
