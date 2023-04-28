local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. "utilities/"


--TODO
-- local scratchpad_terminal = nil

-- local function toggle_scratchpad()
--     if not scratchpad_terminal then
--         awful.spawn.easy_async_with_shell("wezterm start --title scratchpad --class scratchpad", function(stdout, stderr, reason, exit_code)
--             if exit_code == 0 then
--                 scratchpad_terminal = true
--             end
--         end)
--     else
--         local matcher = function(c)
--             return awful.rules.match(c, { name = "scratchpad", class = "scratchpad" })
--         end
--         awful.client.run_or_raise("wezterm start --title scratchpad --class scratchpad", matcher)
--     end
-- end



return {
	--- Default Applications
	default = {
		--- Default terminal emulator
		terminal = "wezterm start --always-new-process",
		--- Default music client
		music_player = "wezterm start --class music ncmpcpp",
    --- Xonsh
    floating_kitty_xonsh = "kitty --class=floating-kitty-xonsh",

    --- web-xonsh
    floating_kitty_xonsh = "kitty --class=floating-kitty-xonsh",

    --- floating glass kitty
    floating_kitty_xonsh = "kitty --class=floating-kitty-xonsh",




    --- Toggle Picom Animations
		toggle_picom_animations = "bash -c 'if pgrep -x \"picom\" > /dev/null; then pkill picom; else picom & disown; fi'",

		--- Default text editor
		text_editor = "wezterm start nvim",
		--- Default code editor
		code_editor = "nvim",
		--- Default web browser
		web_browser = "firefox",
		--- Default file manager
		file_manager = "pcmanfm",
		--- Default network manager
		network_manager = "wezterm start iwctl",
		--- Default bluetooth manager
		bluetooth_manager = "blueman-manager",
		--- Default power manager
		power_manager = "xfce4-power-manager",
		--- Default rofi global menu
		app_launcher = "rofi -no-lazy-grab -show drun -modi drun -theme " .. config_dir .. "configuration/rofi.rasi",
	},

	--- List of binaries/shell scripts that will execute for a certain task
	utils = {
		--- Fullscreen screenshot
		full_screenshot = utils_dir .. "screensht full",
		--- Area screenshot
		area_screenshot = utils_dir .. "screensht area",
		--- Color Picker
		color_picker = utils_dir .. "xcolor-pick",
	},
}
