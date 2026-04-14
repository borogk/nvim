local enabled = {
	enabled = true,
}

local sidebar = {
	layout = {
		preset = "sidebar",
	},
}

return {
	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			explorer = enabled,
			notifier = enabled,
			words = enabled,
			gitbrowse = enabled,
			quickfile = enabled,
			bigfile = enabled,
			picker = {
				sources = {
					explorer = {
						hidden = true,
						auto_close = true,
						layout = {
							preset = "default",
							preview = true,
						},
					},
					git_diff = sidebar,
					git_status = sidebar,
					git_files = sidebar,
				},
			},
		},
	},
	{ "folke/tokyonight.nvim", lazy = false },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "folke/noice.nvim", opts = {} },
}
