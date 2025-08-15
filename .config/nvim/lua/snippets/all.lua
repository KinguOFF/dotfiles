local function char_count_same(c1, c2)
    local line = vim.api.nvim_get_current_line()
    -- '%'-escape chars to force explicit match (gsub accepts patterns).
    -- second return value is number of substitutions.
    local _, ct1 = string.gsub(line, '%' .. c1, '')
    local _, ct2 = string.gsub(line, '%' .. c2, '')
    return ct1 == ct2
end

local function even_count(c)
    local line = vim.api.nvim_get_current_line()
    local _, ct = string.gsub(line, c, '')
    return ct % 2 == 0
end

local function neg(fn, ...)
    return not fn(...)
end

local function part(fn, ...)
    local args = { ... }
    return function() return fn(unpack(args)) end
end

-- This makes creation of pair-type snippets easier.
local function pair(pair_begin, pair_end, expand_func, ...)
    -- triggerd by opening part of pair, wordTrig=false to trigger anywhere.
    -- ... is used to pass any args following the expand_func to it.
    return s({ trig = pair_begin, wordTrig = false }, {
        t({ pair_begin }), i(1), t({ pair_end })
    }, {
        condition = part(expand_func, part(..., pair_begin, pair_end))
    })
end

return {
    s( -- This snippets creates the sympy block ;)
        { trig = "sym", desc = "Creates a sympy block" },
        fmt("sympy {} sympy{}",
            { i(1), i(0) }
        )
    ),

    s( -- This one evaluates anything inside the simpy block
        { trig = "sympy.*sympy", regTrig = true, desc = "Sympy block evaluator" },
        d(1, function(_, parent)
            -- Gets the part of the block we actually want, and replaces spaces
            -- at the beginning and at the end
            local to_eval = string.gsub(parent.trigger, "^sympy(.*)sympy", "%1")
            to_eval = string.gsub(to_eval, "^%s+(.*)%s+$", "%1")

            local Job = require("plenary.job")

            local sympy_script = string.format(
                [[
from sympy import *
from sympy.parsing.sympy_parser import parse_expr
from sympy.printing.latex import print_latex
parsed = parse_expr('%s')
print_latex(parsed)
            ]],
                to_eval
            )

            sympy_script = string.gsub(sympy_script, "^[\t%s]+", "")
            local result = ""

            Job:new({
                command = "python",
                args = {
                    "-c",
                    sympy_script,
                },
                on_exit = function(j)
                    result = j:result()
                end,
            }):sync()

            return sn(nil, t(result))
        end)
    ),
    pair("(", ")", neg, char_count_same),
    pair("{", "}", neg, char_count_same),
    pair("[", "]", neg, char_count_same),
    pair("<", ">", neg, char_count_same),
    pair("'", "'", neg, even_count),
    pair('"', '"', neg, even_count),
    pair("`", "`", neg, even_count),
}
