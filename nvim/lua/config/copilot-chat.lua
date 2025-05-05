return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<leader>cp", "<cmd>CopilotChatToggle<cr>" },
      { "<leader>cx", "<cmd>CopilotChatExplain<cr>" },
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log, async functions
    },
    build = "make tiktoken", -- only on macos or linux
    opts = {
      model = 'gpt-4o',
    },
  },
}
