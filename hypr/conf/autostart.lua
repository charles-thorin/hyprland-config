-- ── Autostart ───────────────────────────────────
return function(p)
    hl.on("hyprland.start", function ()
        hl.exec_cmd("waybar")
        hl.exec_cmd("mako")
        hl.exec_cmd("hypridle")
        hl.exec_cmd(p.scripts .. "/wallpaper.sh restore")
        -- Optional: password prompts for GUI apps
        -- hl.exec_cmd("systemctl --user start hyprpolkitagent")
    end)
end
