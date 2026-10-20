vim.diagnostic.config({
    virtual_lines = true,
    signs = true,      -- show signs in the gutter
    underline = true,  -- underline the text with issues
    update_in_insert = false,
})

vim.keymap.set("n", "<leader>dv", function()
    local current = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current })
    print("Virtual lines diagnostics: " .. (not current and "enabled" or "disabled"))
end, { desc = "Toggle virtual lines diagnostics" })

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("write")
end, { desc = "Format buffer with LSP" })

vim.lsp.enable({
    "pyright",
    "clangd",
    "texlab",
    "hyprls",
    "hls",
    "tinymist",
    "lua_ls",
    "bashls",
    "jsonls",
})
