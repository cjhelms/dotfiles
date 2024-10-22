return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
          },
        },
        path_display = {
          "truncate",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-s>"] = actions.file_vsplit,
          },
        },
      },
      pickers = {
        lsp_references = {
          path_display = {
            "truncate",
          },
          show_line = false,
        },
        lsp_document_symbols = {
          layout_config = {
            horizontal = {
              preview_width = 0.4,
            },
          },
          symbol_width = 50,
        },
        lsp_incoming_calls = {
          show_line = false,
        },
        lsp_outgoing_calls = {
          show_line = false,
        },
      },
    })

    telescope.load_extension("fzf")

    local function map(keybind, action, description)
      vim.keymap.set("n", keybind, "<cmd>Telescope " .. action .. "<cr>", { desc = description })
    end

    map("<leader>?", "oldfiles", "[?] Find recently opened files")
    map("<leader><space>", "buffers", "[ ] Find existing buffers")
    map("<leader>sf", "find_files", "[S]earch [F]iles")
    map("<leader>sh", "help_tags", "[S]earch [H]elp")
    map("<leader>sw", "grep_string", "[S]earch current [W]ord")
    map("<leader>sg", "live_grep", "[S]earch by [G]rep")
    map("<leader>sd", "diagnostics", "[S]earch [D]iagnostics")
    map("<leader>sk", "keymaps", "[S]earch [K]eymaps")
    map("<leader>ss", "grep_string", "[S]earch [S]tring")

    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    vim.keymap.set(
      "n",
      "<leader>/",
      function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end,
      { desc = "[/] Fuzzily search in current buffer]" }
    )
  end,
}
