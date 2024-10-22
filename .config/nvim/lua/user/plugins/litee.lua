return {
  "ldelossa/litee.nvim",
  event = "VeryLazy",
  opts = {
    notify = { enabled = false },
    panel = {
      orientation = "bottom",
      panel_size = 20,
    },
  },
  config = function(_, opts) require("litee.lib").setup(opts) end,
}
