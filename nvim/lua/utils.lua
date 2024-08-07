-- check if current buffer has long lines
function buf_has_long_line()
  local threshold = 1000
  local buffer = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  for _, line in ipairs(buffer) do
    if #line > threshold then
      return true
    end
  end
  return false
end

-- strip current buffer of trailing whitespace
function strip_trailng_whitespace()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command("%s/\\s\\+$//e")
  vim.api.nvim_win_set_cursor(0, cursor)
end
