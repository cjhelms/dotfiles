return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local on_attach = function(_, bufnr)
      local map = function(keybind, action, description)
        if description then description = "LSP: " .. description end
        vim.keymap.set("n", keybind, action, { buffer = bufnr, desc = description })
      end

      local builtin = require("telescope.builtin")
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      map("gr", builtin.lsp_references, "[G]oto [R]eferences")
      map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
      map("<leader>gi", vim.lsp.buf.incoming_calls, "[G]o-to [I]ncoming calls")
      map("<leader>go", vim.lsp.buf.outgoing_calls, "[G]o-to [O]utgoing calls")
      map("K", vim.lsp.buf.hover, "Hover Documentation")
      map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      map("<leader>sr", ":LspRestart<cr>", "[S]erver [R]estart")
      map("<leader>cs", ":ClangdSwitchSourceHeader<cr>", "[C]langd [S]witch source/header")
      map(
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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,
    })
  end,
}
