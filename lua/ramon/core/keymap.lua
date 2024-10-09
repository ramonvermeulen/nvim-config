vim.g.mapleader = " "

local keymap = vim.keymap

-- renaming
keymap.set("n", "<leader>r", function()
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
