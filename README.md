# dotfiles

My dotfiles for my Arch Linux install: Hyprland (Lua config) under uwsm,
kitty + fish, Neovim, rofi, yazi, plus LaTeX/newsboat/taskwarrior bits.

## Install

```sh
git clone https://github.com/KinguOFF/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh --deps   # install packages with paru, then symlink
./install.sh          # symlink only
```

The script is safe to re-run. Links that are already right are left alone,
and real files or directories in the way are moved to `<name>.bak.<timestamp>`.

### What gets linked

| In `~`                                        | From the repo                              |
|-----------------------------------------------|--------------------------------------------|
| `~/texmf`                                     | `texmf/` (personal LaTeX packages)         |
| `~/.latexmkrc`                                | `.latexmkrc`                               |
| `~/.newsboat`                                 | `.newsboat/`                               |
| `~/.taskrc`                                   | `.config/.taskrc`                          |
| `~/.config/mimeapps.list`                     | `.config/mimeapps.list`                    |
| `~/.config/fish`                              | `.config/fish/`                            |
| `~/.config/foot`                              | `.config/foot/`                            |
| `~/.config/hypr`                              | `.config/hypr/`                            |
| `~/.config/kitty`                             | `.config/kitty/`                           |
| `~/.config/nvim`                              | `.config/nvim/` (see its own README)       |
| `~/.config/rofi`                              | `.config/rofi/`                            |
| `~/.config/systemd`                           | `.config/systemd/` (user units)            |
| `~/.config/uwsm`                              | `.config/uwsm/`                            |
| `~/.config/xdg-desktop-portal`                | `.config/xdg-desktop-portal/`              |
| `~/.config/xdg-desktop-portal-termfilechooser`| `.config/xdg-desktop-portal-termfilechooser/` |
| `~/.config/yazi`                              | `.config/yazi/`                            |
| `~/.config/yt-dlp`                            | `.config/yt-dlp/`                          |
| `~/.config/zathura`                           | `.config/zathura/`                         |

### After installing

```sh
chsh -s /usr/bin/fish
fish -c 'fisher update'     # fzf.fish, fuzzy_cd, tide
nvim                        # lazy.nvim bootstraps itself and installs plugins
ya pkg install              # optional: refresh yazi plugins from package.toml
systemctl --user enable --now cliphist.service udiskie.service \
    hypridle.service hyprpaper.service hyprpolkitagent.service
```

Then log in through uwsm (`uwsm start hyprland.desktop`, or pick
*Hyprland (uwsm-managed)* in your display manager).

## Dependencies

The same list is in `DEPS` at the top of `install.sh`. Packages marked
**(AUR)** need an AUR helper (the script uses `paru`).

**Hyprland session**
- `hyprland` (new enough for the Lua config, `hyprland.lua`), `uwsm`
- `hypridle`, `hyprlock`, `hyprpaper`, `hyprsunset`, `hyprpicker`, `hyprshot`, `hyprpolkitagent`
- `xdg-desktop-portal-hyprland`, `xdg-desktop-portal-termfilechooser-boydaihungst-git` **(AUR)**: yazi as the file picker
- `pipewire`, `pipewire-pulse`, `wireplumber` (`wpctl` volume keys)
- `brightnessctl`, `playerctl`, `wl-clipboard`, `cliphist`, `udiskie`
- `networkmanager`, `bluez`, `bluez-utils` (hyprlock Wi-Fi/Bluetooth widgets)
- `fcitx5`, `fcitx5-gtk`, `fcitx5-qt`, `fcitx5-configtool` (input method, `us,br` layouts)
- `qt5ct`, `whitesur-gtk-theme` **(AUR)** (set in `uwsm/env`)

**Rofi and hyprlock scripts**
- `rofi`, `rofi-emoji`, `acpi` (battery applet)
- `jq`, `curl` (weather widget), `alsa-utils`, `mpc` (power menu suspend)

**Terminal / shell**
- `kitty` (default terminal), `foot` (alternative)
- `fish`, `fisher`, `fzf`, `fd`, `bat`, `fortune-mod` (greeting)

**File manager**
- `yazi`, `mediainfo` (mediainfo plugin), `trash-cli` (recycle-bin plugin), `python` (copy-as-URI keymap)
- Previews: `ffmpegthumbnailer`, `poppler`, `imagemagick`, `resvg`, `7zip`, `unzip`

**Neovim** (0.12+)
- `neovim`, `git`, `base-devel` (LuaSnip `jsregexp`), `ripgrep`, `fd`, `fzf` (fzf-lua)
- `tree-sitter-cli`, `luarocks` (neorg parsers), `python-sympy` (sympy snippet)
- LSPs: `pyright`, `clang`, `texlab`, `lua-language-server`, `bash-language-server`,
  `vscode-json-languageserver`, `haskell-language-server`, `tinymist` + `typst`,
  `hyprls-git` **(AUR)**, `elan-lean` **(AUR)** (Lean)

**LaTeX**
- `texlive-basic`, `texlive-latex`, `texlive-latexrecommended`, `texlive-latexextra`,
  `texlive-binextra` (latexmk), `texlive-mathscience`, `texlive-pictures`, `texlive-fontsrecommended`
- `asymptote`, `perl`, `zathura`, `zathura-pdf-mupdf`

**Apps** (autostarted or set as default handlers)
- `newsboat`, `task`, `yt-dlp`, `aerc`, `mpv`, `imv`
- `librewolf-bin`, `freetube-bin`, `vesktop-bin` **(AUR)**

**Fonts**
- `ttf-jetbrains-mono-nerd` (kitty, foot, rofi), `ttf-iosevka-nerd` (rofi launcher)
- `ttf-bigblueterminal-nerd`, `otf-geist-mono-nerd` (hyprlock), `noto-fonts-emoji`

## Notes

- A few paths are hardcoded to `/home/kingu` (`.taskrc`, `uwsm/env-hyprland`,
  the enabled-unit symlinks in `systemd/user/*.wants/`). Change them if your user is different.
- The wallpaper isn't in the repo. `hyprpaper.conf` expects `~/Pictures/Wallpapers/another_worlds.png`.
- `.config/nvim/snippets/` is a local copy of
  [friendly-snippets](https://github.com/rafamadriz/friendly-snippets), with a few edits.
- `.newsboat/cache.db` is gitignored, so feeds re-download on a new machine.

## Credits

- Rofi launchers, power menus and applets: [adi1090x/rofi](https://github.com/adi1090x/rofi)
- Hyprlock layout and widget scripts: adapted from a setup posted on r/unixporn
- Fish plugins: [PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish),
  [ttscoff/fuzzy_cd](https://github.com/ttscoff/fuzzy_cd), [IlanCosman/tide](https://github.com/IlanCosman/tide)
- Yazi plugins: [yazi-rs/plugins](https://github.com/yazi-rs/plugins),
  [boydaihungst/mediainfo.yazi](https://github.com/boydaihungst/mediainfo.yazi),
  [uhs-robert/recycle-bin.yazi](https://github.com/uhs-robert/recycle-bin.yazi)
