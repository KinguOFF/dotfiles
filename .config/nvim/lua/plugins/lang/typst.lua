return {
    "kaarmu/typst.vim",
    ft = "typst",
    init = function()
        vim.g.typst_conceal = 1
        vim.g.typst_conceal_math = 1
        vim.g.typst_conceal_emoji = 1
    end,
}
