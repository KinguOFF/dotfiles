-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "\\cc", "[s1z=", { noremap = true, silent = true })

-- vim.keymap.set("n", "\\n", "<Plug>(neorg.pivot.list.toggle)", { desc = "neorg list toogle" })
-- vim.keymap.set("n", "\\nn", "<cmd>Neorg toc<CR>", { desc = "neorg table of cont" })

-- TODO remap the bindings instead

vim.keymap.set("v", "\\<", "<Plug>(neorg.promo.demote.range)", { desc = "(neorg) Demote" })
vim.keymap.set("n", "\\lI", "<Plug>(neorg.pivot.list.invert)", { desc = "(neorg) Invert List" })
vim.keymap.set("v", "\\>", "<Plug>(neorg.promo.promote.range)", { desc = "(neorg) Promote" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- vim.keymap.set("n", "<LocalLeader>lI", "<Plug>(neorg.promo.demote.range)", { desc = "(neorg) Demote" })
