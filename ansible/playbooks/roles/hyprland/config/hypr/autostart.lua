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
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'") -- for GTK3 apps
	hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- for Qt apps# Theme
	-- Force Primary monitor for games
	hl.exec_cmd("xrandr --output DP-1 --primary")
	-- Hyprland Items
	hl.exec_cmd("hypridle & hyprsunset")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("waybar & hyprpaper")
end)

-- Set Dark Theme across the board
