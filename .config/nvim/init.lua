require("config.options")
require("config.lazy")
require("config.keymaps")

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then ls.expand_or_jump()
  else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
  end
end, { silent = true })
