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

