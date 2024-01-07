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
  opts = make_opts()
}
