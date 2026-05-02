require("config.quickaction")

local function close_buffer()
    vim.cmd("bd")
end

local function help()
    Snacks.picker.help()
end

local function explorer_panel()
    Snacks.explorer({
        auto_close = false,
        layout = {
            preset = "left",
            preview = false,
        },
    })
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

local function dap_new()
    vim.cmd("DapNew")
end

local function dap_terminate()
    vim.cmd("DapTerminate")
end

local function dap_continue()
    vim.cmd("DapContinue")
end

local function dap_step_over()
    vim.cmd("DapStepOver")
end

local function dap_step_into()
    vim.cmd("DapStepInto")
end

local function dap_step_out()
    vim.cmd("DapStepOut")
end

local function dap_toggle_breakpoint()
    vim.cmd("DapToggleBreakpoint")
end

vim.keymap.set({ "n", "i", "v" }, "<C-c>", close_buffer)
vim.keymap.set({ "n", "i", "v" }, "<F1>", help)
vim.keymap.set({ "n", "i", "v" }, "<F2>", explorer_panel)
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
vim.keymap.set({ "n", "i", "v" }, "<F12>", QuickAction)
vim.keymap.set({ "n", "i", "v" }, "<F24>", code_action)
vim.keymap.set({ "i" }, "<C-CR>", auto_complete)
vim.keymap.set({ "n", "i", "v" }, "<F5>", dap_new)
vim.keymap.set({ "n", "i", "v" }, "<F17>", dap_terminate)
vim.keymap.set({ "n", "i", "v" }, "<F9>", dap_continue)
vim.keymap.set({ "n", "i", "v" }, "<F8>", dap_step_over)
vim.keymap.set({ "n", "i", "v" }, "<F7>", dap_step_into)
vim.keymap.set({ "n", "i", "v" }, "<F20>", dap_step_out)
vim.keymap.set({ "n", "i", "v" }, "<F32>", dap_toggle_breakpoint)
