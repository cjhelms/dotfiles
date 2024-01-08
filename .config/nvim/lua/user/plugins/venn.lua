local function configure()
  function _G.Toggle_venn()
    local function venn_enabled_action()
      local function set_motion_keymaps()
        -- Draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
      end

      local function set_draw_box_keymap()
        -- Draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
      end

      vim.b.venn_enabled = true
      vim.cmd([[setlocal ve=all]])
      set_motion_keymaps()
      set_draw_box_keymap()
    end

    local function venn_disabled_action()
      vim.cmd([[setlocal ve=]])
      vim.cmd([[mapclear <buffer>]])
      vim.b.venn_enabled = nil
    end

    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
      venn_enabled_action()
    else
      venn_disabled_action()
    end
  end

  vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
end

return {
  "jbyuki/venn.nvim",
  event = "BufEnter",
  config = configure,
}
