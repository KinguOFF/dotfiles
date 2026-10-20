local roam_dir = "~/projects/roam"

return {
    {
        "nvim-orgmode/orgmode",
        version = "0.7.*", -- org-roam 0.2 needs orgmode >= 0.7.0
        lazy = true, -- loaded by org-roam.nvim
        config = function()
            require("orgmode").setup({
                org_agenda_files = roam_dir .. "/**/*",
                org_default_notes_file = roam_dir .. "/inbox.org",
            })
        end,
    },
    {
        "chipsenkbeil/org-roam.nvim",
        version = "0.2.*",
        -- VeryLazy for the global <leader>n maps; ft so `nvim note.org` gets
        -- the org-buffer maps too (org-roam adds them on FileType)
        event = "VeryLazy",
        ft = "org",
        dependencies = { "nvim-orgmode/orgmode" },
        opts = {
            directory = roam_dir,
        },
    },
}
