-- ── Window & layer rules ────────────────────────
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

-- Blur behind the bar, notifications, launcher and power menu
hl.layer_rule({
    name  = "blur-ui",
    match = { namespace = "^(waybar|notifications|launcher|logout_dialog)$" },
    blur  = true,
})
