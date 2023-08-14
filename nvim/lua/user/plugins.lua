-- Check for packer and install if missing
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

  -- Makes LSP configuration way easier
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",               -- Installer for LSP servers
      "williamboman/mason-lspconfig.nvim",     -- Hook up Mason and lspconfig
      { "j-hui/fidget.nvim", tag = "legacy" }, -- Useful status updates for LSP
      "folke/neodev.nvim",                     -- Extra lua configuration, makes nvim stuff amazing
    },
  })

  -- Autocompletion (black magic)
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",     -- Black magic
      "L3MON4D3/LuaSnip",         -- Black magic
      "saadparwaiz1/cmp_luasnip", -- Black magic
    },
  })

  -- Highlight, edit, and navigate code
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function() pcall(require("nvim-treesitter.install").update({ with_sync = true })) end,
  })

  -- Additional text objects via treesitter
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  })

  -- Fuzzy finder (files, lsp, etc)
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim", -- Common utility functions for plugins
    },
  })

  -- Fuzzy finder algorithm, requires local deps to be built, only load if `make` available
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  })

  use("m-demare/hlargs.nvim")                       -- Highlight arguments
  use("lervag/vimtex")                              -- LaTeX support
  use("goolord/alpha-nvim")                         -- Cool welcome screen
  use("windwp/nvim-autopairs")                      -- Autocomplete pairs e.g. () or {}
  use("akinsho/toggleterm.nvim")                    -- Floating terminal
  use("WhoIsSethDaniel/mason-tool-installer.nvim")  -- Auto-install LSP servers, formatters, etc.
  use("nvim-telescope/telescope-file-browser.nvim") -- Fuzzy search file browser
  use("lewis6991/gitsigns.nvim")                    -- Git symbols in symbol column
  use("morhetz/gruvbox")                            -- Theme
  use("nvim-lualine/lualine.nvim")                  -- Fancier statusline
  use("lukas-reineke/indent-blankline.nvim")        -- Add indentation guides even on blank lines
  use("numToStr/Comment.nvim")                      -- "gc" to comment visual regions/lines
  use("tpope/vim-sleuth")                           -- Detect tabstop and shiftwidth automatically
  use("jose-elias-alvarez/null-ls.nvim")            -- Code formatting
  use("nvim-treesitter/nvim-treesitter-context")    -- Sticky scroll
  use("ptzz/lf.vim")                                -- LF file browser
  use("voldikss/vim-floaterm")                      -- Floating terminal for LF file browser
  use("kdheepak/lazygit.nvim")                      -- Lazygit floating terminal

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
