local function configure()
  local on_attach = function(_, bufnr)
    local make_keymap = function(keys, func, desc)
      if desc then desc = "LSP: " .. desc end
      vim.make_keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    make_keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    make_keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    make_keymap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    make_keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    make_keymap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    make_keymap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    make_keymap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    make_keymap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    make_keymap("K", vim.lsp.buf.hover, "Hover Documentation")
    make_keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    make_keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    make_keymap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    make_keymap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    make_keymap(
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      "[W]orkspace [L]ist Folders"
    )

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
}
