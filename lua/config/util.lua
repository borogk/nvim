local M = {}

function M.pluralize_noun(count, noun, ending)
    if count == 1 then
        return tostring(count) .. " " .. noun
    else
        return tostring(count) .. " " .. noun .. ending
    end
end

function M.listed_buffers_count()
    local result = 0
    for _, id in pairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_option(id, "buflisted") then
            result = result + 1
        end
    end
    return result
end

function M.grab_selected_text()
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" then
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg("v")
        vim.fn.setreg("v", {})

        local newline = text:find("\n", 1, true)
        if newline ~= nil then
            text = text:sub(1, newline - 1)
        end

        return text
    else
        return ""
    end
end

return M
