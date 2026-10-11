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

vim.keymap.set("n", "<Leader>gO", "<cmd>Neorg toc<CR>")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("n", "<Leader>lf", "<CMD>FzfLua files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<Leader>lg", "<CMD>FzfLua live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<Leader>lr", "<CMD>FzfLua lsp_references<CR>", { desc = "LSP references" })
vim.keymap.set("n", "<Leader>ld", "<CMD>FzfLua diagnostics_document<CR>", { desc = "Document diagnostics" })
vim.keymap.set("n", "<Leader>lt", "<CMD>FzfLua tabs<CR>", { desc = "Navigate tabs" })
vim.keymap.set("n", "<Leader>lb", "<CMD>FzfLua buffers<CR>", { desc = "Navigate buffers" })
vim.keymap.set("n", "<Leader>lc", "<CMD>FzfLua command_history<CR>", { desc = "Navigate command history" })
vim.keymap.set("n", "<Leader>lo", "<CMD>FzfLua oldfiles<CR>", { desc = "Navigate recent files" })

vim.keymap.set("n", "<Leader>ht", "<CMD>set showtabline=0<CR>", { desc = "Hide Tablines" })

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd("Undotree")
end, { desc = "Toggle undotree" })
