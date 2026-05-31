local actions = require("config.actions")

return {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
        auto_restore = false,
        auto_save = false,
        pre_save_cmds = { actions.close_extra_buffers },
    },
}
