-------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)
hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
-- NOTE: Special Workspace
hl.window_rule({
	monitor = "DP-1",
	workspace = "special:magic silent",
	match = { class = "org.keepassxc.KeePassXC|org.pulseaudio.pavucontrol|Spotify" },
})

-- NOTE: Steam Games (With Steam prefix)
hl.window_rule({
	name = "Steam Games",
	match = { class = "^(steam_app_.*)$" },
	float = false,
	monitor = "DP-1",
})

-- NOTE: Steam Games (Without Steam prefix)
hl.window_rule({
	name = "Non prefixed steam games",
	match = { class = "bg3|TPM.x86_64" },
	float = false,
	monitor = "DP-1",
})
