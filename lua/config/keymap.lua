-- telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })

-- neotree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})

-- lsp
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- venv selector
vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", {})
vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", {})

-- gitsigns
local gitsigns = require("gitsigns")
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, {})
vim.keymap.set("n", "<leader>tfb", ":<C-U>Gitsigns blame<CR>", {})

-- lazygit
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", {})

-- renaming
vim.keymap.set("n", "<leader>r", function()
	local cmdId
	cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {

		callback = function()
			local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
			vim.api.nvim_feedkeys(key, "c", false)
			vim.api.nvim_feedkeys("0", "n", false)
			cmdId = nil
			return true
		end,
	})
	vim.lsp.buf.rename()
	vim.defer_fn(function()
		if cmdId then
			vim.api.nvim_del_autocmd(cmdId)
		end
	end, 500)
end, {})
