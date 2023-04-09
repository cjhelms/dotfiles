-- Absolute black magic to make LSP work well
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,  -- Use black as Python formatter
    null_ls.builtins.formatting.stylua, -- Use stylua as Lua formatter
    null_ls.builtins.formatting.shfmt,  -- Use shfmt as Bash script formatter
  },
})
