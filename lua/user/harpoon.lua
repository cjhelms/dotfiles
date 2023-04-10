vim.keymap.set(
	"n",
	"<leader>hm",
	":lua require('harpoon.mark').add_file()<cr>",
	{ noremap = true, desc = "[H]arpoon [M]ark" }
)

vim.keymap.set(
	"n",
	"<leader>hq",
	":lua require('harpoon.ui').toggle_quick_menu()<cr>",
	{ noremap = true, desc = "[H]arpoon [Q]uick menu" }
)

vim.keymap.set(
	"n",
	"<leader>j",
	function() return ":lua require('harpoon.ui').nav_file(" .. vim.v.count .. ")<cr>" end,
	{ expr = true, noremap = true, desc = "[J]ump to harpooned file" }
)

vim.keymap.set(
	"n",
	"<leader>hn",
	":lua require('harpoon.ui').nav_next()<cr>",
	{ noremap = true, desc = "[H]arpoon [N]ext" }
)

vim.keymap.set(
	"n",
	"<leader>hp",
	":lua require('harpoon.ui').nav_prev()<cr>",
	{ noremap = true, desc = "[H]arpoon [P]revious" }
)
