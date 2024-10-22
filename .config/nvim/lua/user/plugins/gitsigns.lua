return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_formatter = "<author>, <abbrev_sha>, <author_time:%R> - <summary>",
    })

    vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_signs<cr>", {
      silent = true,
      desc = "[G]itsigns [T]oggle",
    })

    vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<cr>", {
      silent = true,
      desc = "[G]itsigns [N]ext hunk",
    })

    vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>", {
      silent = true,
      desc = "[G]itsigns [P]revious hunk",
    })

    vim.keymap.set("n", "<leader>gb", function()
      require("gitsigns").blame_line({ full = true })
      vim.defer_fn(function() require("gitsigns").blame_line() end, 100)
    end, {
      silent = true,
      desc = "[G]itsigns [B]lame line (window)",
    })
  end,
}
