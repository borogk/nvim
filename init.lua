require("config.lazy")

vim.o.termguicolors = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.cmd.colorscheme("tokyonight-night")

vim.keymap.set({ "n", "i", "v" }, "<C-t>", "<cmd>Telescope<cr>")
vim.keymap.set({ "n", "i", "v" }, "<C-n>", "<cmd>Telescope find_files<cr>")
vim.keymap.set({ "n", "i", "v" }, "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set({ "n", "i", "v" }, "<C-l>", vim.lsp.buf.format)
vim.keymap.set({ "n", "i", "v" }, "<F18>", vim.lsp.buf.rename)
vim.keymap.set({ "n", "i", "v" }, "<F19>", "<cmd>Telescope lsp_references<cr>")

-- Open neotree, select current file if it exists, otherwise select working directory
vim.keymap.set("n", "<C-/>", function()
	local reveal_file = vim.fn.expand("%:p")
	if reveal_file == "" then
		reveal_file = vim.fn.getcwd()
	else
		local f = io.open(reveal_file, "r")
		if f then
			f.close(f)
		else
			reveal_file = vim.fn.getcwd()
		end
	end
	require("neo-tree.command").execute({
		reveal_file = reveal_file,
		reveal_force_cwd = true,
	})
end)

-- Setup autocompletion
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

require('telescope').setup({
  defaults = require('telescope.themes').get_ivy(),
})

