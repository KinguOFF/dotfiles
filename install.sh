#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.config"

ln -sf "$HOME/dotfiles/texmf"                         "$HOME/texmf"
ln -sf "$HOME/dotfiles/.latexmkrc"                    "$HOME/.latexmkrc"

# Config directories
for d in fish foot hypr kitty nvim rofi systemd uwsm \
         xdg-desktop-portal-termfilechooser von yazi zathura yt-dlp
do
  ln -sf "$HOME/dotfiles/.config/$d" "$HOME/.config/$d"
done

# Single file in .config
ln -sf "$HOME/dotfiles/.config/mimeapps.list"         "$HOME/.config/mimeapps.list"

