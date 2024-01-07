local function set_current_buffer_search_keymap()
  vim.keymap.set(
    "n",
    "<leader>/",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end,
    { desc = "[/] Fuzzily search in current buffer]" }
  )
end

local function set_keymaps()
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
  set_current_buffer_search_keymap()
end

local function make_opts()
  local actions = require("telescope.actions")
  return {
    defaults = {
      path_display = {
        "truncate",
      },
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
        },
      },
    },
  }
end

local function configure()
  local telescope = require("telescope")
  telescope.setup(make_opts())
  telescope.load_extension("fzf")
  set_keymaps()
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = configure
}
