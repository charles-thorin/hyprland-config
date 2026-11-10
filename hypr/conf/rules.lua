-- ── Window & layer rules ────────────────────────
-- Apps (Zen, Firefox, Electron apps…) can ask to open maximized: ignore that,
-- so new windows tile normally. Super + Page Up still maximizes on demand.
hl.window_rule({
    name           = "no-auto-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "float-volume-mixer",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
})

hl.window_rule({
    name  = "pip-float-pin",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
})

-- Wallpaper picker (Super + T): a floating window in the middle of the screen
hl.window_rule({
    name   = "wallpaper-picker",
    match  = { class = "^(waypaper)$" },
    float  = true,
    size   = "1100 700",
    center = true,
})

-- Don't blur the transparent corners around the floating bar
hl.layer_rule({
    name         = "bar-corners",
    match        = { namespace = "^(waybar)$" },
    ignore_alpha = 0.1,
})

-- Blur behind the bar, launcher and power menu (not notifications)
hl.layer_rule({
    name  = "blur-ui",
    match = { namespace = "^(waybar|launcher|logout_dialog)$" },
    blur  = true,
})
