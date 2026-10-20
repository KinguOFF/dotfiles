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
            snippets = { preset = "luasnip" },

            -- Show the documentation popup automatically
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
            local config_dir = vim.fn.stdpath("config")
            require("luasnip.loaders.from_vscode").lazy_load({ paths = config_dir .. "/snippets" })
            require("luasnip.loaders.from_lua").lazy_load({ paths = { config_dir .. "/lua/snippets/" } })

            vim.keymap.set({ "i", "s" }, "<Tab>", function()
                local ls = require("luasnip")
                if ls.expand_or_jumpable() then ls.expand_or_jump()
                else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
                end
            end, { silent = true })
        end,
        version = "v2.*",
        build = "make install_jsregexp"
    },
    {
        "github/copilot.vim",
        enabled = false,
    },
}
