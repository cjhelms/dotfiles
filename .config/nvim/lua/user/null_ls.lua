-- Absolute black magic to make LSP work well
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "79" } }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.gdformat,
  },
})
