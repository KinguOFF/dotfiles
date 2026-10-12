#!/usr/bin/env bash
# Symlink these dotfiles into $HOME.
#
#   ./install.sh           create the symlinks
#   ./install.sh --deps    install the packages below with paru first, then link
#
# Anything already at a target that isn't a symlink is moved to
# <target>.bak.<timestamp> instead of being overwritten.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

# ---------------------------------------------------------------------------
# Dependencies (Arch package names; the AUR ones need paru/yay)
# ---------------------------------------------------------------------------
DEPS=(
  # Hyprland session
  hyprland uwsm hypridle hyprlock hyprpaper hyprsunset hyprpicker hyprshot
  hyprpolkitagent xdg-desktop-portal-hyprland
  xdg-desktop-portal-termfilechooser-boydaihungst-git   # AUR
  pipewire pipewire-pulse wireplumber brightnessctl playerctl
  wl-clipboard cliphist udiskie networkmanager bluez bluez-utils
  fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool
  qt5ct whitesur-gtk-theme                              # AUR (theme)

  # Rofi + hyprlock scripts
  rofi rofi-emoji acpi jq curl alsa-utils mpc

  # Terminal / shell
  kitty foot fish fisher fzf fd bat fortune-mod

  # Files
  yazi mediainfo trash-cli python
  ffmpegthumbnailer poppler imagemagick resvg 7zip unzip

  # Neovim
  neovim git base-devel ripgrep tree-sitter-cli luarocks python-sympy
  pyright clang texlab lua-language-server bash-language-server
  vscode-json-languageserver haskell-language-server tinymist typst
  hyprls-git elan-lean                                  # AUR

  # LaTeX
  texlive-basic texlive-latex texlive-latexrecommended texlive-latexextra
  texlive-binextra texlive-mathscience texlive-pictures texlive-fontsrecommended
  asymptote perl zathura zathura-pdf-mupdf

  # Apps referenced by hyprland.lua / mimeapps.list
  newsboat task yt-dlp aerc mpv imv
  librewolf-bin freetube-bin vesktop-bin                # AUR

  # Fonts
  ttf-jetbrains-mono-nerd ttf-iosevka-nerd ttf-bigblueterminal-nerd
  otf-geist-mono-nerd noto-fonts-emoji
)

# ---------------------------------------------------------------------------
# Symlinks: "<path in repo>:<path relative to $HOME>"
# ---------------------------------------------------------------------------
LINKS=(
  "texmf:texmf"
  ".latexmkrc:.latexmkrc"
  ".newsboat:.newsboat"
  ".config/.taskrc:.taskrc"
  ".config/mimeapps.list:.config/mimeapps.list"
)
for d in fish foot hypr kitty nvim rofi systemd uwsm yazi yt-dlp zathura \
         xdg-desktop-portal xdg-desktop-portal-termfilechooser
do
  LINKS+=(".config/$d:.config/$d")
done

link() {
  local src="$DOTFILES/$1" dst="$HOME/$2"

  if [[ ! -e "$src" ]]; then
    echo "skip   $2 (missing $1 in repo)"
    return
  fi

  # Already correct
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    echo "ok     $2"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$STAMP"
    echo "backup $2 -> $2.bak.$STAMP"
  fi

  # -n: replace an existing symlink to a directory instead of creating a link inside it
  ln -sfn "$src" "$dst"
  echo "link   $2 -> $src"
}

if [[ "${1:-}" == "--deps" ]]; then
  if ! command -v paru >/dev/null; then
    echo "paru not found; install it (or edit this script to use yay)" >&2
    exit 1
  fi
  paru -S --needed "${DEPS[@]}"
fi

for entry in "${LINKS[@]}"; do
  link "${entry%%:*}" "${entry#*:}"
done

# Pick up the user units in .config/systemd (cliphist, udiskie, ...)
if systemctl --user show-environment >/dev/null 2>&1; then
  systemctl --user daemon-reload
fi

cat <<'EOF'

Done. Next steps:
  - chsh -s /usr/bin/fish
  - fish -c 'fisher update'          # refresh fish plugins (fzf.fish, fuzzy_cd, tide)
  - nvim                             # lazy.nvim bootstraps and installs plugins
  - ya pkg install                   # (optional) refresh yazi plugins from package.toml
  - systemctl --user enable --now cliphist.service udiskie.service \
        hypridle.service hyprpaper.service hyprpolkitagent.service
  - put a wallpaper at ~/Pictures/Wallpapers/another_worlds.png (see hypr/hyprpaper.conf)
EOF
