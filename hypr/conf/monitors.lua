-- ── Monitors ────────────────────────────────────
-- Default: every screen at its best resolution, placed automatically.
-- Run `hyprctl monitors` to see names, then add one block per screen, e.g.:
--   hl.monitor({ output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = 1 })
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
