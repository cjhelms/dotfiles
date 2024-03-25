return {
  "mfussenegger/nvim-lint",
  event = "BufEnter",
  config = function()
    require("lint").linters_by_ft = { bash = { "shellcheck" } }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
      callback = function() require("lint").try_lint() end,
    })
  end,
}
