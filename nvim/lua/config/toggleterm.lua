return {
  "akinsho/toggleterm.nvim", -- terminal support
  keys = { [[<c-\>]] },
  config = function()
    require("toggleterm").setup {
      direction = 'vertical',
      hide_numbers = true,
      open_mapping = [[<c-\>]],
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.3
        end
      end,
    }
  end,
}
