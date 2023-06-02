return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "BufReadPre",
  opts = {
    options = {
      offsets = {
        { filetype = "NvimTree", text = "Files", text_align = "center" },
      },
      always_show_bufferline = true,
      diagnostics = false,
      enforce_regular_tabs = false,
      separator_style = "thin",
      show_buffer_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      sort_by = "id",
    }
  }
}
