local actions = require("config.actions")

vim.keymap.set({ "n" }, "<Esc>", actions.clear_highlight)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", actions.pickers)
vim.keymap.set({ "n", "i", "v" }, "<C-/>", actions.explorer)
vim.keymap.set({ "n", "i", "v" }, "<C-.>", actions.files)
vim.keymap.set({ "n", "i", "v" }, "<C-,>", actions.recent)
vim.keymap.set({ "n", "i", "v" }, "<C-b>", actions.dap_toggle_breakpoint)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", actions.save)
vim.keymap.set({ "n", "i", "v" }, "<C-d>", actions.diagnostics)
vim.keymap.set({ "n", "i", "v" }, "<C-g>", actions.git)
vim.keymap.set({ "n", "i", "v" }, "<C-h>", actions.git_file_history)
vim.keymap.set({ "n", "i", "v" }, "<C-l>", actions.format)
vim.keymap.set({ "n", "i", "v" }, "<C-f>", actions.search)
vim.keymap.set({ "n", "i", "v" }, "<C-e><Left>", actions.bufferline_prev)
vim.keymap.set({ "n", "i", "v" }, "<C-e><Right>", actions.bufferline_next)
vim.keymap.set({ "n", "i", "v" }, "<C-e><Up>", actions.bufferline_first)
vim.keymap.set({ "n", "i", "v" }, "<C-e><Down>", actions.bufferline_last)
vim.keymap.set({ "n", "i", "v" }, "<C-e>,", actions.bufferline_move_prev)
vim.keymap.set({ "n", "i", "v" }, "<C-e>.", actions.bufferline_move_next)
vim.keymap.set({ "n", "i", "v" }, "<C-e>p", actions.bufferline_pin)
vim.keymap.set({ "n", "i", "v" }, "<C-e>e", actions.bufferline_select)
vim.keymap.set({ "n", "i", "v" }, "<C-e>q", actions.bufferline_close)
vim.keymap.set({ "n", "i", "v" }, "<F1>", actions.help)
vim.keymap.set({ "n", "i", "v" }, "<F2>", actions.explorer)
vim.keymap.set({ "n", "i", "v" }, "<F3>", actions.search_working_directory)
vim.keymap.set({ "n", "i", "v" }, "<F15>", actions.search_git)
vim.keymap.set({ "n", "i", "v" }, "<F4>", actions.editor_menu)
vim.keymap.set({ "n", "i", "v" }, "<F5>", actions.debug_menu)
vim.keymap.set({ "n", "i", "v" }, "<F6>", actions.code_action)
vim.keymap.set({ "n", "i", "v" }, "<F18>", actions.rename)
vim.keymap.set({ "n", "i", "v" }, "<F7>", actions.definitions)
vim.keymap.set({ "n", "i", "v" }, "<F19>", actions.references)
vim.keymap.set({ "n", "i", "v" }, "<F8>", actions.dap_step_over)
vim.keymap.set({ "n", "i", "v" }, "<F9>", actions.dap_continue)
vim.keymap.set({ "n", "i", "v" }, "<F11>", actions.close_extra_buffers)
vim.keymap.set({ "n", "i", "v" }, "<F12>", actions.quick_menu)
vim.keymap.set({ "n", "i", "v" }, "<F24>", actions.symbols)
vim.keymap.set({ "n", "i", "v" }, "<C-CR>", actions.definitions)
vim.keymap.set({ "n", "i", "v" }, "<S-CR>", actions.references)
vim.keymap.set({ "i" }, "<C-m>", actions.lsp_complete)
vim.keymap.set({ "i" }, "<Tab>", actions.tab_complete)
vim.keymap.set({ "n" }, "{", actions.quickfix_prev)
vim.keymap.set({ "n" }, "}", actions.quickfix_next)

local function setup_shift_selection(dir)
    local shortcut = "<S-" .. dir .. ">"
    local direction_key = "<" .. dir .. ">"
    vim.keymap.set({ "n" }, shortcut, "v" .. direction_key)
    vim.keymap.set({ "v" }, shortcut, direction_key)
    vim.keymap.set({ "i" }, shortcut, function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line = cursor[1]
        local col = cursor[2]

        -- Below code tries to mimic "regular" text editor behaviour by excluding current character from selection
        -- when moving left or up, which is more intuitive with Insert mode cursor's shape.
        -- This only applies to the first directional press, then we enter Visual mode,
        -- where the cursor turns solid and stock nvim controls make more sense.

        local command = ""
        if dir == "Left" or dir == "Home" then
            if col > 0 then
                command = "<Left><C-o>v" .. direction_key
            end
        elseif dir == "Up" then
            if line == 1 then
                if col > 0 then
                    command = "<Left><C-o>v<Home>"
                end
            else
                if col > 0 then
                    command = "<Left><C-o>v<Home><Up>"
                else
                    command = "<Up><End><C-o>v<Home>"
                end
            end
        else
            command = "<C-o>v" .. direction_key
        end

        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(command, true, true, true))
    end)
end

setup_shift_selection("Up")
setup_shift_selection("Down")
setup_shift_selection("Left")
setup_shift_selection("Right")
setup_shift_selection("Home")
setup_shift_selection("End")
