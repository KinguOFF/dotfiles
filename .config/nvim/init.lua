require("config.options")
require("config.lazy")
require("config.keymaps")

-- vim.pack.add { "https://github.com/Julian/lean.nvim" }
-- vim.g.lean_config = { mappings = true }

vim.keymap.set({ "i", "s" }, "<Tab>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then ls.expand_or_jump()
  else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
  end
end, { silent = true })

vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable("texlab")
vim.lsp.enable('hyprls')
vim.lsp.enable('hls')
vim.lsp.config["tinymist"] = {

    cmd = { "tinymist" },

    filetypes = { "typst" },

    settings = {

        -- ...

    }

}
vim.lsp.enable("tinymist")

