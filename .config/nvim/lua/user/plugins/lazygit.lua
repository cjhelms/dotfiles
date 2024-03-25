return {
  "kdheepak/lazygit.nvim",
  config = function()
    vim.keymap.set("n", "<leader>lg", ":LazyGit<cr>", {
      silent = true,
      desc = "[L]azy[G]it",
    })
  end,
}
