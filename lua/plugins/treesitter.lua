return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			autoinstall = true,
			highlight = { enabled = true },
			indent = { enabled = true },
		})
	end,
}
