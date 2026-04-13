return {
	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			explorer = { enabled = true },
			notifier = { enabled = true },
			picker = {
				sources = {
					explorer = { hidden = true },
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
