return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-a>]],
      start_in_insert = false,
    })
  end,
}
