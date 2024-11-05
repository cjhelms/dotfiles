return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({})
    vim.api.nvim_set_keymap(
      "n",
      "<leader>nt",
      ":NvimTreeToggle<cr>",
      { noremap = true, silent = true, desc = "[N]vim [T]ree toggle" }
    )
  end,
}
