return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		opts = function()
			local logo = [[
   _______________                                                                         |*\_/*|________   
  |  ___________  |     .-.                                                      .-.      ||_/-\_|______  |  
  | |           | |    .****.                                                  .****.     | |           | |  
  | |   0   0   | |    .*****███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗*****.     | |   0   0   | |  
  | |     -     | |     .****████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║****.      | |     -     | |  
  | |   \___/   | |      .***██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║***.       | |   \___/   | |  
  | |___     ___| |       .**██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║**.        | |___________| |  
  |_____|\_/|_____|        .*██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║*.         |_______________|  
     _|__|/ \|_|_............╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝.............._|________|_    
    / ********** \                                                                          / ********** \   
   / ************ \                                                                        / ************ \  
   ----------------                                                                        ----------------  
           ]]

			logo = string.rep("\n", 2) .. logo

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                        {
                            action = [[lua require("lazyvim.util").telescope.config_files()()]],
                            desc = " Config",
                            icon = " ",
                            key = "c"
                        },
                        -- todo(ramon) take a look at persistence for session state
                        -- { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                        { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
                        { action = "Mason", desc = " Mason", icon = " ", key = "m" },
                        { action = "LazyGit", desc = " LazyGit", icon = "🗲 ", key = "." },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			return opts
		end,
	},
}
