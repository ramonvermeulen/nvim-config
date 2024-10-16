return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			source_selector = {
				winbar = false,
				statusline = false,
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Neotree toggle key" })
	end,
}
