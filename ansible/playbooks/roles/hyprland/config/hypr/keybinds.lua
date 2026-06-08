---------------------
---- KEYBINDINGS ----
---------------------
require("programs")

local mainMod = "SUPER" -- NOTE: Sets "Windows" key as main modifier

-- NOTE: Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close()) -- NOTE: Close Window

hl.bind(
	mainMod .. " + Q",
	hl.dsp.exec_cmd(
		terminal
			.. " --override background_image_layout=cscaled --override background_image=$(ls ~/.config/kitty/img/*.png | sort --random-sort | head -1)"
	)
) -- NOTE: Kitty Terminal with random backgrounds

hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(rofiApps)) -- NOTE: Rofi DRun
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- NOTE: Nautilus
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- NOTE: dwindle only
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(lock)) -- NOTE: Lock the computer
hl.bind(
	"CONTROL + SHIFT + S",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png')
) -- NOTE: Screenshot, place into clipboard

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- NOTE: Switch workspaces/move applications to workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- NOTE: Keepass special workspace
hl.bind(mainMod .. " + V", hl.dsp.workspace.toggle_special("keepass"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.move({ workspace = "special:keepass" }))

-- NOTE: SPOTIFY/SOUND special workspace
hl.bind(mainMod .. " + B", hl.dsp.workspace.toggle_special("media"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.window.move({ workspace = "special:media" }))

-- NOTE: Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- NOTE: Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- NOTE: Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- NOTE: Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
