return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
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
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig", -- lsp configs repository
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- enable all configured lsp servers (configs in nvim/lsp/*.lua)
      vim.lsp.enable({
        "bashls",
        "clangd",
        "cssls",
        "gopls",
        "html",
        "jdtls",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "ts_ls",
      })

      -- set lsp keymaps when a language server attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, remap = false }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end,
      })

      -- show diagnostics in floating window when jumping with [d and ]d
      vim.diagnostic.config({ jump = { float = true } })
    end,
  },
  {
    "hrsh7th/nvim-cmp", -- autocompletion
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },       -- nvim buffer completions
      { "hrsh7th/cmp-nvim-lsp" },     -- lsp completions
      { "hrsh7th/cmp-path" },         -- filesystem path completions
      { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
      { "L3MON4D3/LuaSnip" },         -- snippet provider
      { "onsails/lspkind.nvim" },     -- lsp completion icons
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({ -- vscode-like icons
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },
}
