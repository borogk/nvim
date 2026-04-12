require("config.lazy")

vim.o.termguicolors = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.cmd.colorscheme("tokyonight-night")

vim.keymap.set("n", "|", "<cmd>Neotree<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<C-n>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<C-g>", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<C-l>", vim.lsp.buf.format)
vim.keymap.set("n", "<F12>", "<cmd>Telescope lsp_document_symbols<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
			})
		end
	end,
})

require("neo-tree").setup({
	source_selector = {
		statusline = true,
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
})
