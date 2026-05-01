local startup_items = {
    "restore_session",
    "switch_session",
    "recent",
}

local all_items = {
    "restore_session",
    "switch_session",
    "recent",
    "clear_highlight",
    "toggle_explorer",
    "toggle_wrap",
    "toggle_non_printables",
}

function QuickAction(startup)
    local items = all_items
    if startup == true then
        items = startup_items
    end

    Snacks.picker.select(items, {
        prompt = "Quick action:",
        format_item = function(item)
            if item == "restore_session" then
                return "Restore session (" .. vim.fn.getcwd() .. ")"
            elseif item == "switch_session" then
                return "Switch session..."
            elseif item == "recent" then
                return "Recent..."
            elseif item == "clear_highlight" then
                return "Clear highlight"
            elseif item == "toggle_explorer" then
                return "Toggle explorer panel"
            elseif item == "toggle_wrap" then
                return "Toggle wrap"
            elseif item == "toggle_non_printables" then
                return "Toggle non-printable characters"
            end
        end
    }, function(item)
        if item == "restore_session" then
            vim.cmd("AutoSession restore")
        elseif item == "switch_session" then
            vim.cmd("AutoSession search")
        elseif item == "recent" then
            Snacks.picker.recent()
        elseif item == "clear_highlight" then
            vim.cmd("noh")
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
        end
    end)
end
