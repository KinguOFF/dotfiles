-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

-- Mason
require("mason").setup()

-- Color Previewer
require("colorizer").setup()

require("oil").setup()
