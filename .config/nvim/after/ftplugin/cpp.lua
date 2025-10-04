local gtest = require("gtest.gtest")
vim.keymap.set("n", "<leader>tf", ":GTestRun ", { desc = "[T]est with [F]ilter" })
vim.keymap.set(
  "n",
  "<leader>tt",
  function() vim.cmd("GTestRun " .. gtest.get_gtest_under_cursor()) end,
  { desc = "[T]est under cursor" }
)
