local absolute_path_to_installation = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- See: https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
vim.fn.system({
  "git",
  "clone",
  "--filter=blob:none",
  "https://github.com/folke/lazy.nvim.git",
  "--branch=stable", -- latest stable release
  absolute_path_to_installation,
})

vim.opt.rtp:prepend(absolute_path_to_installation)

local lazy = require("lazy")
lazy.setup("user.plugins")
