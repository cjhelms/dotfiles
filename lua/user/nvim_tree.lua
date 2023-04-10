-- File explorer pane
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  view = {
    side = "right",
  },
})
vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<cr>", { silent = true, desc = "[F]ile [T]ree" })
