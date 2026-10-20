return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false, -- colorscheme, loads before everything else
        priority = 1000,
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
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
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = {},
        dependencies = { "echasnovski/mini.icons" },
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
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
        "3rd/image.nvim",
        enabled = false,
        build = false,     -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        config = function()
            require("image").setup({
                backend = "kitty",
                processor = "magick_cli", -- or "magick_rock"
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        only_render_image_at_cursor_mode = "popup",
                        floating_windows = true,       -- if true, images will be rendered in floating markdown windows
                        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        filetypes = { "norg" },
                    },
                    typst = {
                        enabled = true,
                        filetypes = { "typst" },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false,                                       -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
                editor_only_render_when_focused = false,                                    -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false,                                    -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
            })
        end
    },
}
