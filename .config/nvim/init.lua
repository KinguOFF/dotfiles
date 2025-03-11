-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

-- Mason
require("mason").setup()

-- Color Previewer
require("colorizer").setup()

-- Hyprland LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
