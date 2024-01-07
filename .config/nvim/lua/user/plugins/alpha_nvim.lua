local function configure()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header.val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  }
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("<leader>sf", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("<leader>sp", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("<leader>?", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("<leader>sg", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return {
  "goolord/alpha-nvim",
  config = configure,
}

