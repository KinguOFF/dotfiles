local ensure_installed = { "cpp", "python", "latex", "lua", "vim", "c", "vimdoc", "query", "markdown", "markdown_inline" }
-- filetypes whose treesitter highlighting stays off (vimtex handles latex)
local highlight_disable = { latex = true }
-- filetypes that keep their own indentexpr (orgmode indents org itself)
local indent_disable = { org = true }

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the main branch doesn't support lazy-loading
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install(ensure_installed)

            local function start(buf, lang)
                if highlight_disable[lang] or not vim.api.nvim_buf_is_valid(buf) then
                    return
                end
                if pcall(vim.treesitter.start, buf, lang) and not indent_disable[lang] then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang then
                        return
                    end
                    if vim.treesitter.language.add(lang) then
                        start(args.buf, lang)
                    elseif vim.list_contains(ts.get_available(), lang) then
                        -- auto_install replacement
                        ts.install(lang):await(function()
                            vim.schedule(function() start(args.buf, lang) end)
                        end)
                    end
                end,
            })

            -- incremental selection, built into Neovim 0.12 (v_an / v_in)
            vim.keymap.set("n", "<Leader>is", "van", { remap = true, desc = "Start node selection" })
            vim.keymap.set("x", "<Leader>si", "an", { remap = true, desc = "Expand to parent node" })
            vim.keymap.set("x", "<Leader>sd", "in", { remap = true, desc = "Shrink to child node" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'v',
                        ['@class.outer'] = '<c-v>',
                    },
                    include_surrounding_whitespace = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local maps = {
                af = { "@function.outer", "textobjects" },
                ["if"] = { "@function.inner", "textobjects" },
                ac = { "@class.outer", "textobjects" },
                ic = { "@class.inner", "textobjects", "Select inner part of a class region" },
                as = { "@local.scope", "locals", "Select language scope" },
            }
            for lhs, m in pairs(maps) do
                vim.keymap.set({ "x", "o" }, lhs, function()
                    select.select_textobject(m[1], m[2])
                end, { desc = m[3] or m[1] })
            end
        end,
    },
}
