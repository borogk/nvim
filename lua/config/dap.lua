local dap = require("dap")
local dapui = require("dapui")

-- Debug icons

vim.cmd("hi DapBreakpointColor guifg=#ff0000")
vim.cmd("hi DapBreakpointRejectedColor guifg=#aa0000")
vim.cmd("hi DapStoppedColor guifg=#ffff00")
vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DapBreakpointRejectedColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = ">", texthl = "DapStoppedColor", linehl = "debugPC", numhl = "" })

-- DAP UI setup

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes",  size = 0.5 },
                { id = "watches", size = 0.5 },
            },
            position = "bottom",
            size = 10
        },
        {
            elements = {
                { id = "repl",    size = 0.5 },
                { id = "stacks",  size = 0.5 },
            },
            position = "right",
            size = 40
        },
    },
})

-- Automatically activate DAP UI on debug session start/terminate

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Log level
dap.set_log_level("TRACE")

-- Go

dap.adapters.delve = function(callback)
    vim.ui.input({ prompt = "Host: ", default = "127.0.0.1" }, function(host)
        vim.ui.input({ prompt = "Port: ", default = "2345" }, function(port)
            callback({
                type = "server",
                host = host,
                port = port,
            })
        end)
    end)
end

dap.configurations.go = {
    {
        type = "delve",
        name = "Attach",
        request = "attach",
        mode = "remote",
    },
}

-- Erlang

dap.adapters.edb = {
    type = "executable",
    command = "edb",
    args = { "dap" },
}

