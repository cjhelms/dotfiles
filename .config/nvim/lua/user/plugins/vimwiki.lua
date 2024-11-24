return {
  "vimwiki/vimwiki",
  config = function()
    local function unmap(cmd) vim.api.nvim_del_keymap("n", "<Plug>" .. cmd) end

    unmap("VimwikiUISelect")

    local function map(key, cmd, desc)
      vim.api.nvim_set_keymap("n", "<leader>" .. key, "<Plug>" .. cmd, { noremap = true, silent = true, desc = desc })
    end

    map("md", "VimwikiToggleListItem", "Vimwiki [M]ark [D]one")
    map("wv", "VimwikiVSplitLink", "Vim[W]iki follow link in [V]ertical split")
  end,
}
