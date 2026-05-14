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

return M
