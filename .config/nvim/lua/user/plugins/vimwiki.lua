return {
  "vimwiki/vimwiki",
  config = function()
    vim.api.nvim_set_keymap("n", "<leader>md", "<Plug>VimwikiToggleListItem", { noremap = true, silent = true })
    vim.api.nvim_del_keymap("n", "<Plug>VimwikiUISelect")
  end,
}
