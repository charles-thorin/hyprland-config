#!/usr/bin/env bash
# Super + H: lists every keybind (written by conf/keybinds.lua at each reload).
# Type to filter, Esc to close.
LIST="${XDG_RUNTIME_DIR:-/tmp}/hypr-keybinds.tsv"
if [[ ! -s "$LIST" ]]; then
    notify-send "Keybinds" "No list found yet — run: hyprctl reload"
    exit 1
fi
# AZERTY number-row names → digits, for readability
sed -e 's/ampersand/1/; s/eacute/2/; s/quotedbl/3/; s/apostrophe/4/; s/parenleft/5/' \
    -e 's/+ minus/+ 6/; s/egrave/7/; s/underscore/8/; s/ccedilla/9/; s/agrave/0/' \
    -e 's/SUPER/Super/g; s/SHIFT/Shift/g; s/CTRL/Ctrl/g; s/ALT/Alt/g; s/Page_Up/Page Up/' "$LIST" \
| awk -F'\t' '{ printf "%-28s %s\n", $1, $2 }' \
| fuzzel --dmenu --prompt "Keybinds  " --width 60 --lines 18 >/dev/null
