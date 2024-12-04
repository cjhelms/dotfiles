return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require("CopilotChat").setup({
      auto_follow_cursor = false,
      window = {
        layout = "float",
        relative = "cursor",
        width = 1,
        height = 0.7,
        row = 1,
      },
    })

    local map = function(mode, keybind, action, description)
      if description then description = "CopilotChat: " .. description end
      vim.keymap.set(mode, keybind, action, { buffer = bufnr, desc = description })
    end

    local function quick_chat()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer }) end
    end

    map("n", "<leader>cq", quick_chat, "[C]opilot chat [Q]uick chat")
    map("n", "<leader>cp", ":CopilotChatToggle<CR>", "[C]opilot chat [P]anel")
    map("v", "?", ":CopilotChatExplain<CR>", "Explain selection")
    map("v", "<C-r>", ":CopilotChatReview<CR>", "[R]eview selection")
    map("v", "<C-t>", ":CopilotChatTests<CR>", "Write [T]ests for selection")
    map("v", "<C-g>", ":CopilotChatFix<CR>", "Fix selection")
    map("v", "<C-w>", ":CopilotChatDocs<CR>", "[W]rite docs for selection")
  end,
}
