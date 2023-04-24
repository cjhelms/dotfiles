-- Absolute black magic to make LSP work well
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "100" } }), -- Use black as Python formatter
    null_ls.builtins.diagnostics.flake8,                                                 -- Use flake8 for linting Python source code
    null_ls.builtins.formatting.stylua,                                                  -- Use stylua as Lua formatter
  },
})
