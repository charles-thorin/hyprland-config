# Waybar icons

Drop your icons here with these exact names. SVG works best because it stays
sharp at any size. You can use PNG too, if you change the extension in
`waybar/style.css`.

| File              | Where it shows                              |
|-------------------|---------------------------------------------|
| `mask.svg`        | Workspace that has windows                  |
| `mask-active.svg` | The workspace you're on                     |
| `mask-empty.svg`  | The workspace you're on, with no windows    |
| `mask-urgent.svg` | Workspace with an app asking for attention  |
| `fleur.svg`       | Top of the dock, click to unfold the bar    |
| `zen.svg`         | Zen Browser launcher                        |
| `kitty.svg`       | Kitty launcher                              |
| `krita.svg`       | Krita launcher                              |
| `knight.svg`      | Power menu                                  |

Already here: `knight.svg` (your Knight head, with a thicker stroke) and the
four `mask*.svg` health masks (adapted from your Architect mask). Still needed:
`fleur.svg`, `zen.svg`, `kitty.svg`, `krita.svg`.

Sizes are set in `style.css`: masks are 18px tall (22px when active), and
dock icons are 24px.
