return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      icons_enabled = false,
      theme = "gruvbox",
      component_separators = "|",
      section_separators = "",
    })
  end,
}
