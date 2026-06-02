local menu = require("config.menu")
local util = require("config.util")

local M = {}

function M.quit()
    vim.cmd("confirm qa")
end

function M.close_buffer()
    vim.cmd("bd")
end

function M.help()
    Snacks.picker.help()
end

function M.pickers()
    Snacks.picker()
end

function M.explorer()
    local pickers = Snacks.picker.get({source = "explorer"})
    if #pickers == 0 then
        Snacks.explorer.reveal()
    else
        pickers[1].input.win:focus()
    end
end

function M.files()
    Snacks.picker.files()
end

function M.recent()
    Snacks.picker.recent()
end

function M.buffers()
    Snacks.picker.buffers()
end

function M.symbols()
    Snacks.picker.lsp_symbols()
end

function M.diagnostics()
    Snacks.picker.diagnostics_buffer()
end

function M.notifications()
    Snacks.picker.notifications()
end

function M.quickfix()
    Snacks.picker.qflist()
end

function M.git()
    Snacks.lazygit()
end

function M.git_file_history()
    Snacks.lazygit.log_file()
end

function M.search()
    local term = util.grab_selected_text()
    if term ~= "" then
        vim.cmd("silent! /\\V" .. term:gsub([[\]], [[\\]]):gsub([[/]], [[\/]]))
    else
        vim.fn.feedkeys("\27/")
    end
end

function M.search_working_directory()
    Snacks.picker.grep({ search = util.grab_selected_text(), regex = false })
end

function M.search_git()
    Snacks.picker.git_grep({ search = util.grab_selected_text(), regex = false })
end

function M.format()
    if vim.o.filetype == "markdown" then
        vim.cmd("TableTidyAll")
    else
        vim.lsp.buf.format()
    end
end

function M.quickfix_prev()
    vim.cmd("silent! cp")
end

function M.quickfix_next()
    vim.cmd("silent! cn")
end

function M.rename()
    vim.lsp.buf.rename()
end

function M.references()
    Snacks.picker.lsp_references()
end

function M.definitions()
    Snacks.picker.lsp_definitions()
end

function M.code_action()
    vim.lsp.buf.code_action()
end

function M.lsp_complete()
    vim.lsp.completion.get()
end

function M.tab_complete()
    if vim.snippet.active({ direction = 1}) then
        vim.snippet.jump(1)
    elseif vim.fn.pumvisible() ~= 0 then
        vim.fn.feedkeys("\25")
    else
        vim.fn.feedkeys("\t", "n")
    end
end

function M.restore_session()
    vim.cmd("AutoSession restore")
end

function M.switch_session()
    vim.cmd("AutoSession search")
end

function M.save_session()
    vim.cmd("AutoSession save")
end

function M.save_session_and_quit()
    vim.cmd("AutoSession save")
    vim.cmd("confirm qa")
end

function M.toggle_wrap()
    vim.cmd("set wrap!")
end

function M.toggle_non_printables()
    vim.cmd("set list!")
end

function M.clear_highlight()
    vim.cmd("noh")
end

function M.undo_history()
    Snacks.picker.undo()
end

function M.dap_new()
    vim.cmd("DapNew")
end

function M.dap_terminate()
    vim.cmd("DapTerminate")
    require("dapui").close()
end

function M.dap_step_over()
    vim.cmd("DapStepOver")
end

function M.dap_step_into()
    vim.cmd("DapStepInto")
end

function M.dap_step_out()
    vim.cmd("DapStepOut")
end

function M.dap_log()
    vim.cmd("DapShowLog")
end

function M.dap_continue()
    vim.cmd("DapContinue")
end

function M.dap_toggle_breakpoint()
    vim.cmd("DapToggleBreakpoint")
end

function M.toggle_dap_ui()
    require("dapui").toggle()
end

function M.close_extra_buffers()
    local function is_extra(id)
        -- Unlisted buffers are extra
        if not vim.api.nvim_buf_get_option(id, "buflisted") then return true end

        -- Empty buffers with no filetype are extra
        if vim.api.nvim_buf_get_option(id, "filetype") == "" then
            local lines = vim.api.nvim_buf_get_lines(id, 0, -1, false)
            if #lines == 1 and #lines[1] == 0 then
                return true
            end
        end

        return false
    end

    for _, id in pairs(vim.api.nvim_list_bufs()) do
        if is_extra(id) then
            vim.cmd("silent! bd " .. tostring(id))
        end
    end

    vim.cmd("silent! cclose")
end

function M.save()
    vim.cmd("wa")
end

function M.quick_menu()
    menu.show("Quick menu", {
        { title = "Session...", action = M.session_menu },
        { title = "Editor...", action = M.editor_menu },
        { title = "Debug...", action = M.debug_menu },
        { title = "Quit", action = M.quit },
    })
end

function M.startup_menu()
    menu.show("Startup menu", {
        { title = "Restore session (" .. vim.fn.getcwd() .. ")", action = M.restore_session },
        { title = "Switch session...", action = M.switch_session },
        { title = "Recent...", action = M.recent },
        { title = "Quit", action = M.quit },
    })
end

function M.session_menu()
    local buffers_count = util.pluralize_noun(util.listed_buffers_count(), "buffer", "s")
    menu.show("Session menu (" .. vim.fn.getcwd() .. ")", {
        { title = "Save session and quit (" .. buffers_count .. ")", action = M.save_session_and_quit },
        { title = "Save session", action = M.save_session },
        { title = "Switch session...", action = M.switch_session },
        { title = "Recent...", action = M.recent },
    })
end

function M.editor_menu()
    menu.show("Editor menu", {
        { title = "Toggle wrap", action = M.toggle_wrap },
        { title = "Toggle non-printables", action = M.toggle_non_printables },
        { title = "Undo history...", action = M.undo_history },
    })
end

function M.debug_menu()
    menu.show("Debug menu", {
        { title = " New DAP session...", action = M.dap_new },
        { title = " Terminate", action = M.dap_terminate },
        { title = " Continue", action = M.dap_continue },
        { title = " Step over", action = M.dap_step_over },
        { title = " Step into", action = M.dap_step_into },
        { title = " Step out", action = M.dap_step_out },
        { title = "Show DAP log", action = M.dap_log },
        { title = "Toggle DAP UI", action = M.toggle_dap_ui },
    })
end

return M
