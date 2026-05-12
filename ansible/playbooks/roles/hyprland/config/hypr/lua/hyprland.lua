-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

include("monitors.lua")
include("programs.lua")
include("autostart.lua")
include("env.lua")
include("permissions.lua")
include("look-and-feel.lua")
include("misc.lua")
include("input.lua")
include("keybinds.lua")
include("windows-and-workspaces.lua")
