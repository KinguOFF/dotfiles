vim.keymap.set("n", "<C-k>", "[s1z=", { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>ht", "<CMD>set showtabline=0<CR>", { desc = "Hide Tablines" })

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    vim.cmd("Undotree")
end, { desc = "Toggle undotree" })
