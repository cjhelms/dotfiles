return {
  "mfussenegger/nvim-dap",
  dependencies = { "ldelossa/nvim-dap-projects" },
  config = function()
    local dap = require("dap")

    local dap_projects = require("nvim-dap-projects")
    dap_projects.search_project_config()

    dap.set_log_level("TRACE")
    dap.defaults.fallback.auto_continue_if_many_stopped = false

    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-vscode-14",
      name = "lldb",
    }

    local function map_key(key, cmd, desc)
      vim.api.nvim_set_keymap("n", key, cmd, { noremap = true, silent = true, desc = desc })
    end

    map_key("<Leader>dc", ":lua require('dap').continue()<CR>", "[D]ebugger [C]ontinue")
    map_key("<Leader>db", ":lua require('dap').toggle_breakpoint()<CR>", "[D]ebugger Toggle [B]reakpoint")
    map_key("<Leader>dn", ":lua require('dap').step_over()<CR>", "[D]ebugger [N]ext (Step Over)")
    map_key("<Leader>di", ":lua require('dap').step_into()<CR>", "[D]ebugger Step [I]nto")
    map_key("<Leader>do", ":lua require('dap').step_out()<CR>", "[D]ebugger Step [O]ut")
    map_key("<Leader>dt", ":lua require('dap').terminate()<CR>", "[D]ebugger [T]erminate")
  end,
}
