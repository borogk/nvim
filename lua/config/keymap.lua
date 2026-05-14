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

local function symbols()
    Snacks.picker.lsp_symbols()
end

local function diagnostics()
    Snacks.picker.diagnostics_buffer()
end

local function notifications()
    Snacks.picker.notifications()
end

local function quickfix()
    Snacks.picker.qflist()
end

local function git()
    Snacks.lazygit()
end

local function git_file_history()
    Snacks.lazygit.log_file()
end

local function search_working_directory()
    Snacks.picker.grep()
end

local function search_git()
    Snacks.picker.git_grep()
end

local function search_buffer()
    vim.ui.input({ prompt = "Search: " }, function(term)
        if term ~= "" and term ~= nil then
            vim.cmd("/" .. term)
        end
    end)
end

local function search_and_replace_buffer()
    vim.ui.input({ prompt = "Search: " }, function(term)
        if term ~= "" and term ~= nil then
            vim.ui.input({ prompt = "Replace: ", default = term }, function(replacement)
                if replacement ~= nil then
                    vim.cmd("%s/" .. term .. "/" .. replacement .. "/g")
                end
            end)
        end
    end)
end

local function format()
    if vim.o.filetype == "markdown" then
        vim.cmd("TableTidyAll")
    else
        vim.lsp.buf.format()
    end
end

local function quickfix_prev()
    vim.cmd("silent! cp")
end

local function quickfix_next()
    vim.cmd("silent! cn")
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

local function dap_step_over()
    vim.cmd("DapStepOver")
end

local function dap_continue()
    vim.cmd("DapContinue")
end

local function dap_toggle_breakpoint()
    vim.cmd("DapToggleBreakpoint")
end

vim.keymap.set({ "n", "i", "v" }, "<C-c>", close_buffer)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", pickers)
vim.keymap.set({ "n", "i", "v" }, "<C-/>", explorer)
vim.keymap.set({ "n", "i", "v" }, "<C-.>", files)
vim.keymap.set({ "n", "i", "v" }, "<C-,>", recent)
vim.keymap.set({ "n", "i", "v" }, "<C-b>", buffers)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", symbols)
vim.keymap.set({ "n", "i", "v" }, "<C-n>", notifications)
vim.keymap.set({ "n", "i", "v" }, "<C-d>", diagnostics)
vim.keymap.set({ "n", "i", "v" }, "<C-q>", quickfix)
vim.keymap.set({ "n", "i", "v" }, "<C-g>", git)
vim.keymap.set({ "n", "i", "v" }, "<C-h>", git_file_history)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", format)
vim.keymap.set({ "n", "i", "v" }, "<C-f>", search_buffer)
vim.keymap.set({ "n", "i", "v" }, "<C-r>", search_and_replace_buffer)
vim.keymap.set({ "n", "i", "v" }, "<F1>", help)
vim.keymap.set({ "n", "i", "v" }, "<F2>", explorer_panel)
vim.keymap.set({ "n", "i", "v" }, "<F3>", search_working_directory)
vim.keymap.set({ "n", "i", "v" }, "<F15>", search_git)
vim.keymap.set({ "n", "i", "v" }, "<F5>", DebugAction)
vim.keymap.set({ "n", "i", "v" }, "<F6>", code_action)
vim.keymap.set({ "n", "i", "v" }, "<F18>", rename)
vim.keymap.set({ "n", "i", "v" }, "<F7>", definitions)
vim.keymap.set({ "n", "i", "v" }, "<F19>", references)
vim.keymap.set({ "n", "i", "v" }, "<F8>", dap_step_over)
vim.keymap.set({ "n", "i", "v" }, "<F32>", dap_toggle_breakpoint)
vim.keymap.set({ "n", "i", "v" }, "<F9>", dap_continue)
vim.keymap.set({ "n", "i", "v" }, "<F12>", QuickAction)
vim.keymap.set({ "n" }, "<C-CR>", definitions)
vim.keymap.set({ "n" }, "<S-CR>", references)
vim.keymap.set({ "i" }, "<C-CR>", auto_complete)
vim.keymap.set({ "n" }, "{", quickfix_prev)
vim.keymap.set({ "n" }, "}", quickfix_next)
