local function make_ensure_installed_list()
  return {
    "stylua",
    "shellcheck",
    "mypy",
    "flake8",
    "black",
    "gdtoolkit",
    "shfmt",
    "isort",
  }
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  opts = { ensure_installed = make_ensure_installed_list() }
}
