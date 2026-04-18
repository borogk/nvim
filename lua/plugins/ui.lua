local enabled = {
	enabled = true,
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
			lazygit = enabled,
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
				},
			},
		},
	},
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "folke/noice.nvim", opts = {} },
}
