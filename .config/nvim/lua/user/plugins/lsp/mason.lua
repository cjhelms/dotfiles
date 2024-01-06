local function make_ensure_installed_list()
  return {
    "bashls",
    "lua_ls",
    "clangd",
    "pyright",
    "texlab",
  }
end

local function configure()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = make_ensure_installed_list(),
    automatic_installation = true,
  })
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- mason_lspconfig.setup_handlers({
  --   function(server_name)
  --     if server_name == "pyright" then
  --       -- Special configuration to get Pyright to ignore setup.py files as root of project
  --       require("lspconfig")[server_name].setup({
  --         capabilities = capabilities,
  --         on_attach = on_attach,
  --         root_dir = function(fname)
  --           local util = require("lspconfig/util")
  --           local root_files = {
  --             "pyproject.toml",
  --             "setup.cfg",
  --             "requirements.txt",
  --             "Pipfile",
  --             "pyrightconfig.json",
  --           }
  --           return util.root_pattern(unpack(root_files))(fname)
  --               or util.find_git_ancestor(fname)
  --               or util.path.dirname(fname)
  --         end,
  --         settings = servers[server_name],
  --       })
  --     else
  --       require("lspconfig")[server_name].setup({
  --         capabilities = capabilities,
  --         on_attach = on_attach,
  --         settings = servers[server_name],
  --       })
  --     end
  --   end,
  -- })

  -- require("lspconfig").gdscript.setup({
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  --   filetypes = { "gd", "gdscript", "gdscript3" },
  -- })
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = configure
}
