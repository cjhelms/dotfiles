return {
  "nvim-neotest/neotest",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- See: https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "alfaix/neotest-gtest",
    "nvim-neotest/nvim-nio"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          args = { "--cov", "--cov-report", "json" },
        }),
      },
      require("neotest-gtest").setup({}),
    })

    local function map(keybind, action, description)
      local opts = { silent = true, desc = description }
      vim.keymap.set("n", keybind, ":Neotest " .. action .. "<cr>", opts)
    end

    map("<leader>ts", "summary", "[T]est [S]ummary")
    map("<leader>to", "output", "[T]est [O]output")
    map("<leader>tp", "output-panel", "[T]est output [P]anel")
    map("<leader>tr", "run", "[T]est [R]un")
  end,
}
