return {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = { config = { icon_preset = "diamond" } },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
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
