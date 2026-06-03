local actions = require("config.actions")

return {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        auto_restore = false,
        auto_save = false,
        pre_save_cmds = { actions.close_extra_buffers },
        save_extra_data = function()
            local groups = require("bufferline.groups")
            local pinned_bufs_data = {}
            groups.action("pinned", function(buf) table.insert(pinned_bufs_data, buf.id) end)

            local breakpoints = require("dap.breakpoints").get()
            local breakpoints_data = {}
            for _, points in pairs(breakpoints) do
                for _, point in ipairs(points) do
                    table.insert(breakpoints_data, { buf = point.buf, line = point.line })
                end
            end

            return vim.fn.json_encode({
                pinned_bufs = pinned_bufs_data,
                breakpoints = breakpoints_data,
            })
        end,
        restore_extra_data = function(_, data)
            data = vim.fn.json_decode(data)

            local bufs = {}
            for _, id in ipairs(vim.api.nvim_list_bufs()) do
                bufs[id] = true
            end

            if data.pinned_bufs then
                local groups = require("bufferline.groups")
                for _, id in ipairs(data.pinned_bufs) do
                    if bufs[id] then
                        groups.add_element("pinned", { id = id })
                    end
                end
            end

            if data.breakpoints then
                local breakpoints = require("dap.breakpoints")
                for _, point in ipairs(data.breakpoints) do
                    if bufs[point.buf] then
                        breakpoints.set({}, point.buf, point.line)
                    end
                end
            end
        end,
    },
}
