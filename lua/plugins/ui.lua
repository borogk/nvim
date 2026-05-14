local enabled = {
    enabled = true,
}

return {
    {
        "folke/snacks.nvim",
        lazy = false,
        opts = {
            explorer = enabled,
            notifier = enabled,
            words = enabled,
            gitbrowse = enabled,
            quickfile = enabled,
            bigfile = enabled,
            lazygit = enabled,
            picker = {
                sources = {
                    explorer = {
                        hidden = true,
                        ignored = true,
                        auto_close = true,
                        layout = {
                            preset = "default",
                            preview = true,
                        },
                    },
                    buffers = {
                        sort_lastused = false,
                    },
                    lsp_references = {
                        auto_confirm = true,
                        include_current = true,
                    },
                    lsp_definitions = {
                        include_current = true,
                    },
                },
            },
        },
    },
    { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
    { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
    { "nvim-tree/nvim-web-devicons" },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            extensions = {
                "quickfix",
                {
                    filetypes = {
                        "snacks_terminal",
                        "dapui_stacks",
                        "dapui_scopes",
                        "dapui_watches",
                        "dap-repl",
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_c = { "filename" },
                    },
                },
            },
            options = {
                section_separators = "",
                component_separators = "",
            },
        }
    },
    { "MunifTanjim/nui.nvim" },
    {
        "akinsho/bufferline.nvim",
        opts = {
            options = {
                themable = false,
                separator_style = "slant",
            },
        },
    },
}
