local function configure()
  local function make_linters_table()
    return {
      python = { "mypy", "flake8" },
    }
  end

  local function set_linting_autocmd()
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
      callback = function() require("lint").try_lint() end,
    })
  end

  require("lint").linters_by_ft = make_linters_table()
  set_linting_autocmd()
end

return {
  "mfussenegger/nvim-lint",
  config = configure,
}
