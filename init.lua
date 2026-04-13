require("config.lazy")

vim.o.termguicolors = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.cmd.colorscheme("tokyonight-night")

vim.keymap.set({ "n", "i", "v" }, "<C-c>", "<cmd>q<cr>")
vim.keymap.set({ "n", "i", "v" }, "<C-/>", function() Snacks.explorer.reveal() end)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", function() Snacks.picker() end)
vim.keymap.set({ "n", "i", "v" }, "<C-n>", function() Snacks.picker.files() end)
vim.keymap.set({ "n", "i", "v" }, "<C-f>", function() Snacks.picker.grep_buffers() end)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", vim.lsp.buf.format)
vim.keymap.set({ "n", "i", "v" }, "<F18>", vim.lsp.buf.rename)
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

-- Fix lualine appearance for special type of buffers
require("lualine").setup({
	extensions = { "quickfix" }
})
