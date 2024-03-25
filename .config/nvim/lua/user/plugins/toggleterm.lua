return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader>tt]],
      start_in_insert = false,
    })
  end,
}
