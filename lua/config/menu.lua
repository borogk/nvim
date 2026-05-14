local M = {}

function M.show(title, items)
    Snacks.picker.select(
        items,
        {
            prompt = title,
            format_item = function(item)
                if item ~= nil then
                    return item.title
                else
                    return ""
                end
            end
        },
        function(item)
            if item ~= nil then
                item.action()
            end
        end
    )
end

return M
