-- Disable built-in netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("user.plugins")
require("user.settings")
require("user.lualine")
require("user.comment")
require("user.indent_blankline")
require("user.gitsigns")
require("user.telescope")
require("user.treesitter")
require("user.cmp")
require("user.null_ls")
require("user.neodev")
require("user.fidget")
require("user.mason_tool_installer")
require("user.mason")
require("user.toggleterm")
require("user.nvim_autopairs")
require("user.alpha_nvim")
require("user.hlargs")
require("user.nvim-treesitter-context")
