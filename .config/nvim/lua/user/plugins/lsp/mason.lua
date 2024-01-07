local function configure()
  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = true,
  })
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim"
  },
  config = configure
}
