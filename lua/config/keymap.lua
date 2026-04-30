local function close_buffer()
	vim.cmd("bd")
end

local function help()
	Snacks.picker.help()
end

local function pickers()
	Snacks.picker()
end

local function explorer()
	Snacks.explorer.open()
end

local function files()
	Snacks.picker.files()
end

local function recent()
	Snacks.picker.recent()
end

local function buffers()
	Snacks.picker.buffers()
end

local function git()
	Snacks.lazygit()
end

local function git_file_history()
	Snacks.lazygit.log_file()
end

local function search_current_file()
    local current_file = vim.fn.expand("%")
    if current_file ~= "" then
    	Snacks.picker.grep({ glob = current_file })
    end
end

local function search_working_directory()
   	Snacks.picker.grep()
end

local function format()
	if vim.o.filetype == "markdown" then
		vim.cmd("TableTidyAll")
	else
		vim.lsp.buf.format()
	end
end

local function rename()
	vim.lsp.buf.rename()
end

local function references()
	Snacks.picker.lsp_references()
end

local function definitions()
	Snacks.picker.lsp_definitions()
end

local function code_action()
	vim.lsp.buf.code_action()
end

local function auto_complete()
	vim.lsp.completion.get()
end

vim.keymap.set({ "n", "i", "v" }, "<C-c>", close_buffer)
vim.keymap.set({ "n", "i", "v" }, "<F1>", help)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", pickers)
vim.keymap.set({ "n", "i", "v" }, "<C-/>", explorer)
vim.keymap.set({ "n", "i", "v" }, "<C-.>", files)
vim.keymap.set({ "n", "i", "v" }, "<C-,>", recent)
vim.keymap.set({ "n", "i", "v" }, "<C-b>", buffers)
vim.keymap.set({ "n", "i", "v" }, "<C-g>", git)
vim.keymap.set({ "n", "i", "v" }, "<C-h>", git_file_history)
vim.keymap.set({ "n", "i", "v" }, "<C-f>", search_current_file)
vim.keymap.set({ "n", "i", "v" }, "<F3>", search_working_directory)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", format)
vim.keymap.set({ "n", "i", "v" }, "<F18>", rename)
vim.keymap.set({ "n", "i", "v" }, "<F19>", references)
vim.keymap.set({ "n", "i", "v" }, "<F20>", definitions)
vim.keymap.set({ "n", "i", "v" }, "<F24>", code_action)
vim.keymap.set({ "i" }, "<C-CR>", auto_complete)
