# Waybar icons

| File              | Where it shows                              | Size  |
|-------------------|---------------------------------------------|-------|
| `knight.svg`      | Power menu button (far left)                | 30×30 |
| `mask.svg`        | Workspace that has windows                  | 17×22 |
| `mask-active.svg` | The workspace you're on                     | 20×26 |
| `mask-empty.svg`  | The workspace you're on, with no windows    | 20×26 |
| `mask-urgent.svg` | Workspace with an app asking for attention  | 20×26 |

Each SVG declares that exact size (`width`/`height`), and `style.css` uses the
same values, so GTK draws them sharp without scaling. If you change a size,
change it in both places.

The open-apps list on the right uses your system icon theme.
