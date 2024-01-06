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

local function load()
  if not is_installed() then bootstrap() end
  vim.opt.rtp:prepend(absolute_path_to_installation)
end

local function make_import_table()
  return {
    {import = "user.plugins"},
    {import = "user.plugins.lsp"},
  }
end

local function load_plugins()
  local lazy = require("lazy")
  local import_table = make_import_table()
  lazy.setup(import_table)
end

load()
load_plugins()
