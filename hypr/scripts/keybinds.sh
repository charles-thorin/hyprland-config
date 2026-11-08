#!/usr/bin/env bash
# Lists every described keybind in the launcher. Type to filter.
hyprctl binds -j | jq -r '
  def mods: [ (if (.modmask / 64 | floor) % 2 == 1 then "Super" else empty end),
              (if (.modmask / 4  | floor) % 2 == 1 then "Ctrl"  else empty end),
              (if (.modmask / 8  | floor) % 2 == 1 then "Alt"   else empty end),
              (if  .modmask % 2 == 1               then "Shift" else empty end) ];
  def keyname: ({ "ampersand":"1", "eacute":"2", "quotedbl":"3", "apostrophe":"4",
                  "parenleft":"5", "minus":"6", "egrave":"7", "underscore":"8",
                  "ccedilla":"9", "agrave":"0" }[.key] // .key);
  .[] | select(.has_description)
      | "\((mods + [keyname]) | join(" + "))\t\(.description)"' \
| column -t -s $'\t' \
| fuzzel --dmenu --prompt "Keybinds  " --width 60 --lines 18 >/dev/null
