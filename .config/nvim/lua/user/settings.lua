local function disable_built_in_network_read_write()
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

local function set_space_as_leader()
  -- Must map before plugins are loaded!!
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
end

local function make_set_current_working_directory_to_active_buffer_keymap()
  vim.keymap.set(
    "n",
    "<leader>wd",
    ":cd %:p:h<cr>",
    { silent = true, desc = "Set [W]orking [D]irectory to active buffer" }
  )
end

local function improve_word_wrapping()
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
end

local function set_diagnostics_keymaps()
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
end

local function set_general_settings()
  local function set_tab_settings()
    vim.o.tabstop = 2
    vim.o.shiftwidth = 2
    vim.o.expandtab = true
  end

  local function set_line_number_settings()
    vim.o.relativenumber = true
    vim.wo.number = true
  end

  local function set_highlight_on_yank()
    local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function() vim.highlight.on_yank() end,
      group = highlight_group,
      pattern = "*",
    })
  end

  local function set_search_settings()
    vim.o.hlsearch = false
    vim.o.ignorecase = true
    vim.o.smartcase = true
  end

  local function set_cursor_settings()
    vim.o.cursorline = true -- Highlight line cursor is on
    vim.o.cursorcolumn = true -- Highlight column cursor is on
  end

  local function set_ui_settings()
    vim.o.colorcolumn = "81,101"
    vim.wo.signcolumn = "yes"
    vim.o.termguicolors = true
  end

  local function set_miscellaneous_settings()
    vim.o.spell = true
    vim.o.list = true
    vim.o.listchars = "trail:~"
    vim.o.shell = "/usr/bin/bash"
    vim.o.breakindent = true
    vim.o.undofile = true
    vim.o.updatetime = 250
    vim.o.completeopt = "menuone,noselect"
  end

  set_tab_settings()
  set_line_number_settings()
  set_search_settings()
  set_ui_settings()
  set_cursor_settings()
  set_highlight_on_yank()
  set_miscellaneous_settings()
end

local function disable_lf_keymap() vim.cmd([[let g:lf_map_keys = 0]]) end

disable_built_in_network_read_write()
set_space_as_leader()
make_set_current_working_directory_to_active_buffer_keymap()
improve_word_wrapping()
set_diagnostics_keymaps()
set_general_settings()
disable_lf_keymap()
