return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_syntax_custom_envs = {
                {
                    name = "tikzcd",
                    math = 1,
                },
                {
                    name = "asy",
                    region = "texCodeZone",
                    nested = "asy",
                },
                {
                    name = "asydef",
                    region = "texCodeZone",
                    nested = "asy",
                },
                {
                    name = "lstlisting",
                    region = "texCodeZone",
                    nested = {
                        bash = "language=[Bb]ash",
                        c = "language=C",
                        git = "language=git",
                        make = "language=[Mm]ake",
                        python = "language=[Pp]ython",
                        rust = "language=[Rr]ust",
                        sql = "language=SQL",
                    },
                },
            }
        end,
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "./.latexmk/aux",
                out_dir = "./.latexmk/out",
            }
        end,
    },
    {
        "kaarmu/typst.vim",
        init = function()
            vim.g.typst_conceal = 1
            vim.g.typst_conceal_math = 1
            vim.g.typst_conceal_emoji = 1
        end,
    },
}
