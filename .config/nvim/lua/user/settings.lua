-- Function to check if Python version is less than 3.10
local function is_python_version_less_than_3_10()
  local python_version = vim.fn.system("python3 --version 2>&1")
  local version_number = string.match(python_version, "Python (%d+%.%d+)")
  if version_number then
    local major, minor = string.match(version_number, "(%d+)%.(%d+)")
    major = tonumber(major)
    minor = tonumber(minor)
    if major < 3 or (major == 3 and minor < 10) then return true end
  end
  return false
end

-- Set Neovim's Python provider, assuming 3.10 is available (thanks to dev container)
if is_python_version_less_than_3_10() then vim.g.python3_host_prog = "/usr/bin/python3.10" end

-- Vimwiki required settings
vim.opt.compatible = false
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

-- Text manipulation.
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "x", "d", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "xx", "dd", { noremap = true, silent = true })

-- Remap leader to space bar
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+yg_', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', { noremap = true, silent = true })

-- Paste from clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>P", '"+P', { noremap = true, silent = true })

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
