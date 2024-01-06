-- Check for packer and install if missing
-- See also: https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#bootstrapping
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

-- Install plugins
require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  use("neovim/nvim-lspconfig") -- Makes LSP configuration way easier
  use("williamboman/mason.nvim") -- Installer for LSP servers
  use("williamboman/mason-lspconfig.nvim") -- Hook up Mason and lspconfig
  use("WhoIsSethDaniel/mason-tool-installer.nvim") -- Auto-install LSP servers, formatters, etc.
  use("j-hui/fidget.nvim") -- Useful status updates for LSP
  use("folke/neodev.nvim") -- Configures LSP for Neovim/Lua functions
  use("hrsh7th/nvim-cmp") -- Extended completion capabilities
  use("hrsh7th/cmp-nvim-lsp") -- Integrate nvim-cmp with Neovim LSP client
  use("L3MON4D3/LuaSnip") -- Snippet engine (function snippets, etc.)
  use("saadparwaiz1/cmp_luasnip") -- LuaSnip completion source for nvim-cmp
  use("m-demare/hlargs.nvim") -- Highlight arguments
  use("lervag/vimtex") -- LaTeX support
  use("goolord/alpha-nvim") -- Cool welcome screen
  use("windwp/nvim-autopairs") -- Autocomplete pairs e.g. () or {}
  use("akinsho/toggleterm.nvim") -- Floating terminal
  use("nvim-telescope/telescope-file-browser.nvim") -- Fuzzy search file browser
  use("lewis6991/gitsigns.nvim") -- Git symbols in symbol column
  use("ellisonleao/gruvbox.nvim") -- Theme
  use("nvim-lualine/lualine.nvim") -- Fancier statusline
  use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
  use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
  use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
  use("nvim-treesitter/nvim-treesitter-context") -- Sticky scroll (show context of current scope)
  use("kdheepak/lazygit.nvim") -- Lazygit floating terminal
  use({ "shortcuts/no-neck-pain.nvim", tag = "*" }) -- Center text on screen
  use("sindrets/diffview.nvim") -- Git diff viewer
  use("jbyuki/venn.nvim") -- ASCII art
  use("mfussenegger/nvim-lint") -- Linter support (i.e. non-LSP linters)
  use("stevearc/conform.nvim") -- Code formatter
  use({ "andythigpen/nvim-coverage", requires = "nvim-lua/plenary.nvim" }) -- Code coverage report

  -- Test runner
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim", -- Common utility functions for plugins
      -- See also: https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter", -- Used by some runners for syntax tree
      "nvim-neotest/neotest-python", -- Python test runner (pytest, unittest)
      "alfaix/neotest-gtest", -- C++ test runner (gtest)
    },
  })

  -- Text highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    -- Post-install function is to run ':TSUpdate' on first install
    -- See also: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function() pcall(require("nvim-treesitter.install").update({ with_sync = true })) end,
  })

  -- Additional text objects via treesitter
  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

  -- Fuzzy finder (files, LSP, etc)
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim", -- Common utility functions for plugins
    },
  })

  -- Fuzzy finder algorithm, requires local dependencies to be built, only load if `make` available
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  })

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, "custom.plugins")
  if has_plugins then plugins(use) end

  if is_bootstrap then require("packer").sync() end
end)

if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})
