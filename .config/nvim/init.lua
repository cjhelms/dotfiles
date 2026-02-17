----------------------
-- General settings --
----------------------

vim.g.mapleader = " "
vim.g.dispatch_no_tmux_make = 1

local o = vim.o
o.winborder = "rounded"
o.number = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.scrolloff = 5
o.list = true
o.confirm = true
o.autoindent = true
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.colorcolumn = "101"
o.swapfile = false
o.signcolumn = "yes"
o.exrc = true
o.hlsearch = false
o.listchars = "trail:~"

------------------
-- Autocommands --
------------------

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function() vim.o.clipboard = "unnamedplus" end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = { "make" },
  callback = function()
    if #vim.fn.getqflist() > 0 then vim.cmd("copen") end
  end,
})

---------------------
-- General keymaps --
---------------------

local function noremap_map(modes, key, command)
  vim.keymap.set(modes, key, command, { noremap = true, silent = true })
end

noremap_map({ "n", "v" }, "<leader>y", '"+y')
noremap_map({ "n", "v" }, "<leader>p", '"+p')
noremap_map({ "n" }, "d", '"_d')
noremap_map({ "n" }, "dd", '"_dd')
noremap_map({ "n" }, "x", "d")
noremap_map({ "n" }, "xx", "dd")
noremap_map({ "n" }, "<leader>a", "<C-^>")

local function normal_map(key, command, desc)
  vim.keymap.set({ "n" }, key, command, { desc = desc, silent = true })
end

normal_map("<leader>ie", ":e $MYVIMRC<cr>", "[I]nit.lua [E]dit")
normal_map("<leader>le", ":e .nvim.lua<cr>", "[L]ocal init.lua [E]dit")
normal_map("<leader>is", ":source $MYVIMRC<cr>", "[I]nit.lua [S]ource")
normal_map("<leader>co", ":copen<cr>", "[O]pen qui[C]kfix")
normal_map("<leader>cc", ":cclose<cr>", "[C]lose qui[C]fix")
normal_map("<leader>qb", ":bd<cr>", "[Q]uit [B]uffer")
normal_map("<leader>qf", ":fc<cr>", "[Q]uit [F]loating window")
normal_map("<leader>qt", ":tabc<cr>", "[Q]uit [T]ab")
normal_map("<leader>qo", ":tabonly | only<cr>", "[Q]uit [O]thers")
normal_map("<C-s>", ":w<cr>", "[W]rite buffer")
normal_map("<C-w>t", ":tabonly<cr>", "[T]ab only")
normal_map("<leader>li", ":LspInfo<cr>", "[L]SP [I]nfo")
normal_map("<leader>m", ":Make<cr>", "[M]ake")
vim.keymap.set("n", "<leader>bh", function()
  local min_width = 100
  local cur_width = vim.api.nvim_win_get_width(0)
  vim.cmd("vnew")
  if cur_width / 2 < min_width then vim.cmd("vertical resize " .. (cur_width - min_width)) end
  vim.cmd("wincmd p")
end, { desc = "[B]uffer left" })

----------
-- Lazy --
----------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

------------------
-- Plugin Specs --
------------------

require("lazy").setup({
  spec = {
    "ellisonleao/gruvbox.nvim",
    "mason-org/mason.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "ibhagwan/fzf-lua",
    "stevearc/conform.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "numToStr/Comment.nvim",
    "kylechui/nvim-surround",
    "neovim/nvim-lspconfig",
    {
      "saghen/blink.cmp",
      version = "1.*",
      dependencies = { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
    },
    "stevearc/oil.nvim",
    "github/copilot.vim",
    "fang2hou/blink-copilot",
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
    "jinh0/eyeliner.nvim",
    "mfussenegger/nvim-dap",
    "tpope/vim-dispatch",
    "j-hui/fidget.nvim",
    {
      "NeogitOrg/neogit",
      dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "ibhagwan/fzf-lua" },
    },
    {
      "danymat/neogen",
      dependencies = { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      init = function() vim.g.no_plugin_maps = true end,
    },
  },
})

--------------------
-- Simple Plugins --
--------------------

require("mason").setup({})
require("treesitter-context").setup({})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "cpp", "python" },
})
require("ibl").setup({ indent = { char = "┊" } })
require("Comment").setup()
require("nvim-surround").setup({})
require("fidget").setup({
  notification = { window = { winblend = 0 } },
})
require("luasnip.loaders.from_vscode").lazy_load()
require("diffview").setup({
  use_icons = false,
})

-------------
-- Gruvbox --
-------------

require("gruvbox").setup({
  transparent_mode = true,
})
o.background = "dark"
vim.cmd("colorscheme gruvbox")

--------------
-- eyeliner --
--------------

vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ff77ff" })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#55ffff" })

--------------
-- gitsigns --
--------------

require("gitsigns").setup({})

normal_map(
  "<leader>gb",
  function() require("gitsigns").blame_line({ full = true }) end,
  "[G]it [B]lame"
)
normal_map("<leader>gf", ":Gitsigns blame<cr>", "[G]it blame [F]ile")
normal_map("]c", function() require("gitsigns").nav_hunk("next") end, "Git next hunk")
normal_map("[c", function() require("gitsigns").nav_hunk("prev") end, "Git previous hunk")
normal_map("<leader>gp", ":Gitsigns preview_hunk<cr>", "[G]itsigns [P]review hunk")
normal_map(
  "<leader>gqq",
  function() require("gitsigns").setqflist(0) end,
  "[G]itsigns [Q]uickfix (current buffer)"
)
normal_map(
  "<leader>gqa",
  function() require("gitsigns").setqflist("all") end,
  "[G]itsigns [Q]uickfix ([A]ll buffers)"
)
normal_map("<leader>gr", ":Gitsigns reset_hunk<cr>", "[G]itsigns [R]eset hunk")

-------------
-- fzf-lua --
-------------

require("fzf-lua").setup({
  "hide",
  defaults = {
    -- places file name first, making long paths easier to read
    formatter = "path.filename_first",
  },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
  actions = {
    files = {
      true, -- Inherit defaults
      ["ctrl-s"] = require("fzf-lua").actions.file_vsplit,
      ["ctrl-h"] = require("fzf-lua").actions.file_split,
    },
  },
})

local function fzf_map(key, command, desc) normal_map(key, ":FzfLua " .. command .. "<cr>", desc) end

fzf_map("<leader>sf", "files", "Search [F]iles")
fzf_map("<leader><leader>", "buffers", "Search open buffers")
fzf_map("<leader>sk", "keymaps", "Search [K]eymaps")
fzf_map("<leader>sh", "helptags", "Search [H]elp")
fzf_map("<leader>sg", "live_grep", "[S]earch ([G]rep) project")
fzf_map("<leader>sw", "grep_cword", "[S]earch [W]ord")
fzf_map("<leader>/", "lgrep_curbuf", "Search buffer")
fzf_map("<leader>dd", "diagnostics_document", "Search [D]iagnostics [D]ocument")
fzf_map("<leader>dw", "diagnostics_workspace", "Search [D]iagnostics [W]orkspace")
fzf_map("<leader>sb", "builtin", "[S]earch [B]uiltins")
fzf_map("<leader>rp", "resume", "[R]esume [P]icker")
fzf_map("<leader>sp", "dap_breakpoints", "[S]earch DAP break[P]oints")

-------------
-- conform --
-------------

require("conform").setup({
  formatters = {
    stylua = {
      prepend_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        2,
        "--column-width",
        100,
        "--collapse-simple-statement",
        "Always",
      },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    python = { "black" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})

normal_map("<leader>f", require("conform").format, "[F]ormat")

-----------
-- blink --
-----------

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  snippets = { preset = "luasnip" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
  },
  sources = {
    default = { "snippets", "copilot", "lsp" },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
})

---------
-- oil --
---------

require("oil").setup({
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
  },
})

normal_map("<leader>e", ":Oil<cr>", "[E]xplore")

-------------
-- luasnip --
-------------

local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })

-------------
-- copilot --
-------------

normal_map(
  "<leader>ct",
  function() require("copilot.copilot").open_codex_terminal() end,
  "[C]odex [T]erminal"
)

-- Block the normal Copilot suggestions
vim.g.copilot_no_maps = true
vim.api.nvim_create_augroup("github_copilot", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
  group = "github_copilot",
  callback = function(args) vim.fn["copilot#On" .. args.event]() end,
})
vim.fn["copilot#OnFileType"]()

-----------------
-- copilot-cli --
-----------------

local gh = require("copilot-cli.copilot-cli")

vim.keymap.set("n", "<leader>gh", gh.CopilotTerminal, {
  desc = "Copilot: Open/focus terminal",
  silent = true,
})

------------
-- neogit --
------------

require("neogit").setup({
  cmd = "Neogit",
})

normal_map("<leader>gg", ":Neogit<cr>", "[G]it [G]ui")

------------
-- neogen --
------------

require("neogen").setup({ snippet_engine = "luasnip" })

normal_map("<Leader>gd", ":lua require('neogen').generate()<CR>", "[G]enerate [D]ocumentation")

---------------------------------
-- nvim-treesitter-textobjects --
---------------------------------

local function ts_select_map(key, object, desc)
  vim.keymap.set(
    { "x", "o" },
    key,
    function()
      require("nvim-treesitter-textobjects.select").select_textobject(object, "textobjects")
    end,
    { desc = desc, silent = true }
  )
end

ts_select_map("am", "@function.outer", "Select outer [M]ethod")
ts_select_map("im", "@function.inner", "Select [I]nner [M]ethod")
ts_select_map("ac", "@class.outer", "Select outer [C]lass")
ts_select_map("ic", "@class.inner", "Select [I]nner [C]lass")

local function ts_move_map(key, object, dir, edge, desc)
  local fn_name = ("goto_%s_%s"):format(dir, edge)
  vim.keymap.set(
    { "n", "x", "o" },
    key,
    function() require("nvim-treesitter-textobjects.move")[fn_name](object, "textobjects") end,
    { silent = true, desc = desc }
  )
end

ts_move_map("]m", "@function.outer", "next", "start", "Jump to next [M]ethod start")
ts_move_map("]M", "@function.outer", "next", "end", "Jump to next [M]ethod end")
ts_move_map("[m", "@function.outer", "previous", "start", "Jump to previous [M]ethod start")
ts_move_map("[M", "@function.outer", "previous", "end", "Jump to previous [M]ethod end")
ts_move_map("]]", "@class.outer", "next", "start", "Jump to next class start")
ts_move_map("][", "@class.outer", "next", "end", "Jump to next class end")
ts_move_map("[[", "@class.outer", "previous", "start", "Jump to previous class start")
ts_move_map("[]", "@class.outer", "previous", "end", "Jump to previous class end")

---------
-- DAP --
---------

local dap = require("dap")

dap.defaults.fallback.terminal_win_cmd = "botright 10new"

local function clean_up_dap(session, body)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      if name:lower():find("dap") then vim.api.nvim_buf_delete(buf, { force = true }) end
    end
  end
end

dap.listeners.after["event_terminated"]["config"] = clean_up_dap
dap.listeners.after["event_exited"]["config"] = clean_up_dap

local dap_ui = require("dap.ui.widgets")

normal_map("<leader>dc", function() dap.continue() end, "[D]ebugger [C]ontinue")
normal_map("<leader>dt", function() dap.terminate() end, "[D]ebugger [T]erminate")
normal_map("<leader>dn", function() dap.step_over() end, "[D]ebugger [N]ext (step over)")
normal_map("<leader>di", function() dap.step_into() end, "[D]ebugger step [I]nto")
normal_map("<leader>do", function() dap.step_out() end, "[D]ebugger step [O]ut")
normal_map("<leader>dl", function() dap.clear_breakpoints() end, "[D]ebugger c[L]ear breakpoints")
normal_map("<leader>db", function() dap.toggle_breakpoint() end, "[D]ebugger toggle [B]reakpoint")
normal_map("<leader>d?", function()
  local condition_status, condition = pcall(function() vim.fn.input("Enter condition: ") end)
  if not condition_status then return end
  local hit_condition_status, hit_condition = pcall(
    function() vim.fn.input("Enter hit condition: ") end
  )
  if not hit_condition_status then return end
  dap.toggle_breakpoint(
    condition ~= "" and condition or nil,
    hit_condition ~= "" and hit_condition or nil
  )
end, "[D]ebugger toggle conditional breakpoint")
normal_map("<leader>dr", function() dap.repl.open() end, "[D]ebugger [R]epl")
normal_map("<leader>dh", function() dap_ui.hover() end, "[D]ebugger [H]over")
normal_map("<leader>df", function() dap_ui.centered_float(dap_ui.frames) end, "[D]ebugger [F]rames")
normal_map("<leader>dp", function() dap_ui.centered_float(dap_ui.scopes) end, "[D]ebugger sco[P]es")

---------
-- LSP --
---------

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local lsp_map = function(keybind, action, description)
      if description then description = "LSP: " .. description end
      vim.keymap.set("n", keybind, action, { buffer = ev.buf, silent = true, desc = description })
    end

    local fzf = require("fzf-lua")
    local lsp = vim.lsp.buf
    lsp_map("<leader>rn", lsp.rename, "[R]e[n]ame")
    lsp_map("<leader>ca", lsp.code_action, "[C]ode [A]ction")
    lsp_map("gd", lsp.definition, "[G]oto [D]efinition")
    lsp_map("gr", fzf.lsp_references, "[G]oto [R]eferences")
    lsp_map("gI", lsp.implementation, "[G]oto [I]mplementation")
    lsp_map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
    lsp_map("<leader>gi", lsp.incoming_calls, "[G]o-to [I]ncoming calls")
    lsp_map("<leader>go", lsp.outgoing_calls, "[G]o-to [O]utgoing calls")
    lsp_map("K", lsp.hover, "Hover Documentation")
    lsp_map("<C-k>", lsp.signature_help, "Signature Documentation")
    lsp_map("gD", lsp.declaration, "[G]oto [D]eclaration")
    lsp_map("<leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
    lsp_map("<leader>sr", ":LspRestart<cr>", "[S]erver [R]estart")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "clangd" then
      lsp_map("<leader>cs", ":LspClangdSwitchSourceHeader<cr>", "[C]langd [S]witch source/header")
    end
  end,
})

vim.lsp.enable({ "lua_ls", "pyright", "clangd", "gdscript" })
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
