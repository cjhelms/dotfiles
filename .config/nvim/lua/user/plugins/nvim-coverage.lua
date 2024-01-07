local function configure()
  local function make_opts()
    local function make_python_opts() return { only_open_buffers = true } end

    return {
      lang = {
        python = make_python_opts(),
      },
    }
  end

  local function set_keymaps()
    local function map(keybind, action, description)
      vim.keymap.set("n", keybind, action, { silent = true, desc = description })
    end

    map("<leader>cl", function() require("coverage").load(true) end, "[C]overage [L]oad")
    map("<leader>ct", require("coverage").toggle, "[C]overage [T]oggle")
    map("<leader>cs", ":CoverageSummary<cr>", "[C]overage [S]ummary")
  end

  require("coverage").setup(make_opts())
  set_keymaps()
end

return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = configure,
}
