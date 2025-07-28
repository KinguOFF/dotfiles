return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "cpp", "python", "latex", "lua", "vim", "c", "vimdoc", "query" },
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { "latex" },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>is",
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v',
                            ['@function.outer'] = 'v',
                            ['@class.outer'] = '<c-v>',
                        },
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.hyprls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.pyright.setup({}) -- Python
            lspconfig.bashls.setup({}) -- Shell (bash/sh)
            lspconfig.fish_lsp.setup({}) -- Fish shell
            -- lspconfig.texlab.setup({  })                         -- LaTeX
            lspconfig.taplo.setup({}) -- TOML
            lspconfig.yamlls.setup({}) -- YAML
        end,
    }
}
