return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
    "aaronhallaert/advanced-git-search.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        cache_picker = {
          num_pickers = 20,
        },
        layout_strategy = "flex",
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
      extensions = {
        live_grep_args = {
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              -- freeze the current list and start a fuzzy search in the frozen list
              ["<C-space>"] = actions.to_fuzzy_refine,
            },
          },
        },
        advanced_git_search = {
          diff_plugin = "diffview",
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("advanced_git_search")

    local function map(keybind, action, description)
      vim.keymap.set("n", keybind, "<cmd>Telescope " .. action .. "<cr>", { desc = description })
    end

    map("<leader>?", "oldfiles", "[?] Find recently opened files")
    map("<leader>/", "current_buffer_fuzzy_find", "[/] Find in current buffer")
    map("<leader><space>", "buffers", "[ ] Find existing buffers")
    map("<leader>sf", "find_files", "[S]earch [F]iles")
    map("<leader>sh", "help_tags", "[S]earch [H]elp")
    map("<leader>sc", "grep_string", "[S]earch [c]urrent word")
    map("<leader>sg", "live_grep_args", "[S]earch by [G]rep (with args)")
    map("<leader>sd", "diagnostics", "[S]earch [D]iagnostics")
    map("<leader>sk", "keymaps", "[S]earch [K]eymaps")
    map("<leader>ss", "grep_string", "[S]earch [S]tring")
    map("<leader>rp", "resume", "[R]esume last [P]icker")
    map("<leader>sp", "pickers", "[S]earch recent [P]ickers")
  end,
}
