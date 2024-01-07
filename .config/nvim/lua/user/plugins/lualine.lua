local function make_opts()
  return {
    icons_enabled = false,
    theme = "gruvbox",
    component_separators = "|",
    section_separators = "",
  }
end

return {
  "nvim-lualine/lualine.nvim",
  config = function() require("lualine").setup(make_opts()) end
}
