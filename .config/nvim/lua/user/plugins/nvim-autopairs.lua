return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
      },
      enable_check_bracket_line = false,
    })

    -- See: https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#default-values
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
