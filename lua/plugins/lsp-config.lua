local lsp_servers = { "lua_ls", "pyright", "terraformls" }
local formatters = { "stylua" }
local linters = { "tflint" }

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			-- responsible for lsps installation
			require("mason-lspconfig").setup({
				ensure_installed = lsp_servers,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			-- responsible for linters and formatters installation
			local combined = vim.deepcopy(formatters)
			vim.list_extend(combined, linters)

			require("mason-null-ls").setup({
				ensure_installed = combined,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, server in ipairs(lsp_servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local sources = {}

			for _, formatter in ipairs(formatters) do
				if null_ls.builtins.formatting[formatter] then
					table.insert(sources, null_ls.builtins.formatting[formatter])
				end
			end

			for _, linter in ipairs(linters) do
				if null_ls.builtins.diagnostics[linter] then
					table.insert(sources, null_ls.builtins.diagnostics[linter])
				end
			end

			null_ls.setup({
				sources = sources,
			})

			-- formatting on save - from wiki
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			require("null-ls").setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.formatting_sync()
							end,
						})
					end
				end,
			})
		end,
	},
}
