return {
  "sindrets/diffview.nvim", -- diff view for staged changes
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  init = function()
    vim.keymap.set("n", "<Leader>dfo", "<cmd>DiffviewOpen<cr>")
    vim.keymap.set("n", "<Leader>dfc", "<cmd>DiffviewClose<cr>")
    vim.keymap.set("n", "<Leader>dff", "<cmd>DiffviewFileHistory %<cr>")
    vim.keymap.set("n", "<Leader>dfb", "<cmd>DiffviewFileHistory .<cr>")
  end,
  config = function()
    local actions = require("diffview/actions")

    require("diffview").setup({
      key_bindings = {
        view = {
          ["]q"] = actions.select_next_entry,
          ["[q"] = actions.select_prev_entry,

          ["<Leader>dv"] = actions.toggle_files,
        },
      }
    })
  end,
}
