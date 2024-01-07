local function configure()
  local function make_opts()
    return {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    }
  end

  require("toggleterm").setup(make_opts())
end

return {
  "akinsho/toggleterm.nvim",
  config = configure,
}
