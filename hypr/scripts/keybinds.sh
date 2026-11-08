#!/usr/bin/env bash
# Lists every described keybind in the launcher. Type to filter.
hyprctl binds -j | jq -r '
  def mods: [ (if (.modmask / 64 | floor) % 2 == 1 then "Super" else empty end),
              (if (.modmask / 4  | floor) % 2 == 1 then "Ctrl"  else empty end),
              (if (.modmask / 8  | floor) % 2 == 1 then "Alt"   else empty end),
              (if  .modmask % 2 == 1               then "Shift" else empty end) ];
  def keyname: if .key == "" and .keycode >= 10 and .keycode <= 18
               then (.keycode - 9 | tostring) else .key end;
  .[] | select(.has_description)
      | "\((mods + [keyname]) | join(" + "))\t\(.description)"' \
| column -t -s $'\t' \
| fuzzel --dmenu --prompt "Keybinds  " --width 60 --lines 18 >/dev/null
