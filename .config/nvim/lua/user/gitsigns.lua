require("gitsigns").setup({
  current_line_blame = true,
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_signs<cr>", {
  silent = true,
  desc = "[G]itsigns [T]oggle",
})
