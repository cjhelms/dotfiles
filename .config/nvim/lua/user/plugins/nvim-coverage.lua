return {
  "andythigpen/nvim-coverage",
  event = "BufEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("coverage").setup({
      lang = {
        python = { only_open_buffers = true },
      },
    })

    local function map(keybind, action, description)
      vim.keymap.set("n", keybind, action, { silent = true, desc = description })
    end

    map("<leader>cl", function() require("coverage").load(true) end, "[C]overage [L]oad")
    map("<leader>ct", require("coverage").toggle, "[C]overage [T]oggle")
    map("<leader>cs", ":CoverageSummary<cr>", "[C]overage [S]ummary")
  end,
}
