local function configure()
  local function make_opts()
    return {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
      },
    }
  end

  local function integrate_with_completion()
    -- See: https://github.com/windwp/nvim-autopairs?tab=readme-ov-file#default-values
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end

  require("nvim-autopairs").setup(make_opts())
  integrate_with_completion()
end

return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = configure,
}
