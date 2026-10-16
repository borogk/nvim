local actions = require("config.actions")

vim.keymap.set({ "n" }, "<Esc>", actions.clear)
vim.keymap.set({ "n" }, "<C-Esc>", actions.close_extra_buffers)
vim.keymap.set({ "n" }, "<S-Esc>", actions.close_extra_buffers)
vim.keymap.set({ "n", "i", "v" }, "<C-\\>", actions.pickers)
vim.keymap.set({ "n", "i", "v" }, "<C-/>", actions.cycle_explorers)
vim.keymap.set({ "n", "i", "v" }, "<C-.>", actions.files)
vim.keymap.set({ "n", "i", "v" }, "<C-,>", actions.recent_files)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", actions.save)
vim.keymap.set({ "n", "i", "v" }, "<C-d>", actions.diagnostics)
vim.keymap.set({ "n", "i", "v" }, "<C-g>", actions.git)
vim.keymap.set({ "n", "i", "v" }, "<C-h>", actions.git_file_history)
vim.keymap.set({ "n", "i", "v" }, "<C-j>", actions.git_hunks)
vim.keymap.set({ "n", "i", "v" }, "<C-b>", actions.git_blame)
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
vim.keymap.set({ "n", "i", "v" }, "<C-e><C-e>", actions.bufferline_select)
vim.keymap.set({ "n", "i", "v" }, "<C-e>q", actions.bufferline_close)
vim.keymap.set({ "n", "i", "v" }, "<F1>", actions.bufferline_select)
vim.keymap.set({ "n", "i", "v" }, "<F13>", actions.help)
vim.keymap.set({ "n", "i", "v" }, "<F2>", actions.explorer)
vim.keymap.set({ "n", "i", "v" }, "<F3>", actions.search_working_directory)
vim.keymap.set({ "n", "i", "v" }, "<F15>", actions.search_git)
vim.keymap.set({ "n", "i", "v" }, "<F4>", actions.editor_menu)
vim.keymap.set({ "n", "i", "v" }, "<F5>", actions.git_menu)
vim.keymap.set({ "n", "i", "v" }, "<F6>", actions.code_action)
vim.keymap.set({ "n", "i", "v" }, "<F18>", actions.rename)
vim.keymap.set({ "n", "i", "v" }, "<F7>", actions.definitions)
vim.keymap.set({ "n", "i", "v" }, "<F19>", actions.references)
vim.keymap.set({ "n", "i", "v" }, "<F8>", actions.dap_step_over)
vim.keymap.set({ "n", "i", "v" }, "<F9>", actions.dap_continue)
vim.keymap.set({ "n", "i", "v" }, "<F11>", actions.close_extra_buffers)
vim.keymap.set({ "n", "i", "v" }, "<F23>", actions.close_extra_buffers)
vim.keymap.set({ "n", "i", "v" }, "<F12>", actions.quick_menu)
vim.keymap.set({ "n", "i", "v" }, "<F24>", actions.symbols)
vim.keymap.set({ "n", "i", "v" }, "<C-CR>", actions.definitions)
vim.keymap.set({ "n", "i", "v" }, "<S-CR>", actions.references)
vim.keymap.set({ "i" }, "<C-m>", actions.lsp_complete)
vim.keymap.set({ "i" }, "<Tab>", actions.tab_complete)
vim.keymap.set({ "n" }, "{", actions.quickfix_prev)
vim.keymap.set({ "n" }, "}", actions.quickfix_next)
vim.keymap.set({ "n" }, "x", "\"_x")
vim.keymap.set({ "n", "v" }, "d", "\"_d")

-- Text shifting magic
vim.keymap.set({ "n" }, "<C-Up>", ":m -2<CR>==")
vim.keymap.set({ "n" }, "<C-Down>", ":m +1<CR>==")
vim.keymap.set({ "i" }, "<C-Up>", "<ESC>:m -2<CR>==gi")
vim.keymap.set({ "i" }, "<C-Down>", "<ESC>:m +1<CR>==gi")
vim.keymap.set({ "v" }, "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set({ "v" }, "<C-Down>", ":m '>+1<CR>gv=gv")

-- Set up SHIFT-Arrow selection
-- Horizontal movement turns on regular visual mode
-- Vertical movement turns on line visual mode
-- If already in visual mode - repeats arrow key behaviour as if SHIFT wasn't pressed
local function setup_shift_selection(dir)
    local shortcut = "<S-" .. dir .. ">"
    local direction_key = "<" .. dir .. ">"
    local enter_visual = "v"
    if dir == "Up" or dir == "Down" then
        enter_visual = "<S-v>"
    end

    vim.keymap.set({ "n" }, shortcut, enter_visual .. direction_key)
    vim.keymap.set({ "v" }, shortcut, direction_key)
    vim.keymap.set({ "i" }, shortcut, function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local col = cursor[2]

        local command = ""
        if dir == "Left" or dir == "Home" then
            if col > 0 then
                command = "<Left><C-o>" .. enter_visual .. direction_key
            end
        else
            command = "<C-o>" .. enter_visual .. direction_key
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
