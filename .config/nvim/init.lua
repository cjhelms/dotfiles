vim.g.mapleader = " "

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
o.colorcolumn = "100"
o.swapfile = false
o.signcolumn = "yes"
o.exrc = true
o.hlsearch = false
o.listchars = "trail:~"

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
normal_map("<leader>is", ":source $MYVIMRC<cr>", "[I]nit.lua [S]ource")
normal_map("<leader>co", ":copen<cr>", "[O]pen qui[C]kfix")
normal_map("<leader>cc", ":cclose<cr>", "[C]lose qui[C]fix")
normal_map("<leader>qw", ":bd<cr>", "[Q]uit [W]indow")
normal_map("<leader>qf", ":fc<cr>", "[Q]uit [F]loating window")
normal_map("<leader>qt", ":tabc<cr>", "[Q]uit [T]ab")
normal_map("<C-s>", ":w<cr>", "[Q]uit buffer")
normal_map("<C-w>t", ":tabonly<cr>", "[T]ab only")

vim.api.nvim_create_autocmd("QuickFixCmdPre", {
  pattern = { "make", "grep" },
  callback = function()
    local qflist = vim.fn.getqflist()
    if qflist and qflist.winid ~= 0 then vim.cmd("cclose") end
  end,
})
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = { "make", "grep" },
  callback = function()
    if #vim.fn.getqflist() > 0 then vim.cmd("copen") end
  end,
})
normal_map("<leader>m", ":make<cr>", "[M]ake")

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

require("lazy").setup({
  spec = {
    "savq/paq-nvim",
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
    { "saghen/blink.cmp", version = "1.*" },
    "stevearc/oil.nvim",
    "github/copilot.vim",
    "fang2hou/blink-copilot",
    "NeogitOrg/neogit",
    "sindrets/diffview.nvim",
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim",
    "jinh0/eyeliner.nvim",
    "mfussenegger/nvim-dap",
  },
})

o.background = "dark"
vim.cmd("colorscheme gruvbox")

require("mason").setup({})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "cpp", "python" },
})
require("treesitter-context").setup({})
require("fzf-lua").setup({ "telescope" })
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
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
require("ibl").setup({ indent = { char = "┊" } })
require("Comment").setup()
require("nvim-surround").setup({})
require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 0 },
  },
  sources = {
    default = { "copilot", "lsp" },
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
require("oil").setup({
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
  },
})
require("neogit").setup({
  integrations = {
    fzf_lua = true,
    diffview = true,
  },
})
require("diffview").setup({
  use_icons = false,
})
require("gitsigns").setup({})

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
normal_map("<leader>f", require("conform").format, "[F]ormat")
normal_map("<leader>e", ":Oil<cr>", "[E]xplore")

-- Block the normal Copilot suggestions
vim.g.copilot_no_maps = true
vim.api.nvim_create_augroup("github_copilot", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
  group = "github_copilot",
  callback = function(args) vim.fn["copilot#On" .. args.event]() end,
})
vim.fn["copilot#OnFileType"]()

normal_map("<leader>ng", function() require("neogit").open({ kind = "split" }) end, "[N]eo[G]it")

normal_map(
  "<leader>gb",
  function() require("gitsigns").blame_line({ full = true }) end,
  "[G]it [B]lame"
)
normal_map("<leader>gf", ":Gitsigns blame<cr>", "[G]it blame [F]ile")
normal_map("<leader>gn", function() require("gitsigns").nav_hunk("next") end, "[G]it blame [F]ile")
normal_map("<leader>gp", function() require("gitsigns").nav_hunk("prev") end, "[G]it blame [F]ile")
normal_map("<leader>gp", ":Gitsigns preview_hunk<cr>", "[G]itsigns [P]review hunk")
normal_map(
  "<leader>gqq",
  function() require("gitsigns").setqflist(0) end,
  "[G]itsigns [P]review hunk"
)
normal_map(
  "<leader>gqa",
  function() require("gitsigns").setqflist("all") end,
  "[G]itsigns [P]review hunk"
)
normal_map("<leader>gr", ":Gitsigns reset_hunk<cr>", "[G]itsigns [R]eset hunk")

vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#ff77ff" })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#55ffff" })

normal_map("<leader>dc", function() require("dap").continue() end, "[D]ebugger [C]ontinue")
normal_map("<leader>dt", function() require("dap").terminate() end, "[D]ebugger [T]erminate")
normal_map("<leader>dn", function() require("dap").step_over() end, "[D]ebugger [N]ext (step over)")
normal_map("<leader>di", function() require("dap").step_into() end, "[D]ebugger step [I]nto")
normal_map("<leader>do", function() require("dap").step_out() end, "[D]ebugger step [O]ut")
normal_map(
  "<leader>db",
  function() require("dap").toggle_breakpoint() end,
  "[D]ebugger toggle [B]reakpoint"
)
normal_map("<leader>dr", function() require("dap").repl.open() end, "[D]ebugger [R]epl")
normal_map("<leader>dh", function() require("dap.ui.widgets").hover() end, "[D]ebugger [H]over")
normal_map("<leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end, "[D]ebugger [F]rames")
normal_map("<leader>dp", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, "[D]ebugger sco[P]es")

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

vim.lsp.enable({ "lua_ls", "pyright", "clangd" })
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})
