-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "\\cc", "[s1z=", { noremap = true, silent = true })

-- vim.keymap.set("n", "\\n", "<Plug>(neorg.pivot.list.toggle)", { desc = "neorg list toogle" })
-- vim.keymap.set("n", "\\nn", "<cmd>Neorg toc<CR>", { desc = "neorg table of cont" })

-- TODO remap the bindings instead

vim.keymap.set("v", "\\dr", "<Plug>(neorg.promo.demote.range)", { desc = "(neorg) Demote range" })
vim.keymap.set("n", "\\lI", "<Plug>(neorg.pivot.list.invert)", { desc = "(neorg) Invert List" })
vim.keymap.set("v", "\\pr", "<Plug>(neorg.promo.promote.range)", { desc = "(neorg) Promote range" })
vim.keymap.set("n", "\\de", "<Plug>(neorg.promo.demote)", { desc = "(neorg) Promote" })
vim.keymap.set("n", "\\dn", "<Plug>(neorg.promo.demote.nested)", { desc = "(neorg) Demote Nested" })
vim.keymap.set("n", "\\lm", "<Plug>(neorg.looking-glass.magnify)", { desc = "(neorg) Looking" })
vim.keymap.set("n", "\\id", "<Plug>(neorg.tempus.insert-date)", { desc = "(neorg) insert-date" })
vim.keymap.set("n", "\\pl", "<Plug>(neorg.pivot.list.toggle)", { desc = "(neorg) list toggle" })
vim.keymap.set("n", "\\pe", "<Plug>(neorg.promo.promote)", { desc = "(neorg) Promote" })
vim.keymap.set("n", "\\pn", "<Plug>(neorg.promo.promote.nested)", { desc = "(neorg) Promote Nested" })

-- vim.keymap.set("v", "\\tT", "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)", { desc = "(neorg) Promote" })
-- vim.keymap.set("v", "\\tC", "<Plug>(neorg.qol.todo-items.todo.taks-cancelled)", { desc = "(neorg) Promote" })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
