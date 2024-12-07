return {
  "aaronhallaert/advanced-git-search.nvim",
  cmd = { "AdvancedGitSearch" },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>agf",
      "<cmd>AdvancedGitSearch diff_commit_file<cr>",
      { desc = "[A]dvanced [G]it search [F]ile" }
    )
    vim.keymap.set(
      "n",
      "<leader>agl",
      "<cmd>AdvancedGitSearch diff_commit_line<cr>",
      { desc = "[A]dvanced [G]it search selected [L]ines" }
    )
    vim.keymap.set("n", "<leader>agm", "<cmd>AdvancedGitSearch<cr>", { desc = "[A]dvanced [G]it search [M]enu" })
  end,
  dependencies = {
    "sindrets/diffview.nvim",
  },
}
