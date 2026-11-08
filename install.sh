#!/usr/bin/env bash
# Links this repo's configs into ~/.config. Anything already there is moved
# to ~/.config/<name>.bak-<date> first, so nothing is lost.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"
CONF="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$REPO/$1" dst="$CONF/$1"
    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        echo "  ✓ $1 already linked"; return
    fi
    if [[ -e "$dst" || -L "$dst" ]]; then
        mv "$dst" "$dst.bak-$STAMP"; echo "  ↺ backed up $1 → $1.bak-$STAMP"
    fi
    ln -s "$src" "$dst"; echo "  → linked $1"
}

echo "Linking configs into $CONF"
mkdir -p "$CONF"
for d in hypr waybar wlogout mako fuzzel; do link "$d"; done

# kitty: keep your own kitty.conf, just add the theme to it
mkdir -p "$CONF/kitty"
cp "$REPO/kitty/hollow-knight.conf" "$CONF/kitty/hollow-knight.conf"
touch "$CONF/kitty/kitty.conf"
grep -qx 'include hollow-knight.conf' "$CONF/kitty/kitty.conf" \
    || echo 'include hollow-knight.conf' >> "$CONF/kitty/kitty.conf"
echo "  → kitty theme included"

mkdir -p "$HOME/Pictures/Wallpapers"

# waypaper: copy (not link), because it saves your chosen wallpaper in this file
if [[ ! -f "$CONF/waypaper/config.ini" ]]; then
    mkdir -p "$CONF/waypaper"
    backend=swww; command -v awww >/dev/null && backend=awww
    sed "s/@BACKEND@/$backend/" "$REPO/waypaper/config.ini" > "$CONF/waypaper/config.ini"
    echo "  → waypaper config created (backend: $backend)"
else
    echo "  ✓ waypaper config already exists, left as is"
fi

# Warn about missing icons
missing=0
for i in mask.svg mask-active.svg mask-empty.svg mask-urgent.svg knight.svg; do
    [[ -f "$REPO/waybar/icons/$i" ]] || { echo "  ! missing waybar/icons/$i"; missing=1; }
done
for i in lock logout suspend reboot shutdown; do
    [[ -f "$REPO/wlogout/icons/$i.svg" ]] || { echo "  ! missing wlogout/icons/$i.svg"; missing=1; }
done
(( missing )) && echo "    (see the README in each icons folder)"

echo
echo "Done. Put wallpapers in ~/Pictures/Wallpapers,"
echo "then log into Hyprland 0.57+ (or run: hyprctl reload && pkill waybar; waybar &)."
