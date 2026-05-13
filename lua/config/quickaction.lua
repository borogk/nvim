local startup_items = {
    "restore_session",
    "switch_session",
    "recent",
    "quit",
}

local main_items = {
    "session_menu",
    "editor_menu",
    "dap_menu",
    "explorer_panel",
    "quit",
}

local session_items = {
    "save_session_and_quit",
    "save_session",
    "switch_session",
    "recent",
}

local editor_items = {
    "clear_highlight",
    "toggle_wrap",
    "toggle_non_printables",
    "undo_history",
}

local dap_items = {
    "dap_new",
    "dap_terminate",
    "dap_continue",
    "dap_step_over",
    "dap_step_into",
    "dap_step_out",
    "dap_ui",
}

local menu

local function pluralize_noun(count, noun, ending)
    if count == 1 then
        return tostring(count) .. " " .. noun
    else
        return tostring(count) .. " " .. noun .. ending
    end
end

local definitions = {
    restore_session = {
        title = function()
            return "Restore session (" .. vim.fn.getcwd() .. ")"
        end,
        action = function()
            vim.cmd("AutoSession restore")
        end,
    },
    switch_session = {
        title = function()
            return "Switch session..."
        end,
        action = function()
            vim.cmd("AutoSession search")
        end,
    },
    save_session = {
        title = function()
            return "Save session"
        end,
        action = function()
            vim.cmd("AutoSession save")
        end,
    },
    save_session_and_quit = {
        title = function()
            local num_buffers = 0
            for _, id in pairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(id, "buflisted") then
                    num_buffers = num_buffers + 1
                end
            end
            return "Save session and quit (" .. pluralize_noun(num_buffers, "buffer", "s") .. ")"
        end,
        action = function()
            vim.cmd("AutoSession save")
            vim.cmd("confirm qa")
        end,
    },
    recent = {
        title = function()
            return "Recent files..."
        end,
        action = function()
            Snacks.picker.recent()
        end,
    },
    clear_highlight = {
        title = function()
            return "Clear highlight"
        end,
        action = function()
            vim.cmd("noh")
        end,
    },
    undo_history = {
        title = function()
            return "Undo history..."
        end,
        action = function()
            Snacks.picker.undo()
        end,
    },
    explorer_panel = {
        title = function()
            return "Explorer panel"
        end,
        action = function()
            Snacks.explorer({
                auto_close = false,
                layout = {
                    preset = "left",
                    preview = false,
                },
            })
        end,
    },
    toggle_wrap = {
        title = function()
            return "Toggle wrap"
        end,
        action = function()
            vim.cmd("set wrap!")
        end,
    },
    toggle_non_printables = {
        title = function()
            return "Toggle non-printable characters"
        end,
        action = function()
            vim.cmd("set list!")
        end,
    },
    dap_ui = {
        title = function()
            return "Toggle debug UI"
        end,
        action = function()
            require("dapui").toggle()
        end,
    },
    dap_new = {
        title = function()
            return " Start debugging..."
        end,
        action = function()
            vim.cmd("DapNew")
        end,
    },
    dap_terminate = {
        title = function()
            return " Terminate"
        end,
        action = function()
            vim.cmd("DapTerminate")
        end,
    },
    dap_continue = {
        title = function()
            return " Continue"
        end,
        action = function()
            vim.cmd("DapContinue")
        end,
    },
    dap_step_over = {
        title = function()
            return " Step over"
        end,
        action = function()
            vim.cmd("DapStepOver")
        end,
    },
    dap_step_into = {
        title = function()
            return " Step into"
        end,
        action = function()
            vim.cmd("DapStepInto")
        end,
    },
    dap_step_out = {
        title = function()
            return " Step out"
        end,
        action = function()
            vim.cmd("DapStepOut")
        end,
    },
    quit = {
        title = function()
            return "Quit"
        end,
        action = function()
            vim.cmd("confirm qa")
        end,
    },
    session_menu = {
        title = function()
            return "Session     >"
        end,
        action = function()
            menu("Session actions (" .. vim.fn.getcwd() .. ")", session_items)
        end,
    },
    editor_menu = {
        title = function()
            return "Editor      >"
        end,
        action = function()
            menu("Editor actions", editor_items)
        end,
    },
    dap_menu = {
        title = function()
            return "Debug       >"
        end,
        action = function()
            menu("Debug actions", dap_items)
        end,
    },
}

function menu(title, items)
    Snacks.picker.select(
        items,
        {
            prompt = title,
            format_item = function(item)
                local def = definitions[item]
                if def ~= nil then
                    return def.title(vim.o)
                else
                    return item
                end
            end
        },
        function(item)
            local def = definitions[item]
            if def ~= nil then
                def.action(vim.o)
            end
        end
    )
end

function QuickAction(startup)
    if startup == true then
        menu("Startup quick action", startup_items)
    else
        menu("Quick action", main_items)
    end
end

function DebugAction()
    menu("Debug actions", dap_items)
end

