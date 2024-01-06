require("no-neck-pain").setup({
	width = 108,
	autocmds = {
		enableOnVimEnter = true,
	}
})

vim.keymap.set("n", "<leader>nn", ":NoNeckPain<cr>", {
  silent = true,
  desc = "[N]o [N]eck pain",
})
