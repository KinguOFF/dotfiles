require("config.options")
require("config.lazy")
require("config.keymaps")

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
