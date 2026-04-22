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

-- Treesitter fix for Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function() vim.treesitter.start() end,
})
