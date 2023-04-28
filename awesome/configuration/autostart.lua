local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local gears = require("gears")
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom --config ~/Desktop/xos/modules/picom/picom-eric.conf", nil, function()
		--awful.spawn("picom --experimental-backends --config " .. config_dir .. "configuration/picom.conf", false)
		awful.spawn("picom")
		awful.spawn("xset r rate 160 60")
		awful.spawn("sxhkd")
		awful.spawn("xrandr --output eDP-1 --mode 1920x1080 --rate 144")


	end)
	--- Music Server
	helpers.run.run_once_pgrep("mpd")
	helpers.run.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	--- Other stuff
	helpers.run.run_once_grep("blueman-applet")
	helpers.run.run_once_grep("nm-applet")

	---Spawn Emacs if no other instance is running
	helpers.run.check_if_running("emacs", nil, function()
		awful.spawn("emacs")
	end)





	---Spawn xkeys if no other instance of python is running
	helpers.run.check_if_running("python", nil, function()
		awful.spawn.with_shell("python ~/desktop/xos/keyboard-sounds/main.py &")
	end)







end







--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Invisible Keyboard Sounds
-- 0.0.0




-- -- Kill the existing keyboard sounds process
-- awful.spawn.with_shell("pkill -f 'python ~/Desktop/xos/keyboard-sounds/main.py'")

-- Start the new keyboard sounds process after a short delay to ensure the previous process is killed
-- gears.timer.start_new(1, function()
--     awful.spawn.with_shell("python ~/Desktop/xos/keyboard-sounds/main.py &")
--     return false  -- One-shot timer, no need to run this function again
-- end)






--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------








autostart_apps()



--0.0.0
-- local function autostart_apps()
-- 	--- Compositor
-- 	helpers.run.check_if_running("picom --experimental-backends", nil, function()
-- 		--awful.spawn("picom --experimental-backends --config " .. config_dir .. "configuration/picom.conf", false)
-- 		awful.spawn("picom")
-- 		awful.spawn("xset r rate 160 60")
-- 		awful.spawn("sxhkd")
-- 		awful.spawn("xrandr --output eDP-1 --mode 1920x1080 --rate 144")
-- 		awful.spawn("emacs")
-- 	end)
-- 	--- Music Server
-- 	helpers.run.run_once_pgrep("mpd")
-- 	helpers.run.run_once_pgrep("mpDris2")
-- 	--- Polkit Agent
-- 	helpers.run.run_once_ps(
-- 		"polkit-gnome-authentication-agent-1",
-- 		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
-- 	)
-- 	--- Other stuff
-- 	helpers.run.run_once_grep("blueman-applet")
-- 	helpers.run.run_once_grep("nm-applet")
-- end

-- autostart_apps()
