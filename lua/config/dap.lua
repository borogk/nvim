local dap = require("dap")
local dapui = require("dapui")

-- DAP UI setup

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "repl",    size = 0.25 },
                { id = "stacks",  size = 0.25 },
                { id = "scopes",  size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            position = "bottom",
            size = 10
        }
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

-- Go

dap.adapters.delve = function(callback, config)
    if config.mode == "remote" and config.request == "attach" then
        callback({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or "38697"
        })
    else
        callback({
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
                detached = vim.fn.has("win32") == 0,
            }
        })
    end
end

dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}
