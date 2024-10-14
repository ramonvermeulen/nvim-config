return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		-- autocomplete on ":" command
		"gelguy/wilder.nvim",
		build = ":UpdateRemotePlugins",
		config = function()
			local wilder = require("wilder")
			wilder.setup({ modes = { ":", "/", "?" } })
			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.python_file_finder_pipeline({
						file_command = function(_, arg)
							if string.find(arg, ".") ~= nil then
								return { "fd", "-tf", "-H" }
							else
								return { "fd", "-tf" }
							end
						end,
						dir_command = { "fd", "-td" },
						filters = { "fuzzy_filter", "difflib_sorter" },
					}),
					wilder.cmdline_pipeline(),
					wilder.python_search_pipeline()
				),
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer({
					highlighter = wilder.basic_highlighter(),
					left = { " " },
					right = { " ", wilder.popupmenu_scrollbar({ thumb_char = " " }) },
					highlights = { default = "WilderMenu", accent = "WilderAccent" },
				})
			)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = entry.source.name
						return vim_item
						-- code
					end,
				},
			})
		end,
	},
}
