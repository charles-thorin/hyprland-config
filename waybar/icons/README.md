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

All icons are in place, recoloured in the theme's pale white (#e8ecf2) so they
match on the dark bar:
- `knight.svg`, `krita.svg`: your line icons, with thicker strokes for small sizes
- `mask*.svg`: health masks adapted from your Architect mask
- `zen.svg`: your Zen rings, without the dark tile
- `kitty.svg`: your Kitty icon in pale tones (soul-blue eyes)
- `fleur.svg`: the "bud with vines" ornament

Sizes are set in `style.css`: masks are 18px tall (22px when active), and
dock icons are 24px.

Each icon also has an `@2x` copy, declared at double size. GTK uses it on
scaled screens (monitor scale above 1) so the icons stay sharp. If you replace
an icon, replace its `@2x` copy too, with the same drawing and doubled
`width`/`height` values.
