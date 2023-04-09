-- Adds special mode for drawing ASCII art (venn.nvim)
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    -- Turn on the plugin (i.e. enter the special ASCII art drawing mode)
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])

    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })

    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
  else
    -- Turn off the plugin (i.e. exit the special ASCII art drawing mode
    vim.cmd([[setlocal ve=]])
    vim.cmd([[mapclear <buffer>]])
    vim.b.venn_enabled = nil
  end
end

vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
