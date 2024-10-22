return {
  "ellisonleao/gruvbox.nvim",
  opts = { transparent_mode = true },
  config = function()
    vim.cmd([[colorscheme gruvbox]])
    vim.api.nvim_exec([[
      highlight Normal guibg=NONE
      highlight NonText guibg=NONE
      highlight SignColumn guibg=NONE
    ]], false)
  end,
}
