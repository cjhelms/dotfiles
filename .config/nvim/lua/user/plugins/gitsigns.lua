local function configure()
  local function make_opts()
    return { current_line_blame = true }
  end

  require("gitsigns").setup(make_opts())
  vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_signs<cr>", {
    silent = true,
    desc = "[G]itsigns [T]oggle",
  })
end

return {
  "lewis6991/gitsigns.nvim",
  config = configure,
}
