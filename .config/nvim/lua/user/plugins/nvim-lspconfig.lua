local function configure()
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
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
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

  local function setup_servers()
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local function make_opts_table()
      return {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end

    local function make_pyright_opts_table()
      local function make_root_dir_function()
        return function(fname)
          local util = require("lspconfig/util")
          local root_files = {
            "pyproject.toml",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
          }
          return util.root_pattern(unpack(root_files))(fname)
            or util.find_git_ancestor(fname)
            or util.path.dirname(fname)
        end
      end

      local opts_table = make_opts_table()
      table.insert(opts_table, { root_dir = make_root_dir_function() })
      return opts_table
    end

    local function make_lua_ls_opts_table()
      local function make_diagnostics_table()
        -- Acknowledge the 'vim' global variable
        return { globals = { "vim" } }
      end

      local function make_workspace_table()
        -- Make language server aware of runtime files
        return {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        }
      end

      local function make_lua_settings_table()
        return {
          diagnostics = make_diagnostics_table(),
          workspace = make_workspace_table(),
        }
      end

      local opts_table = make_opts_table()
      opts_table["settings"] = { Lua = make_lua_settings_table() }
      return opts_table
    end

    local function make_gdscript_opts_table()
      local opts_table = make_opts_table()
      table.insert(opts_table, { filetypes = { "gd", "gdscript", "gdscript3" } })
      return opts_table
    end

    local function setup(name, opts_table) lspconfig[name].setup(opts_table) end

    setup("pyright", make_pyright_opts_table())
    setup("bashls", make_opts_table())
    setup("lua_ls", make_lua_ls_opts_table())
    setup("clangd", make_opts_table())
    setup("gdscript", make_gdscript_opts_table())
  end

  require("mason-lspconfig").setup({ automatic_installation = true })
  setup_servers()
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = configure,
}
