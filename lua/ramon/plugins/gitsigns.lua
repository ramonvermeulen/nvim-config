return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()
			vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, {})
			vim.keymap.set("n", "<leader>tfb", ":<C-U>Gitsigns blame<CR>", {})
		end,
	},
}
