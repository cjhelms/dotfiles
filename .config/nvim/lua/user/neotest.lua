require("neotest").setup({
  adapters = {
    require("neotest-python")({
      args = { "--cov", "--cov-report", "json" },
    }),
  },
  icons = {
    child_indent = "│",
    child_prefix = "├",
    collapsed = "─",
    expanded = "╮",
    failed = "x",
    final_child_indent = " ",
    final_child_prefix = "╰",
    non_collapsible = "─",
    passed = "+",
    running = "o",
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
    skipped = "()",
    unknown = "?",
    watching = "0",
  },
})

vim.keymap.set("n", "<leader>ts", ":Neotest summary<cr>", {
  silent = true,
  desc = "[T]est [S]ummary",
})

vim.keymap.set("n", "<leader>to", ":Neotest output-panel<cr>", {
  silent = true,
  desc = "[T]est [O]output",
})

vim.keymap.set("n", "<leader>tr", ":Neotest run<cr>", {
  silent = true,
  desc = "[T]est [R]un",
})
