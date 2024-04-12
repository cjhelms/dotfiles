return {
  "WhoIsSethDaniel/mason-tool-installer",
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "shellcheck",
        "shfmt",
      },
      run_on_start = false,
    })
  end,
}
