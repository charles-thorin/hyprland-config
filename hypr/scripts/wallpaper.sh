#!/usr/bin/env bash
# Wallpapers live in $HK_WALLPAPERS (default ~/Pictures/Wallpapers).
#   wallpaper.sh restore   at login: the wallpaper you last picked (or a random one)
#   wallpaper.sh random    Super + W: a random wallpaper with a slow fade
#   wallpaper.sh daemon    just make sure the wallpaper daemon is running
# Uses awww (formerly swww) if installed, otherwise swww.
DIR="${HK_WALLPAPERS:-$HOME/Pictures/Wallpapers}"
CMD=$(command -v awww || command -v swww) || { notify-send "Wallpaper" "Install awww or swww"; exit 1; }
CMD=$(basename "$CMD")

pgrep -x "$CMD-daemon" >/dev/null || setsid -f "$CMD-daemon" >/dev/null 2>&1

# Wait until the daemon really answers (it can take a few seconds at login)
for _ in $(seq 100); do
    "$CMD" query >/dev/null 2>&1 && break
    sleep 0.1
done

random_wallpaper() {
    FILE=$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' \) 2>/dev/null | shuf -n1)
    [[ -z "$FILE" ]] && { notify-send "Wallpaper" "No images found in $DIR"; exit 1; }
    "$CMD" img "$FILE" --transition-type fade --transition-duration 2 --transition-fps 60
}

case "${1:-random}" in
    daemon)  ;;
    restore) if command -v waypaper >/dev/null; then waypaper --restore || random_wallpaper; else random_wallpaper; fi ;;
    random)  if command -v waypaper >/dev/null; then waypaper --random || random_wallpaper; else random_wallpaper; fi ;;
esac
