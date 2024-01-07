local function configure()
  require("ibl").setup({ indent = { char = "┊" } })
end

return {
  "lukas-reineke/indent-blankline.nvim",
  config = configure
}
