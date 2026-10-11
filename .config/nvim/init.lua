require("config.options")
require("config.lazy")
require("config.keymaps")

-- vim.pack.add { "https://github.com/Julian/lean.nvim" }
-- vim.g.lean_config = { mappings = true }

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
