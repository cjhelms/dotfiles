local absolute_path_to_installation = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function is_installed() return vim.loop.fs_stat(absolute_path_to_installation) end

local function bootstrap()
  -- See: https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    absolute_path_to_installation,
  })
end

local function maybe_bootstrap()
  if not is_installed() then bootstrap() end
end

local function configure()
  vim.opt.rtp:prepend(absolute_path_to_installation)
end

local function load_plugins()
  local lazy = require("lazy")
  lazy.setup("user.plugins")
end

maybe_bootstrap()
configure()
load_plugins()
