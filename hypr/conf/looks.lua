-- ── Looks: pale, spectral, quiet ────────────────
-- Palette
--   void      #0b0d12   background
--   pale      #e8ecf2   spectral white (UI, borders)
--   soul      #bfe0ff   soft blue glow (focus)
--   infection #f08a24   only for urgent things

hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 10,
        border_size      = 2,
        col = {
            active_border   = { colors = { "rgba(e8ecf2ee)", "rgba(bfe0ffaa)" }, angle = 45 },
            inactive_border = "rgba(2a2f3a88)",
        },
        layout           = "dwindle",
        resize_on_border = true,
    },

    decoration = {
        rounding         = 10,
        active_opacity   = 1.0,
        inactive_opacity = 0.96,

        -- Focus aid: windows you are not using fade slightly into the dark
        dim_inactive = true,
        dim_strength = 0.12,

        shadow = {
            enabled      = true,
            range        = 14,
            render_power = 3,
            color        = 0x22bfe0ff,   -- 0xAARRGGBB: faint ghostly glow
        },

        blur = {
            enabled  = true,
            size     = 6,
            passes   = 3,
            vibrancy = 0.15,
        },
    },

    animations = { enabled = true },

    dwindle = {
        pseudotile     = true,
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        focus_on_activate        = false,   -- apps can't steal your focus
        background_color         = "rgb(0b0d12)",
    },
})

-- Soft, drifting motion — like dust in the Ancient Basin
hl.curve("drift", { type = "bezier", points = { {0.22, 1}, {0.36, 1} } })
hl.curve("soft",  { type = "bezier", points = { {0.4, 0},  {0.2, 1}  } })

hl.animation({ leaf = "windowsIn",   enabled = true, speed = 4, bezier = "drift", style = "popin 92%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "soft",  style = "popin 92%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "drift" })
hl.animation({ leaf = "border",      enabled = true, speed = 8, bezier = "soft" })
hl.animation({ leaf = "fade",        enabled = true, speed = 4, bezier = "soft" })
hl.animation({ leaf = "layers",      enabled = true, speed = 3, bezier = "drift", style = "fade" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, bezier = "drift", style = "slidefade 12%" })
