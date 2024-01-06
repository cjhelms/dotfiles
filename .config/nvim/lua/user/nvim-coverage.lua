require("coverage").setup({
  commands = true, -- create commands
  highlights = {
    -- customize highlight groups created by the plugin
    covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
    uncovered = { fg = "#F07178" },
  },
  signs = {
    -- use your own highlight groups or text markers
    covered = { hl = "CoverageCovered", text = "▎" },
    uncovered = { hl = "CoverageUncovered", text = "▎" },
  },
  summary = {
    -- customize the summary pop-up
    min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
  },
  lang = {
    -- customize language specific settings
    python = {
      only_open_buffers = true,
    },
  },
})

local function load_and_show() require("coverage").load(true) end

vim.keymap.set("n", "<leader>cl", load_and_show, {
  silent = true,
  desc = "[C]overage [L]oad",
})

vim.keymap.set("n", "<leader>ct", require("coverage").toggle, {
  silent = true,
  desc = "[C]overage [T]oggle",
})

vim.keymap.set("n", "<leader>cs", ":CoverageSummary<cr>", {
  silent = true,
  desc = "[C]overage [S]ummary",
})
