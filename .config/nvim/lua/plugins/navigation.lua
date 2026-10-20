return {
    {
        "stevearc/oil.nvim",
        opts = {
            skip_confirm_for_simple_edits = true,
        },
        dependencies = { "echasnovski/mini.icons" },
        lazy = false, -- must be loaded to take over `nvim <dir>`
        keys = {
            { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "echasnovski/mini.icons" },
        cmd = "FzfLua",
        opts = {},
        keys = {
            { "<Leader>lf", "<CMD>FzfLua files<CR>",                desc = "Find files" },
            { "<Leader>lg", "<CMD>FzfLua live_grep<CR>",            desc = "Live grep" },
            { "<Leader>lr", "<CMD>FzfLua lsp_references<CR>",       desc = "LSP references" },
            { "<Leader>ld", "<CMD>FzfLua diagnostics_document<CR>", desc = "Document diagnostics" },
            { "<Leader>lt", "<CMD>FzfLua tabs<CR>",                 desc = "Navigate tabs" },
            { "<Leader>lb", "<CMD>FzfLua buffers<CR>",              desc = "Navigate buffers" },
            { "<Leader>lc", "<CMD>FzfLua command_history<CR>",      desc = "Navigate command history" },
            { "<Leader>lo", "<CMD>FzfLua oldfiles<CR>",             desc = "Navigate recent files" },
        },
    },
}
