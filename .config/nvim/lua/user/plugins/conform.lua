return {
  "stevearc/conform.nvim",
  event = "BufEnter",
  config = function()
    require("conform").setup({
      formatters = {
        clang_format = {
          command = "/grmn/prj/fit/monaco/tools/clang-tools/clang-format",
          args = { "-assume-filename", vim.api.nvim_buf_get_name(0) },
          root_patterns = { ".git", ".clang-format" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        css = { "prettier" },
      },
    })

    local function format_action()
      return function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end
    end

    vim.api.nvim_create_user_command("Format", format_action(), { range = true })
    vim.keymap.set("n", "<leader>f", ":Format<cr>", { silent = true, desc = "[F]ormat" })
  end,
}
