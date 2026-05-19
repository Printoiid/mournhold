-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
require("programs")

hl.on("hyprland.start", function()
	-- Force Dark Theme
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'") -- for GTK4 apps
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-dark'") -- for GTK3 apps
	hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- for Qt apps# Theme
	-- NOTE: Hyprland Items
	hl.exec_cmd("hypridle & hyprsunset & waybar & hyprpaper")
	hl.exec_cmd("nm-applet")
	-- NOTE: Applications
	hl.exec_cmd("spotify-launcher & pavucontrol & keepassxc")
end)
