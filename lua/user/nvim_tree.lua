-- File explorer pane
require("nvim-tree").setup({
  view = {
    side = "right",
  },
})
vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<cr>", { silent = true, desc = "[F]ile [T]ree" })
