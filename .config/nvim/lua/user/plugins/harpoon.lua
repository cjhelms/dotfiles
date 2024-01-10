local function configure()
  local function map(keybind, action, description)
    if description then
      vim.keymap.set("n", keybind, action, { silent = true, desc = description })
    else
      vim.keymap.set("n", keybind, action, { silent = true })
    end
  end

  local harpoon = require("harpoon")
  harpoon:setup()
  map("<leader>a", function() harpoon:list():append() end, "Harpoon [A]dd")
  map("<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "[H]arpoon")
  map("<leader>1", function() harpoon:list():select(1) end)
  map("<leader>2", function() harpoon:list():select(2) end)
  map("<leader>3", function() harpoon:list():select(3) end)
  map("<leader>4", function() harpoon:list():select(4) end)
  map("<leader>5", function() harpoon:list():select(5) end)
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = configure,
}
