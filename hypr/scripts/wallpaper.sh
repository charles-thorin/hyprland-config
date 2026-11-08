#!/usr/bin/env bash
# Picks a random wallpaper from $HK_WALLPAPERS with a slow fade.
# Uses awww (formerly swww) if installed, otherwise swww.
DIR="${HK_WALLPAPERS:-$HOME/Pictures/wallpapers/hollow-knight}"
CMD=$(command -v awww || command -v swww) || { notify-send "Wallpaper" "Install awww or swww"; exit 1; }
CMD=$(basename "$CMD")

pgrep -x "$CMD-daemon" >/dev/null || { setsid -f "$CMD-daemon" >/dev/null 2>&1; sleep 0.5; }

FILE=$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' \) 2>/dev/null | shuf -n1)
[[ -z "$FILE" ]] && { notify-send "Wallpaper" "No images found in $DIR"; exit 1; }

"$CMD" img "$FILE" --transition-type fade --transition-duration 2 --transition-fps 60
