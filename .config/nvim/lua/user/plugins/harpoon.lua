return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local map = function(keybind, action, description)
      vim.keymap.set("n", keybind, action, { silent = true, desc = description })
    end

    map("<leader>hm", ":lua require('harpoon'):list():add()<cr>", "[H]arpoon [M]ark")
    map(
      "<leader>hq",
      ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) <cr>",
      "[H]arpoon [Q]uick menu"
    )
    map("<leader>1", ":lua require('harpoon'):list():select(1)<cr>", "Harpoon mark 1")
    map("<leader>2", ":lua require('harpoon'):list():select(2)<cr>", "Harpoon mark 2")
    map("<leader>3", ":lua require('harpoon'):list():select(3)<cr>", "Harpoon mark 3")
    map("<leader>4", ":lua require('harpoon'):list():select(4)<cr>", "Harpoon mark 4")
    map("<leader>5", ":lua require('harpoon'):list():select(5)<cr>", "Harpoon mark 5")
    map("<leader>6", ":lua require('harpoon'):list():select(6)<cr>", "Harpoon mark 6")
    map("<leader>7", ":lua require('harpoon'):list():select(7)<cr>", "Harpoon mark 7")
    map("<leader>8", ":lua require('harpoon'):list():select(8)<cr>", "Harpoon mark 8")
    map("<leader>9", ":lua require('harpoon'):list():select(9)<cr>", "Harpoon mark 9")
  end,
}
