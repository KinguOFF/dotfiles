return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
        },
        lazy = false,
    },
    {
        "akinsho/bufferline.nvim",
        opts = {
            highlights = {
                buffer_selected = {
                    fg = {
                        attribute = "fg",
                        highlight = "CursorLineNr",
                    },
                },
                buffer_visible = {
                    fg = {
                        attribute = "fg",
                        highlight = "LineNr",
                    },
                },
            },
            options = {
                always_show_bufferline = false,
                indicator = { style = "underline" },
                show_buffer_close_icons = false,
                show_close_icon = false,
                modified_icon = "[+]",
                numbers = "buffer_id",
                tab_size = 12,
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
    },
    {
        "jiaoshijie/undotree",
        lazy = true,
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    }
}
