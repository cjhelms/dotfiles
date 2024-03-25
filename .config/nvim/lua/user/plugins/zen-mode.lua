return {
  "folke/zen-mode.nvim",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>zm", ":ZenMode<cr>", {
      silent = true,
      desc = "[Z]en [M]ode",
    })
  end
}
