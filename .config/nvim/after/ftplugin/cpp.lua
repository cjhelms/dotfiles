local gtest = require("gtest.gtest")
vim.keymap.set("n", "<leader>tf", ":GTestRun ", { desc = "[T]est with [F]ilter" })
vim.keymap.set(
  "n",
  "<leader>tt",
  function() vim.cmd("GTestRun " .. gtest.get_gtest_under_cursor()) end,
  { desc = "[T]est under cursor" }
)
vim.keymap.set("n", "<leader>du", function()
  local dap = require("dap")
  local config = vim.deepcopy(dap.configurations.cpp[1]) -- Assumes config has been set up
  config.args = { "--gtest_filter=" .. require("gtest.gtest").get_gtest_under_cursor() }
  dap.run(config)
end, { desc = "[D]ebugger run test [U]nder cursor" })
