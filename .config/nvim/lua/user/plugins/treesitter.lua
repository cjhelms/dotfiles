local function configure()
  local function make_ensure_installed_table()
    return {
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "typescript",
      "gdscript",
    }
  end

  local function make_highlight_table()
    return { enable = true }
  end

  local function make_indent_table()
    return { enable = true, disable = { "python" } }
  end

  local function make_incremental_selection_table()
    return {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    }
  end

  local function make_textobjects_table()
    local function make_select_table()
      return {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      }
    end

    local function make_move_table()
      return {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      }
    end

    local function make_swap_table()
      return {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      }
    end

    return {
      select = make_select_table(),
      move = make_move_table(),
      swap = make_swap_table(),
    }
  end

  require("nvim-treesitter.configs").setup({
    ensure_installed = make_ensure_installed_table(),
    highlight = make_highlight_table(),
    indent = make_indent_table(),
    incremental_selection = make_incremental_selection_table(),
    textobjects = make_textobjects_table(),
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = configure
}
