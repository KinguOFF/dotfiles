vim.opt.number = true
vim.opt.relativenumber = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.virtualedit = "block"

vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 999

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.diagnostic.config({
    virtual_lines = true,
    signs = true,      -- show signs in the gutter
    underline = true,  -- underline the text with issues
    update_in_insert = false,
})

vim.opt.conceallevel = 2
vim.opt.textwidth = 80
