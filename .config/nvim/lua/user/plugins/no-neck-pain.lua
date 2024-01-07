local function configure()
  local function make_opts()
    return {
      width = 108,
      autocmds = {
        enableOnVimEnter = true,
      },
    }
  end

  local function set_toggle_keymap()
    vim.keymap.set("n", "<leader>nn", ":NoNeckPain<cr>", {
      silent = true,
      desc = "[N]o [N]eck pain",
    })
  end

  require("no-neck-pain").setup(make_opts())
  set_toggle_keymap()
end

return {
  "shortcuts/no-neck-pain.nvim",
  config = configure,
}
