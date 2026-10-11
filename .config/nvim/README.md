# Neovim config — plugin workflow notes

Personal notes on how this config is organised and how to add, update and
debug plugins. Neovim 0.12, plugin manager **lazy.nvim**.

`~/.config/nvim` is a symlink to `~/dotfiles/.config/nvim`, so every change
here is a change in the dotfiles repo.

## Layout

```
init.lua                 load order: options -> lazy -> keymaps, then vim.lsp.enable({...})
lazy-lock.json           exact plugin commits (commit this!)
lua/config/options.lua   vim.opt settings, leader keys, diagnostics
lua/config/lazy.lua      lazy.nvim bootstrap + `import = "plugins"`
lua/config/keymaps.lua   global keymaps (not tied to a plugin spec)
lua/plugins/*.lua        plugin specs, grouped by topic (every file is auto-imported)
lua/snippets/*.lua       LuaSnip Lua snippets (file name = filetype, all.lua = everywhere)
snippets/                VS Code-style JSON snippets + package.json
spell/                   custom spell words (`zg` adds to en.utf-8.add)
```

Leader is `<Space>`, local leader is `\`. Leaders are set in `options.lua`,
which runs **before** lazy, so plugin keymaps see the right leader.

## Plugin files

| File            | Plugins                                                             |
|-----------------|---------------------------------------------------------------------|
| `completion.lua`| blink.cmp, LuaSnip                                                  |
| `math.lua`      | vimtex, typst.vim, lean.nvim                                        |
| `neorg.lua`     | neorg                                                               |
| `qol.lua`       | oil, bufferline, lualine, mini.icons, kanagawa, flash, copilot (off)|
| `treesitter.lua`| nvim-treesitter, treesitter-textobjects, nvim-lspconfig             |
| `utils.lua`     | which-key, fzf-lua, lazydev, todo-comments, mini.pairs (off)        |
| `image.lua`     | image.nvim (off)                                                    |

## Adding a plugin

1. Pick the topic file in `lua/plugins/` (or create a new one — it is picked
   up automatically, it just has to `return` a spec or a list of specs).
2. Add a spec. **Each plugin gets its own `{ ... }` table** — if a file returns
   a list, every entry must be wrapped, otherwise lazy silently drops the
   options of the first one (this bit which-key once).
3. Restart Neovim (or `:Lazy install`), then commit the spec **and**
   `lazy-lock.json`.

Spec fields used in this config:

| Field            | Use it for                                                        |
|------------------|-------------------------------------------------------------------|
| `opts = {}`      | Plugin has `require("x").setup(opts)`; lazy calls it for you      |
| `config = fn`    | Custom setup code (runs after the plugin loads; overrides `opts`) |
| `init = fn`      | Runs at startup *before* loading — set `vim.g.*` options here     |
| `event` / `ft`   | Lazy-load on an event (`"InsertEnter"`, `"VeryLazy"`) or filetype |
| `keys = {...}`   | Define keymaps **and** lazy-load on first press                   |
| `dependencies`   | Load these first (also used to force load order)                  |
| `lazy = false`   | Load at startup (oil, vimtex)                                     |
| `priority=1000`  | Load before everything else (colorscheme)                         |
| `version`        | Pin to tags, e.g. `"1.*"` (blink), `"*"` (neorg)                  |
| `build`          | Post-install step, e.g. `make install_jsregexp` (LuaSnip)         |
| `enabled = false`| Keep a spec around but turn it off                                |

Gotchas:
- Plugins that only read `vim.g` variables (vimtex, typst.vim, **lean.nvim**)
  must be configured in `init`, not `opts` — `opts` makes lazy call
  `.setup()`, which errors if the plugin has none.
- Don't set both `opts` and `config` unless `config` uses the `opts`
  argument; otherwise `opts` is ignored.

## Keeping plugins up to date

| Command         | What it does                                                    |
|-----------------|-----------------------------------------------------------------|
| `:Lazy`         | Dashboard (`U` update, `S` sync, `X` clean, `L` log, `P` profile)|
| `:Lazy update`  | Pull new commits, rewrite `lazy-lock.json`                      |
| `:Lazy sync`    | install + clean + update in one go                              |
| `:Lazy restore` | Go back to the commits in `lazy-lock.json` (undo a bad update)  |
| `:Lazy clean`   | Delete plugins no longer in any spec                            |
| `:Lazy log`     | See what changed in recent updates                              |
| `:Lazy profile` | Startup time per plugin                                         |

The update checker runs in the background (`checker.enabled = true`,
`notify = false`) — it never pops up, open `:Lazy` to see pending updates.

Routine: `:Lazy update` → try things out → commit `lazy-lock.json`. If
something broke, `:Lazy restore` (or `git checkout lazy-lock.json` +
`:Lazy restore`).

After removing a spec, run `:Lazy clean` so the old clone and its lockfile
entry disappear.

## LSP

Neovim's native LSP (`vim.lsp.enable`), no mason. Three pieces:

1. **Server binary** — installed system-wide with pacman (or elan for Lean).
2. **Server config** — comes from nvim-lspconfig, which only ships data
   (`lsp/<name>.lua` files); it needs no `setup()` call.
3. **Enabling** — the list in `init.lua`:
   `pyright, clangd, texlab, hyprls, hls, tinymist, lua_ls, bashls, jsonls`.

Add a server: install the binary, check the name in
`:help lspconfig-all`, add it to the `vim.lsp.enable({...})` list.

Override a server's settings: create `lsp/<server-name>.lua` **at the root of
this config** (not under `lua/`) returning only the fields to change — Neovim
merges it on top of lspconfig's version. Files anywhere else are never loaded.

Lean is the exception: **lean.nvim** starts `leanls` itself — don't add it to
the enable list.

Not enabled: `fish_lsp` (binary not installed).

Debug: `:checkhealth vim.lsp` shows attached clients and errors.

Keymaps: Neovim 0.12 defaults (`K` hover, `grn` rename, `gra` code action,
`grr` references, `gri` implementation, `[d`/`]d` diagnostics) plus:

| Key          | Action                                                  |
|--------------|---------------------------------------------------------|
| `<leader>f`  | Format with LSP, then save                              |
| `<leader>dv` | Toggle diagnostic virtual lines                         |
| `<leader>lr` | References (fzf-lua)                                    |
| `<leader>ld` | Document diagnostics (fzf-lua)                          |

## Completion & snippets

**blink.cmp** (loads on `InsertEnter`), sources in priority order:
`lazydev` (Neovim Lua API, Lua files only) → `lsp` → `path` → `snippets` →
`buffer`. Default keymap preset: `<C-space>` open, `<C-y>` accept,
`<C-n>`/`<C-p>` move, `<C-e>` close.

**LuaSnip** is the snippet engine. `<Tab>` expands a snippet or jumps to the
next field (falls back to a normal Tab). Two snippet sources:

- **JSON** (`snippets/snippets/**/*.json`) — only files listed in
  `snippets/package.json` are loaded. Most files are a copy of
  friendly-snippets; the ones I edited are `latex/vscode-latex-snippets.json`
  and `norg.json`. To activate another file, add an entry to `package.json`:
  ```json
  { "language": ["go"], "path": "./snippets/go.json" }
  ```
- **Lua** (`lua/snippets/<filetype>.lua`) — `all.lua` has the sympy evaluator
  (`sym` → `sympy … sympy`, expanding the block runs it through Python sympy
  and inserts LaTeX) and the bracket-pair snippets.

## Per-topic workflows

### LaTeX — vimtex + texlab
- vimtex: compile `\ll`, view `\lv` (zathura), errors `\le`, clean `\lc`.
  Builds go into `.latexmk/aux` and `.latexmk/out`, with `-shell-escape`.
- Treesitter highlighting is disabled for LaTeX on purpose (vimtex does it).
- texlab provides LSP completion/diagnostics alongside vimtex.
- Extra environments (tikzcd, asy, lstlisting) are set in the vimtex `init`.

### Typst
typst.vim (conceal on) + tinymist LSP.

### Lean — lean.nvim
Loads on `*.lean`. Configured through `vim.g.lean_config = { mappings = true }`
in the spec's `init`. Infoview toggle: `<LocalLeader>i` (`\i`).

### Notes — Neorg
- Workspace `notes` = `~/projects/notes/` (index `index.norg`), journal in the
  same workspace. `<leader>gO` = table of contents.
- The norg parsers come as luarocks packages installed by lazy
  (`tree-sitter-norg`, `tree-sitter-norg-meta`); `:Neorg sync-parsers` no
  longer exists.
- Neorg depends on nvim-treesitter in its spec only to fix load order — without
  it Neorg sometimes warns "norg treesitter parser was not found" at startup
  even though the parser works.

### Treesitter
- Pinned to the frozen `master` branch (`require("nvim-treesitter.configs")`
  API). `auto_install = true` grabs parsers for new filetypes.
- Incremental selection: `<leader>is` start, `<leader>si` grow,
  `<leader>sc` grow to scope, `<leader>sd` shrink.
- Text objects: `af`/`if` function, `ac`/`ic` class, `as` scope.
- TODO someday: migrate to the `main` branch (new API, textobjects configured
  separately, parsers reinstalled).

### Navigation & files
| Key                         | Action                                   |
|-----------------------------|------------------------------------------|
| `-`                         | Oil: edit the parent directory as a buffer |
| `<leader>lf` / `<leader>lg` | Find files / live grep                   |
| `<leader>lb` / `<leader>lo` | Buffers / recent files                   |
| `<leader>lt` / `<leader>lc` | Tabs / command history                   |
| `s` / `S`                   | Flash jump / Flash treesitter select     |
| `r` / `R` (operator)        | Remote flash / treesitter search         |
| `<leader>u`                 | Undotree (built-in `nvim.undotree`)      |
| `<leader>?`                 | which-key: buffer-local keymaps          |
| `<leader>ht`                | Hide the tabline                         |
| `<C-k>`                     | Fix previous misspelling with first suggestion |

### UI
kanagawa-wave colorscheme (loads first), lualine, bufferline (only shows with
2+ buffers). Icons come from **mini.icons** only — it impersonates
nvim-web-devicons, so plugins asking for devicons still get icons. Don't add
nvim-web-devicons as a dependency again.

## Disabled plugins

Kept as specs with `enabled = false` — flip to `true` to try again:
- **image.nvim** — kitty image previews for markdown/norg/typst.
- **copilot.vim**
- **mini.pairs** — auto-pairs (the bracket-pair snippets cover some of this).

## Troubleshooting checklist

1. `:Lazy` — any red errors? `:Lazy log` for what changed recently.
2. `:checkhealth` (or `:checkhealth lazy`, `:checkhealth vim.lsp`, etc.).
3. `:messages` for errors that flashed by.
4. Broken after update → `:Lazy restore`.
5. Quick headless smoke test from the shell:
   `nvim --headless "+qa"` — no output means no startup errors.

## Committing & pushing

```sh
cd ~/dotfiles
git add .config/nvim
git commit -m "nvim: ..."
git push origin main
```

Push as the **KinguOFF** GitHub account (the repo owner) — if git
authenticates as another account the push fails with a 403
(`gh auth switch -u KinguOFF` fixes it).
