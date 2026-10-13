-- Snippets for the research notes (macros from research/preamble.sty).
local function today()
    return os.date("%Y-%m-%d")
end

return {
    s( -- Verification-log row: Step or claim & How checked & Status & Date \\
        { trig = "vrow", desc = "Verification-log row" },
        fmta([[<> & <> & <> & <> \\]],
            { i(1, "claim"), i(2, "hand"), i(3, "unsure"), f(today) }
        )
    ),

    s( -- Open question in a paper note
        { trig = "oq", desc = "Open question" },
        fmta([[\item \openq{<>}]],
            { i(1) }
        )
    ),

    s( -- Toolbox entry
        { trig = "tool", desc = "Toolbox entry" },
        fmta(
            [[
\subsection{<>}\label{tool:<>}

\paragraph{Statement.}
<>

\paragraph{Intuition.}
<>

\paragraph{Where seen or used.}
<>
]],
            { i(1, "Name"), i(2, "label"), i(3), i(4), i(5) }
        )
    ),

    s( -- Research-log entry, dated today
        { trig = "logentry", desc = "Research-log entry" },
        fmta(
            [[
\entry{<>}
\worked{<>}
\tried{<>}
\failed{<>}
\nextstep{<>}
]],
            { f(today), i(1), i(2), i(3), i(4) }
        )
    ),
}
