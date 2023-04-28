local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local icons = require("icons")











--- AWESOME Central panel
--- ~~~~~~~~~~~~~~~~~~~~~

return function(s)
	--- Header
	local function header()
		local dashboard_text = wibox.widget({
			markup = helpers.ui.colorize_text("Dashboard -", "#666c79"),
			font = beautiful.font_name .. "Black 14",
			valign = "center",
			widget = wibox.widget.textbox,
		})

		local function search_box()
			local search_icon = wibox.widget({
				font = "icomoon bold 12",
				align = "center",
				valign = "center",
				widget = wibox.widget.textbox(),
			})

			local reset_search_icon = function()
				search_icon.markup = helpers.ui.colorize_text("", beautiful.accent)
			end
			reset_search_icon()

			local search_text = wibox.widget({
				--- markup = helpers.ui.colorize_text("Search", beautiful.color8),
				align = "center",
				valign = "center",
				font = beautiful.font,
				widget = wibox.widget.textbox(),
			})

			local search = wibox.widget({
				{
					{
						search_icon,
						{
							search_text,
							bottom = dpi(2),
							widget = wibox.container.margin,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					left = dpi(15),
					widget = wibox.container.margin,
				},
				forced_height = dpi(35),
				forced_width = dpi(420),
				shape = gears.shape.rounded_bar,
				bg = beautiful.wibar_bg,
				widget = wibox.container.background(),
			})

			local function generate_prompt_icon(icon, color)
				return "<span font='icomoon 12' foreground='" .. color .. "'>" .. icon .. "</span> "
			end

			local function activate_prompt(action)
				search_icon.visible = false
				local prompt
				if action == "run" then
					prompt = generate_prompt_icon("", beautiful.accent)
				elseif action == "web_search" then
					prompt = generate_prompt_icon("", beautiful.accent)
				end
				helpers.misc.prompt(action, search_text, prompt, function()
					search_icon.visible = true
				end)
			end

			search:buttons(gears.table.join(
				awful.button({}, 1, function()
					activate_prompt("run")
				end),
				awful.button({}, 3, function()
					activate_prompt("web_search")
				end)
			))

			return search
		end

		local widget = wibox.widget({
			{
				dashboard_text,
				nil,
				search_box(),
				layout = wibox.layout.align.horizontal,
			},
			margins = dpi(10),
			widget = wibox.container.margin,
		})

		return widget
	end

	s.awesomewm = wibox.widget({
		{
        {
            image = gears.color.recolor_image(icons.awesome_logo, beautiful.accent),
            resize = true,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
        },
        strategy = "exact",
        height = dpi(40),
        widget = wibox.container.constraint,
	},
	margins = dpi(10),
	widget = wibox.container.margin,
    })

	--- Widgets
	s.stats = require("ui.panels.central-panel.stats")
	s.user_profile = require("ui.panels.central-panel.user-profile")
	s.quick_settings = require("ui.panels.central-panel.quick-settings")
	s.slider = require("ui.panels.central-panel.slider")
	s.music_player = require("ui.panels.central-panel.music-player")

	s.central_panel = awful.popup({
		type = "dock",
		screen = s,
		minimum_height = dpi(700),
		maximum_height = dpi(1700),
		minimum_width = dpi(700),
		maximum_width = dpi(700),
		bg = beautiful.transparent,
		ontop = true,
		visible = false,
		placement = function(w)
			awful.placement.top(w, {
				margins = { top = beautiful.wibar_height + dpi(5),bottom =  dpi(5), left = dpi(5), right = dpi(5) },
			})
		end,
		widget = {
			{
				{
					header(),
					margins = { top = dpi(10), bottom = dpi(10), right = dpi(20), left = dpi(20) },
					widget = wibox.container.margin,
				},
				{
					{
						{
							nil,
							{
								{
									s.user_profile,
									s.quick_settings,
									s.slider,
									layout = wibox.layout.fixed.vertical,
								},
								{
									s.stats,
									s.music_player,
									s.awesomewm,
									layout = wibox.layout.fixed.vertical,
								},
								layout = wibox.layout.align.horizontal,
							},
							layout = wibox.layout.align.vertical,
						},
						margins = dpi(10),
						widget = wibox.container.margin,
					},
					shape = helpers.ui.prrect(beautiful.border_radius * 2, true, true, false, false),
					bg = beautiful.wibar_bg,
					widget = wibox.container.background,
				},
				layout = wibox.layout.align.vertical,
			},
			bg = beautiful.widget_bg,
			shape = helpers.ui.rrect(beautiful.border_radius),
			widget = wibox.container.background,
		},
	})

	--- Toggle container visibility
	awesome.connect_signal("central_panel::toggle", function(scr)
		if scr == s then
			s.central_panel.visible = not s.central_panel.visible
		end
	end)


--XOS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- WIDGETS

--Create the slider widget
local picom_opacity_slider = wibox.widget {
    widget = wibox.widget.slider,
    minimum = 0,
    maximum = 100,
    step = 5,
    value = 100,
    forced_width = 200,
    forced_height = 20,
    bar_shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 4)
    end,
    handle_shape = function(cr, w, h)
        gears.shape.circle(cr, w, h, 4)
    end,
    handle_width = 10,
    handle_color = "#6791C9",
    bar_color = "#101213",
    shape = function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, true, true, false, false, 4)
    end,
    on_value_changed = function(self, value)
        awful.spawn("picom-trans -o " .. value)
    end
}

-- Create the toggle widget TODO
local toggle_widget = wibox.widget {
    {
        {
            id = "icon",
            widget = wibox.widget.imagebox,
            image = "/path/to/toggle_icon_off.png",
        },
        margins = 4,
        widget = wibox.container.margin,
    },
    widget = wibox.container.background,
    bg = "#333333",
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
}

-- Set up the toggle behavior
local toggle_state = false
toggle_widget:connect_signal("button::press", function()
    toggle_state = not toggle_state
    if toggle_state then
        toggle_widget.bg = "#6791C9"
        toggle_widget:get_children_by_id("icon")[1].image = "/path/to/toggle_icon_on.png"
        -- Do something when the toggle is on
    else
        toggle_widget.bg = "#333333"
        toggle_widget:get_children_by_id("icon")[1].image = "/path/to/toggle_icon_off.png"
        -- Do something when the toggle is off
    end
end)

local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")

cpu_widget({
    width = 30,
    step_width = 2,
    step_spacing = 10,
    color = '#101213'
})

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")


-- END WIDGETS


-- local tag_colors = {
--     "#5E5BA8",
--     "#FFC300",
--     "#DAF7A6",
--     "#C70039",
--     "#581845",
--     "#2E86C1",
--     "#28B463",
--     "#FA8072",
-- }

-- local testbox = wibox {
--     width = 1920,
--     height = 3,
--     x = 0,
--     y = 38,
--     ontop = true,
--     bg = tag_colors[1],
-- }

-- local function update_wibox_color()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag then
--         local index = tag.index
--         testbox.bg = tag_colors[index]
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", function()
--     update_wibox_color()
-- end)

-- update_wibox_color()

-- testbox.visible = true



-- YAY FINALLY IMAGES


-- 0.0.0
-- construct the absolute path to the image using os.getenv()
-- DISPLAY AN IMAGE IN EVERY TAG
-- local image_path = os.getenv("HOME") .. "/Desktop/assets/images/Emacs.png"

-- -- create an image widget with the absolute path
-- local image_widget = wibox.widget.imagebox(image_path)

-- -- create a wibox and set its properties
-- local my_wibox = wibox({
--     screen = screen.primary,
--     width = 75,
--     height = 75,
--     ontop = true,
--     visible = true,
--     type = "splash",
--     widget = image_widget,
--     bg = "#00000000", -- transparent background
-- })

-- -- move the wibox to the center of the screen and set it to appear only in tag 1
-- awful.placement.centered(my_wibox, {honor_workarea=true})
-- my_wibox:connect_signal("property::screen", function()
--     awful.tag.only_one(awful.screen.focused(), awful.tag.find_by_name(nil, "tag1"))
-- end)

-- -- set the wibox position to (x,y)
-- my_wibox:geometry({x=1830, y=940})







-- WIBOX EXAMPLE TO DISPLAY AN IMAGE IN A SPECIFIC TAG ONLY
-- Construct the absolute path to the image using os.getenv()
-- DOOM LOGO
local gears_timer = require("gears.timer")

-- Construct the absolute path to the image using os.getenv()
local image_path = os.getenv("HOME") .. "/Desktop/assets/images/Emacs.png"

-- Create an image widget with the absolute path
-- local image_widget = wibox.widget.imagebox(image_path)

-- -- Create a wibox and set its properties
-- local my_wibox = wibox({
--     screen = screen.primary,
--     width = 85,
--     height = 85,
--     ontop = true,
--     visible = false,
--     type = "dock",
--     widget = image_widget,
--     bg = "#00000000", -- transparent background
-- })



-- local function update_wibox_visibility()
--     local s = awful.screen.focused()
--     local tag = s.selected_tag

--     if tag and tag.index == 1 then
--         gears_timer.start_new(0.5, function()
--             my_wibox.visible = true
--         end)
--     else
--         my_wibox.visible = false
--     end
-- end

-- -- -- set the wibox position to (x,y)
-- my_wibox:geometry({x=1830, y=935})

-- -- Connect signals to update the wibox visibility
-- screen.connect_signal("tag::history::update", update_wibox_visibility)


-- -- Initialize the wibox visibility
-- update_wibox_visibility()









--Construct the absolute path to the image using os.getenv()
local image_path = os.getenv("HOME") .. "/Desktop/assets/images/emacs/doom/doom-evil.png"

-- Create an image widget with the absolute path
local image_widget = wibox.widget.imagebox(image_path)

-- Create a wibox and set its properties
local my_wibox = wibox({
    screen = screen.primary,
    width = 155,
    height = 155,
    ontop = true,
    visible = false,
    type = "dock",
    widget = image_widget,
    -- bg = "#645329", -- color merdas
    bg = "#00000000", -- transparent background
})



local function update_wibox_visibility()
    local s = awful.screen.focused()
    local tag = s.selected_tag

    if tag and tag.index == 1 then
        gears_timer.start_new(0.5, function()
            my_wibox.visible = true
        end)
    else
        my_wibox.visible = false
    end
end

-- -- set the wibox position to (x,y)
my_wibox:geometry({x=1530, y=100})

-- Connect signals to update the wibox visibility
screen.connect_signal("tag::history::update", update_wibox_visibility)


-- Initialize the wibox visibility
update_wibox_visibility()



















----------------------------------------------------------------------------------------------------------------------------------
-- XOS MENU SYSTEM VERY COOL STUFF THIS IS THE BASE IDEA

--LATEST VERSION YOU CAN SET THE START POSITION
--OUTIDE OF THE SCREN AND THE FINAL POSITION
-- 2
-- Create a wibox
-- local my_wibox = wibox({
--     visible = false,
--     ontop = true,
--     type = "normal",
--     width = 310,
--     height = 500,
--     bg = "#FF2E2A",
--     shape = gears.shape.rounded_rect,
-- })


-- my_wibox:setup {
--     layout = wibox.layout.align.horizontal,
--     my_text_widget,
-- }

-- -- Function to move the wibox to the center of the screen
-- -- local function move_to_center(screen)
-- --     my_wibox.x = screen.geometry.x + (screen.geometry.width - my_wibox.width) / 2
-- --     my_wibox.y = screen.geometry.y + (screen.geometry.height - my_wibox.height) / 2
-- -- end




-- -- Function to move the wibox to the center of the screen
-- local function move_to_center(screen)
--     my_wibox.x = 960
--     my_wibox.y = 1000
-- end







-- -- Function to spawn the wibox outside the screen and then move it to the center
-- local function spawn_and_move_wibox()
--     -- Spawn the wibox outside of the screen
--     my_wibox.x = 960
--     my_wibox.y = 2200

--     -- Make the wibox visible
--     my_wibox.visible = true

--     -- Animate the wibox moving to the center of the screen
--     gears.timer.start_new(0.5, function()
--         move_to_center(awful.screen.focused())
--     end)
-- end


-- -- Function to move the wibox outside the screen
-- local function move_outside(screen)
--     my_wibox.x = 960
--     my_wibox.y = 2200
-- end




-- spawn_and_move_wibox()













-----------------------------------------------------------------------------------------------------------------------------------------


-- ANIMATION PATTERNS

-- Configuration for animation duration and position
-- local duration = 2.4
-- local positions = {
--     {x = 700, y = 700},
--     {x = 1000, y = 50},
--     {x = 790, y = 900},
--     {x = 600, y =800}
-- }

-- -- Create the Wibox
-- local my_wibox = wibox({
--     width =  50,
--     height = 50,
--     bg = beautiful.bg_normal,
--     opacity = 0.9,
--     ontop = true,
--     visible = true
-- })

-- -- Add some content to the Wibox
-- -- local my_text = wibox.widget.textbox()
-- -- my_text:set_markup("<b>:3</b>")
-- -- my_wibox:setup {
-- --     layout = wibox.layout.align.horizontal,
-- --     my_text
-- -- }

-- -- Function to animate Wibox position
-- local function animate_position(index)
--     local pos = positions[index]
--     local x, y = pos.x, pos.y

--     -- Animate Wibox position
--     my_wibox.x = x
--     my_wibox.y = y

--     -- Schedule the next animation
--     index = (index % #positions) + 1
--     gears.timer.start_new(duration, function()
--         animate_position(index)
--     end)
-- end

-- -- Start the animation
-- animate_position(1)









-- MATH EXAMPLES

-- local math = require("math")

-- local colors = {"#FF2E2A", "#2ECC71", "#3498DB", "#9B59B6", "#F1C40F"}

-- local function random_color()
--     return colors[math.random(1, #colors)]
-- end

-- -- Create a wibox
-- local my_wibox = wibox({
--     visible = false,
--     ontop = true,
--     type = "normal",
--     width = 50,
--     height = 50,
--     bg = random_color(),
--     shape = gears.shape.rounded_rect,
-- })

-- my_wibox:setup {
--     layout = wibox.layout.align.horizontal,
--     my_text_widget,
-- }

-- local function outside_position(screen)
--     local x_choices = {-my_wibox.width, screen.geometry.width}
--     local y_choices = {-my_wibox.height, screen.geometry.height}

--     return x_choices[math.random(1, 2)], y_choices[math.random(1, 2)]
-- end

-- local function inside_position(screen)
--     return math.random(0, screen.geometry.width - my_wibox.width),
--            math.random(0, screen.geometry.height - my_wibox.height)
-- end

-- local function move_to_position(x, y)
--     my_wibox.x = x
--     my_wibox.y = y
-- end

-- local function show_wibox()
--     my_wibox.visible = true
-- end

-- local function hide_wibox()
--     my_wibox.visible = false
-- end

-- local function update_bg_color()
--     my_wibox.bg = random_color()
-- end

-- local function move_to_random_outside_position(screen)
--     local x, y = outside_position(screen)
--     move_to_position(x, y)
-- end

-- local function move_to_random_inside_position(screen)
--     local x, y = inside_position(screen)
--     move_to_position(x, y)
-- end

-- local function hide_and_move_outside()
--     hide_wibox()
--     move_to_random_outside_position(awful.screen.focused())
--     update_bg_color()
-- end

-- local function show_and_move_inside()
--     show_wibox()
--     move_to_random_inside_position(awful.screen.focused())
--     update_bg_color()
-- end

-- my_wibox:connect_signal("mouse::enter", function()
--     gears.timer.start_new(0.5, function()
--         hide_and_move_outside()
--         gears.timer.start_new(0.5, function()
--             show_and_move_inside()
--         end)
--     end)
-- end)

-- move_to_random_inside_position(awful.screen.focused())
-- show_wibox()









-- XOVERLAY



--XDOTOOL

-- local next_tag_wibox = wibox({
--     width = 15,
--     height = 15,
--     x = 1800,
--     y = 10,
--     ontop = true,
--     bg = "#60AEEE",
-- })

-- next_tag_wibox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key super+alt+Right")
--     end)
-- ))

-- next_tag_wibox.visible = true

-- local back_tag_wibox = wibox({
--     width = 30,
--     height = 30,
--     x = 1900,
--     y = 120,
--     ontop = true,
--     bg = "#BB3933",
-- })

-- back_tag_wibox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key super+alt+Left")
--     end)
-- ))

-- back_tag_wibox.visible = true




--  PICOM

-- TOGGLE ANIMATIONS

-- local reload_wibox = wibox({
--     width = 10,
--     height = 10,
--     x = 211,
--     y = 10,
--     ontop = true,
--     bg = "#DE8F78",
-- })

-- reload_wibox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key super+a")
--     end)
-- ))

-- reload_wibox.visible = true


-- -- RELOAD FIREFOX

-- local reload_wibox = wibox({
--     width = 20,
--     height = 20,
--     x = 222,
--     y = 10,
--     ontop = true,
--     bg = "#DE8F78",
-- })

-- reload_wibox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key control+r")
--     end)
-- ))

-- reload_wibox.visible = true










-- --KITTY 2 TAG

-- Create the Wibox
-- local mywibox = wibox({
--     width = 20,
--     height = 20,
--     x = 0,
--     y = -5,
--     ontop = true,
--     bg = "#101213",
--     visible = false,
-- })

-- -- Add custom CSS styles
-- mywibox.border_width = 2
-- mywibox.border_color = "#FFFFFF"
-- mywibox.fg = "#FFFFFF"
-- mywibox.font = "Arial 12"

-- -- Update the visibility of the Wibox based on the presence of kitty and the selected tag
-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     if not screen then return end
--     local tag = screen.selected_tag
--     if not tag then return end

--     local kitty_present = false
--     for _, c in ipairs(client.get()) do
--         if c.class == "floating-kitty-xonsh" then
--             kitty_present = true
--             break
--         end
--     end

--     if kitty_present and (tag.index == 1 or tag.index == 2) then
--         mywibox.y = 40
--         mywibox.visible = true
--     else
--         mywibox.y = -5
--         mywibox.visible = false
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- client.connect_signal("property::class", update_wibox_visibility)
-- update_wibox_visibility()
















----------------------------------------------------------------------------------------------------------------------

-- EMACS


--0.0.0
-- ANIMATED EMACS BAR

local mywibox = wibox({
    width = 1920,
    height = 40,
    x = 0,
    y = -40,
    ontop = true,
    type = "dock",
    bg = "#1D1F21",
    visible = true,
})

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 1 then
        mywibox.y = 0
    else
        mywibox.y = -40
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()


-- CSS
-- Create the Wibox
-- local mywibox = wibox({
--     width = 1,
--     height = 1,
--     x = 0,
--     y = -5,
--     ontop = true,
--     bg = "#1D1F21",
--     visible = true,
-- })

-- -- Add custom CSS styles
-- mywibox.border_width = 2
-- mywibox.border_color = "#51AFEF"
-- mywibox.fg = "#51AFEF"
-- mywibox.font = "Arial 12"

-- -- Update the visibility of the Wibox based on the selected tag
-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 1 then
--         mywibox.y = 40
--     else
--         mywibox.y = -5
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()



-----------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ?
-- local wibox = require("wibox")
-- local gears = require("gears")
-- local beautiful = require("beautiful")

-- local mywibox = wibox({
--     x = 0,
--     y = 40,
--     width = 1,
--     height = 40,
--     bg = "#FFFFFF00",
--     visible = true,
--     type = "dock",
--     ontop = true,
--     shape = gears.shape.rectangle,
--     widget = wibox.widget.base.make_widget(),
-- })

-- local function update_wibox_width()
--     local new_width = mywibox.width + 1
--     if new_width > 40 then
--         new_width = 1
--     end
--     mywibox.width = new_width
-- end

-- local mytimer = gears.timer {
--     timeout = 0.1,
--     call_now = true,
--     autostart = true,
--     callback = update_wibox_width,
-- }

-- return mywibox





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------













-- AWESOME-IMAGE
-- Construct the absolute path to the image using os.getenv()
-- local image_path = os.getenv("HOME") .. "/Desktop/assets/images/awesome.png"

-- -- Create an image widget with the absolute path
-- local image_widget = wibox.widget.imagebox(image_path)

-- -- Create a wibox and set its properties
-- local my_wibox = wibox({
--     screen = screen.primary,
--     width = 18,
--     height = 18,
--     ontop = true,
--     visible = false,
--     type = "dock",
--     widget = image_widget,
--     bg = "#00000000", -- transparent background
-- })

-- -- Add a button handler for left mouse button click
-- my_wibox:buttons(gears.table.join(
--     awful.button({}, 1, function()
--         awful.spawn("nemo") -- Replace "your_shell_command" with the actual command
--     end)
-- ))

-- local function update_wibox_visibility()
--     local s = awful.screen.focused()
--     local tag = s.selected_tag

--     if tag and tag.index == 1 then
--         gears_timer.start_new(0.5, function()
--             my_wibox.visible = true
--         end)
--     else
--         my_wibox.visible = false
--     end
-- end

-- -- set the wibox position to (x,y)
-- my_wibox:geometry({x=35, y=10})

-- -- Connect signals to update the wibox visibility
-- screen.connect_signal("tag::history::update", update_wibox_visibility)

-- -- Initialize the wibox visibility
-- update_wibox_visibility()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------















---- TOGGLE BUTTON
-- local s = awful.screen.focused() -- Get the focused screen

-- local tracking_wibox = wibox {
--     screen = s,
--     width = 20,
--     height = 20,
--     ontop = true,
--     x = 10,
--     y = 10,
--     visible = true,
--     bg = "#FF0000",
-- }

-- local tracking = false
-- local function toggle_tracking()
--     tracking = not tracking
--     if tracking then
--         tracking_wibox.bg = "#00FF00"
--         awful.spawn.with_shell("pkill -f 'entr -r'")
--         awful.spawn.with_shell("cd ~/.config/awesome && 'ls *.lua' | entr -r sh -c 'sleep 0.5; awesome-client \"awesome.restart()\"'")
--     else
--         tracking_wibox.bg = "#FF0000"
--         awful.spawn.with_shell("pkill -f 'entr -r'")
--     end
-- end

-- tracking_wibox:buttons(gears.table.join(
--     awful.button({ }, 1, function ()
--         toggle_tracking()
--     end)
-- ))








-- FIREFOX


-- AWESOME RELOAD

-- local reload_wibox = wibox({
--     width = 7,
--     height = 7,
--     x = 20,
--     y = 15,
--     ontop = true,
--     bg = "#B5BD68",
-- })

-- reload_wibox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key super+control+r")
--     end)
-- ))

-- reload_wibox.visible = true





-- FIREFOX BAR


-- GROWING BAR

-- local island_height = 40
-- local island_y = 0

-- local island = wibox({
--     width = 1920,
--     height = 1,
--     x = 0,
--     y = island_y + island_height - 1,
--     ontop = true,
--     bg = "#101213",
--     visible = true,
-- })

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         mywibox.visible = true
--         island.height = island_height
--         island.y = island_y
--     else
--         island.height = 1
--         mywibox.visible = false

--         island.y = island_y + island_height - 1
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()







-- local backbox = wibox({
--     width = 29,
--     height = 29,
--     x = -29,
--     y = 5,
--     ontop = true,
--     bg = "#D34037",
--     visible = true,
-- })

-- backbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Left")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local s = awful.screen.focused()
--     local tag = s.selected_tag

--     if tag and tag.index == 2 then
--             backbox.visible = true
--             backbox.y = 5
--             backbox.x = 15
--     else
--         backbox.visible = false
--     end
-- end


-- -- Connect signals to update the wibox visibility
-- screen.connect_signal("tag::history::update", update_wibox_visibility)




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- local backbox = wibox({
--     width = 29,
--     height = 29,
--     x = 6,
--     y = -40,
--     ontop = true,
--     bg = "#FC5753",
--     visible = true,
-- })



-- backbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Left")
--     end)
-- ))



-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         backbox.y = 5
--     else
--         backbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()




-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 40,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.1, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()






-- ---------------------------------------------------------------------------------------




-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 74,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.2, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()








-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 108,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.3, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()




-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 142,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.4, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()





-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 176,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.5, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()




-- local nextbox = wibox({
--     width = 29,
--     height = 29,
--     x = 210,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })


-- nextbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--             awful.util.spawn("xdotool key alt+Right")
--     end)
-- ))

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         gears_timer.start_new(0.6, function()
--             nextbox.y = 5
--         end)
--     else
--         nextbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()









-- local mywibox = wibox({
--     width = 29,
--     height = 29,
--     x = 74,
--     y = -40,
--     ontop = true,
--     bg = "#33C748",
--     visible = true,
-- })

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         mywibox.y = 5
--         mywibox.bg = "#3F9C35" -- set background color to green when Firefox is visible
--     else
--         mywibox.y = -29
--         mywibox.bg = "#DB4339" -- set background color to red when Firefox is not visible
--     end
-- end

-- -- add signal to detect when Firefox window is opened or closed
-- client.connect_signal("manage", function(c)
--     if c.class == "Firefox" then
--         update_wibox_visibility()
--     end
-- end)

-- client.connect_signal("unmanage", function(c)
--     if c.class == "Firefox" then
--         update_wibox_visibility()
--     end
-- end)

-- -- toggle visibility of Firefox in current tag when wibox is clicked
-- mywibox:connect_signal("button::press", function(_, _, _, button)
--     if button == 1 then -- left mouse button
--         local screen = awful.screen.focused()
--         local tag = screen.selected_tag
--         local clients = tag:clients()

--         for _, c in ipairs(clients) do
--             if c.class == "Firefox" then
--                 c.hidden = not c.hidden
--             end
--         end

--         update_wibox_visibility()
--     end
-- end)

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()







































-- EASING ANIMATIONS ?!?!?!?!?
--0.0.0
-- local w = 100 -- larghezza del wibox
-- local h = 100 -- altezza del wibox

-- -- Creiamo il wibox con le impostazioni desiderate
-- local mywibox = wibox({
--     visible = true,
--     ontop = true,
--     type = "dock",
--     width = w,
--     height = h,
--     x = 0,
--     y = 0,
--     bg = "#33C748"
-- })

-- -- Funzione per animare il wibox sulla base di una nuova posizione
-- local function move_wibox(new_x, new_y)
--     -- Numero di fotogrammi al secondo
--     local fps = 60
--     -- Tempo totale dell'animazione in secondi
--     local animation_time = 0.5
--     -- Numero di fotogrammi totali per l'animazione
--     local total_frames = animation_time * fps
--     -- Funzioni di easing per l'animazione
--     local ease_in_out = function(t) return t<.5 and 4*t*t*t or (t-1)*(2*t-2)*(2*t-2)+1 end
--     local elastic_out = function(t) return math.sin(-13*math.pi/2*t)*(2^(10*(t-1))) end
--     -- Numero di pixel da spostare ad ogni fotogramma
--     local delta_x = (new_x - mywibox.x) / total_frames
--     local delta_y = (new_y - mywibox.y) / total_frames

--     -- Funzione per aggiornare la posizione del wibox ad ogni fotogramma
--     local function update_wibox()
--         if total_frames > 0 then
--             local progress = 1 - total_frames / (animation_time * fps)
--             mywibox.x = mywibox.x + delta_x * ease_in_out(progress)
--             mywibox.y = mywibox.y + delta_y * elastic_out(progress)
--             total_frames = total_frames - 1
--             -- Richiama la funzione per aggiornare la posizione del wibox al prossimo fotogramma
--             gears.timer.start_new(1/fps, update_wibox)
--         end
--     end

--     -- Avvia la funzione di aggiornamento
--     update_wibox()
-- end

-- -- Utilizziamo il bottone del mouse per spostare il wibox ad una nuova posizione
-- mywibox:buttons(gears.table.join(
--     awful.button({}, 1, function()
--         -- Genera una nuova posizione casuale all'interno dello schermo
--         local new_x = math.random(screen[1].geometry.width - w)
--         local new_y = math.random(screen[1].geometry.height - h)
--         -- Avvia l'animazione del wibox alla nuova posizione
--         move_wibox(new_x, new_y)
--     end)
-- ))




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- fare che spawna solo se firefox E presente,
-- botom lefr corner,

-- local postbox = wibox({
--     width = 160,
--     height = 160,
--     x = 0,
--     y = 1000,
--     ontop = true,
--     bg = "#00000000", -- TRASPARENT
--     -- bg = "#FC5753",
--     visible = true,
-- })

-- postbox:connect_signal("mouse::enter", function()
--     awful.util.spawn("xdotool key alt+Left")
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 3 then
--         postbox.y = 940
--     else
--         postbox.y = 1300
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()








--  ISLAND BAR MINIMAL FOR TAG 4

-- local island = wibox({
--     width = 1920,
--     height = 1,
--     x = 0,
--     y = 39,
--     ontop = true,
--     bg = "#101213",
--     visible = true,
-- })

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 4 then
--         island.height = 40
--     else
--         island.height = 1
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()





























-- -- CHANGE TAG HOVERIN SCREEN EDGE

-- --2
-- local edgebox = wibox({
--     width = 10,
--     height = 1080,
--     x = 1915,
--     y = 0,
--     ontop = true,
--     bg = "#00000000", -- TRASPARENT
--     -- bg = "#FC5753",
--     visible = true,
-- })

-- edgebox:connect_signal("mouse::enter", function()
--     awful.util.spawn("xdotool key super+3")
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         edgebox.x = 1915
--     else
--         edgebox.x = 1920
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()








---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- HERE START THE REFACTORED CODE





--1


-- local edgebox = wibox({
--     width = 30,
--     height = 1080,
--     x = 1915,
--     y = 0,
--     ontop = true,
--     bg = "#00000000", -- TRASPARENT
--     -- bg = "#FC5753",
--     visible = true,
-- })

-- edgebox:connect_signal("mouse::enter", function()
--     awful.util.spawn("xdotool key super+2")
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 1 then
--         edgebox.x = 1890
--     else
--         edgebox.x = 1920
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()













-- -- TAG 1 EMACS TERM
-- local cacabox = wibox({
--     width = 1000,
--     height = 30,
--     x = 960,
--     y = 530,
--     ontop = true,
--     bg = "#00000000",
--     -- bg = "#BE3A34", -- RED TO SEE THE WIBOX
--     visible = true,
-- })

-- -- Set an initial state for the toggle
-- local toggle_state = false

-- cacabox:connect_signal("mouse::enter", function()
--     -- Toggle between the two commands
--     if toggle_state then
--         awful.util.spawn("xdotool key Super+1")
--     else
--         awful.util.spawn("xdotool key Super+j Super+Shift+j")
--     end

--     -- Update the toggle state
--     toggle_state = not toggle_state
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 1 then
--         cacabox.y = 1050
--     else
--         cacabox.y = 1300
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()



-- -- TAG 2 CENTRAL
-- -- TERM
-- local cacabox = wibox({
--     width = 640,
--     height = 30,
--     x = 0,
--     y = 1890,
--     ontop = true,
--     bg = "#00000000",
--     -- bg = "#BE3A34", -- RED TO SEE THE WIBOX
--     visible = true,
-- })

-- -- Set an initial state for the toggle
-- local toggle_state = false

-- cacabox:connect_signal("mouse::enter", function()
--     -- Toggle between the two commands
--     if toggle_state then
--         awful.util.spawn("xdotool key Super+2")
--     else
--         awful.util.spawn("xdotool key Super+j Super+Shift+h Super+Shift+j")
--     end

--     -- Update the toggle state
--     toggle_state = not toggle_state
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         cacabox.y = 1050
--     else
--         cacabox.y = 1300
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()



-- -- 2
-- local cacabox = wibox({
--     width = 640,
--     height = 30,
--     x = 640,
--     y = 1890,
--     ontop = true,
--     bg = "#00000000",
--     -- bg = "#BE3A34", -- RED TO SEE THE WIBOX
--     visible = true,
-- })

-- -- Set an initial state for the toggle
-- local toggle_state = false

-- cacabox:connect_signal("mouse::enter", function()
--     -- Toggle between the two commands
--     if toggle_state then
--         awful.util.spawn("xdotool key Super+2")
--     else
--         awful.util.spawn("xdotool key Super+j Super+Shift+j")
--     end

--     -- Update the toggle state
--     toggle_state = not toggle_state
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         cacabox.y = 1050
--     else
--         cacabox.y = 1300
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()


-- --3
-- local cacabox = wibox({
--     width = 640,
--     height = 30,
--     x = 1280,
--     y = 1890,
--     ontop = true,
--     bg = "#00000000",
--     -- bg = "#BE3A34", -- RED TO SEE THE WIBOX
--     visible = true,
-- })

-- -- Set an initial state for the toggle
-- local toggle_state = false

-- cacabox:connect_signal("mouse::enter", function()
--     -- Toggle between the two commands
--     if toggle_state then
--         awful.util.spawn("xdotool key Super+2")
--     else
--         awful.util.spawn("xdotool key Super+j Super+Shift+l Super+Shift+j")
--     end

--     -- Update the toggle state
--     toggle_state = not toggle_state
-- end)

-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and tag.index == 2 then
--         cacabox.y = 1050
--     else
--         cacabox.y = 1300
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()







--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TAG  3
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GROWING BAR LEFT SIDE

local island_height = 40
local island_y = 0

local island = wibox({
    width = 300,
    height = 1,
    x = 0,
    y = island_y + island_height - 1,
    ontop = true,
    type = "dock",
    bg = "#101213",
    visible = true,
})

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 3 then
        mywibox.visible = true
        island.height = island_height
        island.y = island_y
    else
        island.height = 1
        mywibox.visible = false

        island.y = island_y + island_height - 1
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()


-- GROWING BAR RIGHT SIDE

local island_height = 40
local island_y = 0

local island = wibox({
    width = 300,
    height = 1,
    x = 1620,
    y = island_y + island_height - 1,
    ontop = true,
    type = "dock",
    bg = "#101213",
    visible = true,
})

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 3 then
        mywibox.visible = true
        island.height = island_height
        island.y = island_y
    else
        island.height = 1
        mywibox.visible = false

        island.y = island_y + island_height - 1
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()











local webtermbox = wibox({
    width = 60,
    height = 1080,
    x = 0,
    y = 0,
    ontop = true,
	type = "dock",
    bg = "#00000000",
    visible = true,
})

-- Set an initial state for the toggle
local toggle_state = false

webtermbox:connect_signal("mouse::enter", function()
    -- Toggle between the two commands
    if toggle_state then
        awful.util.spawn("xdotool key Super+3")
    else
        awful.util.spawn("xdotool key Super+h Super+Shift+h")
    end

    -- Update the toggle state
    toggle_state = not toggle_state
end)

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 3 then
        webtermbox.x = 0
    else
        webtermbox.x = -10
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()






-- TAG 4








end
