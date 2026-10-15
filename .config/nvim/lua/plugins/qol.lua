return {
    {
        "stevearc/oil.nvim",
        opts = {
            skip_confirm_for_simple_edits = true,
        },
        dependencies = { "echasnovski/mini.icons" },
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
        dependencies = { "echasnovski/mini.icons" },
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        opts = {},
        init = function()
            -- Serve mini.icons to plugins that require nvim-web-devicons
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
    },
    {
        "github/copilot.vim",
        enabled = false,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "szymonwilczek/vim-be-better",
    }
}
