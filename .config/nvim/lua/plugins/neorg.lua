return {

    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {
                ["core.journal"] = {
                    workspace = "notes"
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
