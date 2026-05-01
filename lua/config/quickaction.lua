local startup_items = {
    "restore_session",
    "switch_session",
    "recent",
    "quit",
}

local regular_items = {
    "save_session",
    "switch_session",
    "recent",
    "clear_highlight",
    "undo_history",
    "toggle_explorer",
    "toggle_wrap",
    "toggle_non_printables",
    "quit",
}

local function pluralize_noun(count, noun, ending)
    if count == 1 then
        return tostring(count) .. " " .. noun
    else
        return tostring(count) .. " " .. noun .. ending
    end
end

local function enabled_text(enabled)
    if enabled then
        return "ON"
    else
        return "off"
    end
end

function QuickAction(startup)
    local items = regular_items
    if startup == true then
        items = startup_items
    end

    local wrap_enabled = vim.o.wrap
    local non_printables_enabled = vim.o.list

    Snacks.picker.select(items, {
        prompt = "Quick action:",
        format_item = function(item)
            if item == "restore_session" then
                return "Restore session (" .. vim.fn.getcwd() .. ")"
            elseif item == "save_session" then
                local num_buffers = 0
                for _, id in pairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_get_option(id, "buflisted") then
                        num_buffers = num_buffers + 1
                    end
                end
                return "Save session (" .. vim.fn.getcwd() .. ", " .. pluralize_noun(num_buffers, "buffer", "s") .. ")"
            elseif item == "switch_session" then
                return "Switch session..."
            elseif item == "recent" then
                return "Recent files..."
            elseif item == "clear_highlight" then
                return "Clear highlight"
            elseif item == "undo_history" then
                return "Undo history..."
            elseif item == "toggle_explorer" then
                return "Toggle explorer panel"
            elseif item == "toggle_wrap" then
                return "Toggle wrap (currently " .. enabled_text(wrap_enabled) .. ")"
            elseif item == "toggle_non_printables" then
                return "Toggle non-printable characters (currently " .. enabled_text(non_printables_enabled) .. ")"
            elseif item == "quit" then
                return "Quit"
            else
                return item
            end
        end
    }, function(item)
        if item == "restore_session" then
            vim.cmd("AutoSession restore")
        elseif item == "save_session" then
            vim.cmd("AutoSession save")
        elseif item == "switch_session" then
            vim.cmd("AutoSession search")
        elseif item == "recent" then
            Snacks.picker.recent()
        elseif item == "clear_highlight" then
            vim.cmd("noh")
        elseif item == "undo_history" then
            Snacks.picker.undo()
        elseif item == "toggle_explorer" then
            Snacks.explorer({
                auto_close = false,
                layout = {
                    preset = "left",
                    preview = false,
                },
            })
        elseif item == "toggle_wrap" then
            vim.cmd("set wrap!")
        elseif item == "toggle_non_printables" then
            vim.cmd("set list!")
        elseif item == "quit" then
            vim.cmd("confirm qa")
        end
    end)
end
