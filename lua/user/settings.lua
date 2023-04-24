-- Map space as leader key, must map before plugins are required
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Set current working directory to active buffer
vim.keymap.set("n", "<leader>wd", ":cd %:p:h<cr>", { silent = true, desc = "Set [W]orking [D]irectory to active buffer" })

-- Deal with word wrapping better
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Formatting using LSP
vim.keymap.set("n", "<leader>f", ":Format<cr>", { silent = true, desc = "[F]ormat" })

-- General settings
vim.o.spell = true
vim.o.list = true
vim.o.listchars = "trail:~"
vim.o.shell = "/usr/bin/bash"          -- Specify shell to use
vim.o.tabstop = 2                      -- Number of spaces per tab
vim.o.shiftwidth = 2                   -- Number of spaces per auto-indentation
vim.o.expandtab = true                 -- Use spaces instead of tab chars
vim.o.relativenumber = true            -- Use relative line numbers
vim.o.hlsearch = false                 -- Set highlight on search
vim.wo.number = true                   -- Make line numbers default
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case insensitive searching by default
vim.o.smartcase = true                 -- Override ignorecase if capital letter is in search
vim.o.updatetime = 250                 -- Decrease update time
vim.wo.signcolumn = "yes"              -- Column where e.g. git symbols show up
vim.o.termguicolors = true             -- Better colors
vim.cmd([[colorscheme gruvbox]])       -- Super rad theme
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.colorcolumn = "101"              -- Set column ruler at line 100
vim.o.cursorline = true                -- Highlight line cursor is on
vim.o.cursorcolumn = true              -- Highlight column cursor is on

-- Highlight on yank (copy) for better visibility
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = "*",
})
