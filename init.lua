require("config.lazy")

vim.o.termguicolors = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.cmd.colorscheme("tokyonight-night")

vim.keymap.set({ "n", "i", "v" }, "<C-c>", "<cmd>q<cr>")
vim.keymap.set({ "n", "i", "v" }, "<F1>", function() Snacks.picker.help() end)
vim.keymap.set({ "n", "i", "v" }, "<C-/>", function() Snacks.explorer.open() end)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", function() Snacks.picker() end)
vim.keymap.set({ "n", "i", "v" }, "<C-r>", function() Snacks.picker.recent() end)
vim.keymap.set({ "n", "i", "v" }, "<C-g>d", function() Snacks.picker.git_diff() end)
vim.keymap.set({ "n", "i", "v" }, "<C-g>s", function() Snacks.picker.git_status() end)
vim.keymap.set({ "n", "i", "v" }, "<C-g>l", function() Snacks.picker.git_log() end)
vim.keymap.set({ "n", "i", "v" }, "<C-g>b", function() Snacks.picker.git_branches() end)
vim.keymap.set({ "n", "i", "v" }, "<C-g>f", function() Snacks.picker.git_log_file() end)
vim.keymap.set({ "n", "i", "v" }, "<C-n>", function() Snacks.picker.files() end)
vim.keymap.set({ "n", "i", "v" }, "<C-f>", function() Snacks.picker.grep_buffers() end)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", function() vim.lsp.buf.format() end)
vim.keymap.set({ "n", "i", "v" }, "<F18>", function() vim.lsp.buf.rename() end)
vim.keymap.set({ "n", "i", "v" }, "<F19>", function() Snacks.picker.lsp_references() end)

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

-- Always open help on the left
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	command = "wincmd L",
})

-- Fix lualine appearance for special type of buffers
require("lualine").setup({
	extensions = {
		"quickfix",
		{
			sections = { lualine_a = { "mode" } },
			filetypes = { "snacks_terminal" },
		},
	},
})
