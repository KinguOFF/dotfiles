vim.keymap.set("n", "<leader>dv", function()
    local current = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not current })
    print("Virtual text diagnostics: " .. (not current and "enabled" or "disabled"))
end, { desc = "Toggle virtual text diagnostics" })

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
    vim.cmd("write")
end, { desc = "Format buffer with LSP" })

vim.keymap.set("n", "<C-k>", "[s1z=", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>gO", "<cmd>Neorg toc<CR>")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<Leader>t", "<CMD>FzfLua tabs<CR>", { desc = "Navigate tabs with Lua" })
vim.keymap.set("n", "<Leader>b", "<CMD>FzfLua buffers<CR>", { desc = "Navigate buffers with Lua" })
vim.keymap.set("n", "<Leader>c", "<CMD>FzfLua command_history<CR>", { desc = "Navigate commands with Lua" })

vim.keymap.set("n", "<Leader>ht", "<CMD>set showtabline=0<CR>", { desc = "Hide Tablines" })
