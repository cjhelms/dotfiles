return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_formatter = "<author>, <abbrev_sha>, <author_time:%R> - <summary>",
    })

    local function map(key, cmd, desc)
      vim.api.nvim_set_keymap("n", "<leader>" .. key, ":Gitsigns " .. cmd .. "<cr>", {
        silent = true,
        desc = desc,
      })
    end

    map("gt", "toggle_signs", "[G]itsigns [T]oggle")
    map("gn", "next_hunk", "[G]itsigns [N]ext hunk")
    map("gp", "prev_hunk", "[G]itsigns [P]revious hunk")
    map("gd", "toggle_deleted", "[G]itsigns toggle [D]eleted")
    map("gs", "stage_hunk", "[G]itsigns [S]tage hunk")
    map("gu", "undo_stage_hunk", "[G]itsigns [U]ndo stage hunk")
    map("gr", "reset_hunk", "[G]itsigns [R]eset hunk")

    vim.keymap.set("n", "<leader>gb", function()
      require("gitsigns").blame_line({ full = true })
      vim.defer_fn(function() require("gitsigns").blame_line() end, 100)
    end, {
      silent = true,
      desc = "[G]itsigns [B]lame line (window)",
    })
  end,
}
