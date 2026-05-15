-----------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- NOTE: Laptop Monitor
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080p",
	position = "1920x1080",
	scale = "1",
	transform = 0,
})

-- NOTE: Desktop Monitors
hl.monitor({
	output = "DP-1",
	mode = "1920x1080p@144",
	position = "0x0",
	scale = "1",
	transform = 0,
	supports_hdr = 0,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080p@144",
	position = "0x1080",
	scale = "1",
	transform = 0,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080p",
	position = "-1080x0",
	scale = "1",
	transform = 1,
})
