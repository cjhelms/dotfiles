local function configure()
  local function make_opts()
    return {
      close_if_last_window = true,
      window = {
        mappings = {
          ["Z"] = "expand_all_nodes",
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
    }
  end

  require("neo-tree").setup(make_opts())
  vim.keymap.set("n", "<leader>nt", "<cmd>Neotree toggle<cr>", { desc = "Toggle [N]eo[T]ree" })
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
  },
  config = configure,
}
