vim.keymap.set("n", "<leader>dv", function()
    local current = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current })
    print("Virtual lines diagnostics: " .. (not current and "enabled" or "disabled"))
end, { desc = "Toggle virtual lines diagnostics" })

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = false })
    vim.cmd("write")
end, { desc = "Format buffer with LSP" })

vim.keymap.set("n", "<C-k>", "[s1z=", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>ht", "<CMD>set showtabline=0<CR>", { desc = "Hide Tablines" })

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd("Undotree")
end, { desc = "Toggle undotree" })
