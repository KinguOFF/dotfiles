return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",

        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },
            snippets = {
                -- either preset:
                preset = "luasnip", -- simplest
                -- or explicit:
                expand = function(snip) require("luasnip").lsp_expand(snip) end,
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = true } },

            sources = {
                default = { "lazydev", 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })
            require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/lua/snippets/" } })
        end,
        version = "v2.*",
        build = "make install_jsregexp"
    }
}
