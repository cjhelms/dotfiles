local function configure()
  local function make_adapters_table()
    local function make_python_entry()
      local python = require("neotest-python")
      return python({ args = { "--cov", "--cov-report", "json" } })
    end

    local function make_cpp_entry()
      local gtest = require("neotest-gtest")
      return gtest.setup({})
    end

    return {
      make_python_entry(),
      make_cpp_entry(),
    }
  end

  local function set_keymaps()
    local function map(keybind, action, description)
      local opts = { silent = true, desc = description }
      vim.keymap.set("n", keybind, ":Neotest " .. action .. "<cr>", opts)
    end

    map("<leader>ts", "summary", "[T]est [S]ummary")
    map("<leader>to", "output-panel", "[T]est [O]output")
    map("<leader>tr", "run", "[T]est [R]un")
  end

  require("neotest").setup({ adapters = make_adapters_table() })
  set_keymaps()
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- See: https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "alfaix/neotest-gtest",
  },
  config = configure,
}
