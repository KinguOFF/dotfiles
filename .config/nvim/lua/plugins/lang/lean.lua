return {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    init = function()
        vim.g.lean_config = { mappings = true }
    end,
}
