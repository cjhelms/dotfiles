local function configure()
  vim.keymap.set("n", "<leader>lg", ":LazyGit<cr>", { silent = true, desc = "[L]azy[G]it" })
end

return {
  "kdheepak/lazygit.nvim",
  config = configure,
}
