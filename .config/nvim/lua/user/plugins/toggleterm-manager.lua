return {
  "ryanmsnyder/toggleterm-manager.nvim",
  dependencies = {
    "akinsho/nvim-toggleterm.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
  },
  config = function()
    require("toggleterm-manager").setup()
    vim.keymap.set("n", "<leader>tm", ":Telescope toggleterm_manager<cr>", {
      silent = true,
      desc = "[T]oggleterm [M]anager",
    })
  end,
}
