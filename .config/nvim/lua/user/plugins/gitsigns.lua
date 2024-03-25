return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require("gitsigns").setup({ current_line_blame = true })

    vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_signs<cr>", {
      silent = true,
      desc = "[G]itsigns [T]oggle",
    })
  end,
}
