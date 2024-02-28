local function make_ensure_installed_list()
  return {
    "stylua",
    "shellcheck",
    "flake8",
    "black",
    "isort",
    "pyright",
    "clangd",
    "lua_ls",
    "bashls",
  }
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  opts = { ensure_installed = make_ensure_installed_list() },
}
