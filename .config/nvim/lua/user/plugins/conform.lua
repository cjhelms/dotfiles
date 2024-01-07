local function make_opts()
  return {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
    },
  }
end

local function configure()
  local function make_format_action()
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

  vim.api.nvim_create_user_command("Format", make_format_action(), { range = true })
  vim.keymap.set("n", "<leader>f", ":Format<cr>", { silent = true, desc = "[F]ormat" })
end

return {
  "stevearc/conform.nvim",
  opts = make_opts(),
  config = configure,
}
