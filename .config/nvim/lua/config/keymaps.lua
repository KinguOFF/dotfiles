-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<C-k>", "[s1z=", { noremap = true, silent = true })

-- vim.keymap.set("n", "\\nn", "<cmd>Neorg toc<CR>", { desc = "neorg table of cont" })

vim.keymap.set("v", "<localleader>dr", "<Plug>(neorg.promo.demote.range)", { desc = "(neorg) Demote range" })
vim.keymap.set("n", "<localleader>lI", "<Plug>(neorg.pivot.list.invert)", { desc = "(neorg) Invert List" })
vim.keymap.set("v", "<localleader>pr", "<Plug>(neorg.promo.promote.range)", { desc = "(neorg) Promote range" })
vim.keymap.set("n", "<localleader>de", "<Plug>(neorg.promo.demote)", { desc = "(neorg) Promote" })
vim.keymap.set("n", "<localleader>dn", "<Plug>(neorg.promo.demote.nested)", { desc = "(neorg) Demote Nested" })
vim.keymap.set("n", "<localleader>lm", "<Plug>(neorg.looking-glass.magnify)", { desc = "(neorg) Looking" })
vim.keymap.set("n", "<localleader>id", "<Plug>(neorg.tempus.insert-date)", { desc = "(neorg) insert-date" })
vim.keymap.set("n", "<localleader>pl", "<Plug>(neorg.pivot.list.toggle)", { desc = "(neorg) list toggle" })
vim.keymap.set("n", "<localleader>pe", "<Plug>(neorg.promo.promote)", { desc = "(neorg) Promote" })
vim.keymap.set("n", "<localleader>pn", "<Plug>(neorg.promo.promote.nested)", { desc = "(neorg) Promote Nested" })

-- vim.keymap.set("v", "\\tT", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", { desc = "(neorg) Promote" })
-- vim.keymap.set("v", "\\tC", "<Plug>(neorg.qol.todo-items.todo.taks-cancelled)", { desc = "(neorg) Promote" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
