-- Remap leader to space bar
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Enable copilot
vim.g.copilot_assume_mapped = true

-- Improve word wrapping
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostics key maps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Set tab stops
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Line number settings
vim.o.relativenumber = true
vim.wo.number = true

-- Set highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = "*",
})

-- Searching settings
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Cursor settings
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- UI settings
vim.o.colorcolumn = "81,101"
vim.wo.signcolumn = "yes"
vim.o.termguicolors = true

-- Miscellaneous settings
vim.o.spell = true
vim.o.list = true
vim.o.listchars = "trail:~"
vim.o.shell = "/usr/bin/bash"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.completeopt = "menuone,noselect"
