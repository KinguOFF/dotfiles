return {

    "nvim-neorg/neorg",
    lazy = false, -- upstream advises against lazy-loading
    version = "*", -- Pin Neorg to the latest stable release
    -- Load after nvim-treesitter so the norg parsers are on the runtimepath
    -- when neorg checks for them
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
        { "<Leader>gO", "<cmd>Neorg toc<CR>", desc = "Neorg table of contents" },
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.journal"] = {
                    config = {
                        workspace = "notes"
                    },
                },
                ["core.summary"] = {},
                ["core.esupports.metagen"] = {
                },
                ["core.autocommands"] = {},
                ["core.highlights"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.defaults"] = {
                    config = {},
                },
                ["core.concealer"] = { config = { icon_preset = "diamond" } },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/projects/notes/",
                        },
                        index = "index.norg",
                        default_workspace = "notes"
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                    },
                },
            },

        })
    end
}
