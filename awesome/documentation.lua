-- DOCUMENTATION
---- to quickly copy paste funnctionality
---- all functioning standalone wibox



-- move the wibox to the center of the screen
awful.placement.centered(my_wibox, {honor_workarea=true})

-- set a timer to close the wibox after 5 seconds
gears.timer.start_new(5, function()
    my_wibox.visible = false
    my_wibox = nil
    return false
end)


--make a wibox disappear on mouse leave
my_wibox:connect_signal("mouse::leave", function() my_wibox.visible = false end)


--WIBOX EXAMPLES

-- make a wibox visible only in one tag (1)
--aka barra del term feega 0.0.1
local termbottom = wibox {
    width = 1664,
    height = 22,
    x = 88,
    y = 1038,
    ontop = true,
    bg = violaTop,
}

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 1 then
       termbottom.visible = true
    else
        termbottom.visible = false
    end
end
awful.tag.attached_connect_signal(nil, "property::selected", function() update_wibox_visibility()
end)

update_wibox_visibility()





local morphing_wibox = wibox({
    visible = true,
    width = 200,
    height = 200,
    bg = "#6490F0",
    shape = gears.shape.circle
})

local shape_toggle = false

gears.timer.start_new(3, function()
    shape_toggle = not shape_toggle
    if shape_toggle then
        morphing_wibox.shape = gears.shape.circle
    else
        morphing_wibox.shape = gears.shape.rectangle
    end
    return true
end)




--HERE ARE SOME EXAMPLES OF CAIRO


--1


-- Function to draw the PACMAN LOGO
local function draw_emacs_logo(cr, width, height)
    local radius = math.min(width, height) / 2
    local angle1 = math.pi * 0.2
    local angle2 = math.pi * 1.8

    cr:set_source_rgb(1, 1, 1) -- Set the color (white) for the logo
    cr:arc(width / 2, height / 2, radius, angle1, angle2)
    cr:line_to(width / 2, height / 2)
    cr:close_path()
    cr:fill()
end

-- Define your custom wibox properties
local custom_wibox = {
    width = 40,
    height = 40,
    x = 500,
    y = 20,
    ontop = true,
    bg = "#101213",
}

--2


-- Create a + icons

local my_wibox = wibox(custom_wibox)

-- Create a watch widget to set the shape of the wibox
local update_shape = awful.widget.watch("echo", 1, function(widget, stdout)
    local img = gears.surface.load_from_shape(40, 40, draw_emacs_logo, "#101213")
    my_wibox.shape_bounding = img._native
    my_wibox.shape_clip = img._native
end)

-- Set the wibox visibility
my_wibox.visible = true


-- Function to draw the + logo
local function draw_emacs_logo(cr, width, height)
    cr:set_line_width(2)
    cr:set_source_rgb(1, 1, 1) -- Set the color (white) for the logo

    cr:arc(width / 2, height / 2, width / 2 - 2, 0, 2 * math.pi)
    cr:stroke()

    cr:move_to(width / 2, height / 4)
    cr:line_to(width / 2, 3 * height / 4)
    cr:stroke()

    cr:move_to(width / 4, height / 2)
    cr:line_to(3 * width / 4, height / 2)
    cr:stroke()
end

-- Define your custom wibox properties
local custom_wibox = {
    width = 30,
    height = 30,
    x = 1400,
    y = 4,
    ontop = true,
    bg = "#5E5BA8",
}

-- Create your standalone wibox
local my_wibox = wibox(custom_wibox)

-- Create a watch widget to set the shape of the wibox
local update_shape = awful.widget.watch("echo", 1, function(widget, stdout)
    local img = gears.surface.load_from_shape(30, 30, draw_emacs_logo, "#101213")
    my_wibox.shape_bounding = img._native
    my_wibox.shape_clip = img._native
end)

-- Set the wibox visibility
my_wibox.visible = true



-- PLAYING WITH TIME

local gears_timer = require("gears.timer")

-- MAKE THE WIBOX SPAWN AFTER 2 SECONDS
local function update_wibox_visibility()
    local s = awful.screen.focused()
    local tag = s.selected_tag

    if tag and tag.index == 1 then
        gears_timer.start_new(2, function()
            my_wibox.visible = true
        end)
    else
        my_wibox.visible = false
    end
end



-- YAY FINALLY IMAGES


-- 0.0.0
-- construct the absolute path to the image using os.getenv()
-- DISPLAY AN IMAGE IN EVERY TAG
local image_path = os.getenv("HOME") .. "/Desktop/assets/images/Emacs.png"

-- create an image widget with the absolute path
local image_widget = wibox.widget.imagebox(image_path)

-- create a wibox and set its properties
local my_wibox = wibox({
    screen = screen.primary,
    width = 75,
    height = 75,
    ontop = true,
    visible = true,
    type = "splash",
    widget = image_widget,
    bg = "#00000000", -- transparent background
})

-- move the wibox to the center of the screen and set it to appear only in tag 1
awful.placement.centered(my_wibox, {honor_workarea=true})
my_wibox:connect_signal("property::screen", function()
    awful.tag.only_one(awful.screen.focused(), awful.tag.find_by_name(nil, "tag1"))
end)

-- set the wibox position to (x,y)
my_wibox:geometry({x=1830, y=940})



-- MESSING ARROUND WITH ANIMATIONS



-- ANIMATED CUBE
local spiral_wibox = wibox({
    width = 200,
    height = 200,
    bg = "#6490F0",
    shape = gears.shape.rectangle,
})

local spiral_size = 50
local angle = 0
local speed = 0.01

gears.timer.start_new(0.05, function()
    angle = angle + speed
    local spiral_x = 100 + (spiral_size * math.cos(angle))
    local spiral_y = 100 + (spiral_size * math.sin(angle))

    spiral_wibox.x = spiral_x
    spiral_wibox.y = spiral_y
    spiral_wibox.width = spiral_size
    spiral_wibox.height = spiral_size

    spiral_size = spiral_size + 2
    if spiral_size > 200 then
        spiral_size = 50
    end

    return true
end)

spiral_wibox.visible = true


-- for some reason ciro do not work





-- ANIMATED BUTTONS


-- CIRCULAR MENU

local icons = {}
local icon_size = 50
local distance = 100
local scale_factor = 1.5
local center = {x = 500, y = 500}
local animation_time = 0.3

for i = 1, 5 do
    local icon = wibox({
        width = icon_size,
        height = icon_size,
        x = center.x + (distance * math.cos(math.pi * 2 * i / 5)),
        y = center.y + (distance * math.sin(math.pi * 2 * i / 5)),
        bg = "#5E5BA8",
        shape = gears.shape.circle,
    })

    icons[i] = icon
end

local mouse_tracker = gears.timer.start_new(
    0.05,
    function ()
        local mouse_coords = mouse.coords()
        local closest_icon = 0
        local closest_distance = math.huge

        for i = 1, 5 do
            local distance = math.sqrt(math.pow(mouse_coords.x - icons[i].x, 2) + math.pow(mouse_coords.y - icons[i].y, 2))
            if distance < closest_distance then
                closest_icon = i
                closest_distance = distance
            end
        end

        for i = 1, 5 do
            local size = icon_size
            local x = center.x + (distance * math.cos(math.pi * 2 * i / 5))
            local y = center.y + (distance * math.sin(math.pi * 2 * i / 5))

            if i == closest_icon then
                size = icon_size * scale_factor
                x = center.x + (distance * scale_factor * math.cos(math.pi * 2 * i / 5))
                y = center.y + (distance * scale_factor * math.sin(math.pi * 2 * i / 5))
            elseif math.abs(closest_icon - i) == 1 then
                local factor = (closest_distance - distance) / (distance * (scale_factor - 1))
                factor = math.max(0, math.min(1, factor))

                size = icon_size + (icon_size * (scale_factor - 1) * factor)
                x = center.x + (distance * (1 + (scale_factor - 1) * factor) * math.cos(math.pi * 2 * i / 5))
                y = center.y + (distance * (1 + (scale_factor - 1) * factor) * math.sin(math.pi * 2 * i / 5))
            end

            gears.timer.start_new(
                animation_time,
                function ()
                    icons[i]:geometry({
                        width = size,
                        height = size,
                        x = x,
                        y = y,
                    })
                end
            ) end return true
    end
)

for i = 1, 5 do
    icons[i].visible = true
end




-- 0.0.0
-- XOS MENU SYSTEM VERY COOL STUFF THIS IS THE BASE IDEA
-- Create a wibox
local my_wibox = wibox({
    visible = false,
    ontop = true,
    type = "normal",
    width = 200,
    height = 100,
    bg = "#000000",
    shape = gears.shape.rounded_rect,
})

-- Add a simple text widget to the wibox
local my_text_widget = wibox.widget({
    widget = wibox.widget.textbox,
    text = "Hello, world!",
    align = "center",
    valign = "center",
    font = "sans 14",
})

my_wibox:setup {
    layout = wibox.layout.align.horizontal,
    my_text_widget,
}

-- Function to move the wibox to the center of the screen
local function move_to_center(screen)
    my_wibox.x = screen.geometry.x + (screen.geometry.width - my_wibox.width) / 2
    my_wibox.y = screen.geometry.y + (screen.geometry.height - my_wibox.height) / 2
end

-- Function to spawn the wibox outside the screen and then move it to the center
local function spawn_and_move_wibox()
    -- Spawn the wibox outside of the screen
    my_wibox.x = -my_wibox.width
    my_wibox.y = -my_wibox.height

    -- Make the wibox visible
    my_wibox.visible = true

    -- Animate the wibox moving to the center of the screen
    gears.timer.start_new(0.5, function()
        move_to_center(awful.screen.focused())
    end)
end

spawn_and_move_wibox()







-- CREATE A WIBAR CONTAING THE UPDATING X AND Y POSITION OF THE SCREEN

-- Create a wibar
local mywibox = awful.wibar({
    position = "top",
    screen = s,
})

-- Create a textbox widget to display the mouse position
local mouse_pos_widget = wibox.widget.textbox()

-- Update the mouse position widget with the current mouse position
local function update_mouse_pos_widget()
    local mouse_coords = mouse.coords()
    mouse_pos_widget.text = string.format("(%d, %d)", mouse_coords.x, mouse_coords.y)
end

-- Create a timer to update the mouse position widget every 0.1 seconds
local mouse_pos_timer = gears.timer({
    timeout = 0.1,
    autostart = true,
    callback = update_mouse_pos_widget
})

-- Create a keybinding to toggle the mouse position widget on and off
local toggle_mouse_pos_widget = function()
    if mouse_pos_widget.visible then
        mouse_pos_widget.visible = false
        mouse_pos_timer:stop()
    else
        mouse_pos_widget.visible = true
        mouse_pos_timer:start()
    end
end
awful.keygrabber {
    keybindings = {
        awful.key({ modkey }, "p", function() toggle_mouse_pos_widget() end,
                  { description = "Toggle mouse position widget", group = "Custom" })
    },
    stop_key = modkey
}

-- Create a mouse follower widget that follows the mouse cursor
local mouse_follower_widget = wibox.widget({
    widget = wibox.container.background,
    bg = "#00000000",
    shape = gears.shape.circle,
    forced_width = 20,
    forced_height = 20,
    visible = false,
    {
        widget = wibox.container.margin,
        left = 2,
        right = 2,
        top = 2,
        bottom = 2,
        {
            widget = wibox.widget.imagebox,
            image = "/path/to/mouse_follower_icon.png",
            resize = true,
        },
    },
})

-- Update the mouse follower widget position with the current mouse position
local function update_mouse_follower_widget()
    local mouse_coords = mouse.coords()
    mouse_follower_widget.x = mouse_coords.x - mouse_follower_widget.width / 2
    mouse_follower_widget.y = mouse_coords.y - mouse_follower_widget.height / 2
end

-- Connect the update_mouse_follower_widget function to the mouse::motion signal
mouse_follower_widget:connect_signal("mouse::motion", function()
    update_mouse_follower_widget()
end)

-- Create a keybinding to toggle the mouse follower widget on and off
local toggle_mouse_follower_widget = function()
    if mouse_follower_widget.visible then
        mouse_follower_widget.visible = false
    else
        mouse_follower_widget.visible = true
        update_mouse_follower_widget()
    end
end
awful.keygrabber {
    keybindings = {
        awful.key({ modkey }, "f", function() toggle_mouse_follower_widget() end,
                  { description = "Toggle mouse follower widget", group = "Custom" })
    },
    stop_key = modkey
}

-- Create a mouse_enter_callback to show the mouse follower widget when the mouse enters the screen
local function mouse_enter_callback()
    if mouse_follower_widget.visible then
        update_mouse_follower_widget()
    end
end

-- Connect the mouse_enter_callback to the mouse::enter signal
mouse_follower_widget:connect_signal("mouse::enter", function()
    mouse_enter_callback()
end)

-- Add the mouse position widget and the mouse follower widget to the wibar
mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
        layout = wibox.layout.fixed.horizontal,
        -- Add other widgets to the wibar here
        mouse_pos_widget,
    },
    nil,
    {
        layout = wibox.layout.fixed.horizontal,
        -- Add other widgets to the wibar here
        mouse_follower_widget,
    }
}

-- Hide the mouse follower widget when the mouse leaves the screen
mouse_follower_widget:connect_signal("mouse::leave", function()
    mouse_follower_widget.visible = false
end)



-- TTY-BAR
-- Required libraries
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

-- Number of TTY sessions
local num_tty_sessions = 8

-- Colors for each TTY session
local tty_colors = {
    "#FF0000",
    "#00FF00",
    "#0000FF",
    "#FFFF00",
    "#FF00FF",
    "#00FFFF",
    "#C0C0C0",
    "#808080",
}

-- Create a circle shape widget for each TTY session
local tty_widgets = {}
for i = 1, num_tty_sessions do
    tty_widgets[i] = wibox.widget({
        widget = wibox.widget.shape_widget,
        shape = gears.shape.circle,
        bg = tty_colors[i],
        shape_border_color = beautiful.fg_normal,
        shape_border_width = 2,
        forced_width = 20,
        forced_height = 20,
    })
end

-- Function to update the TTY session circles
local function update_tty_widgets()
    local current_tty = io.popen("echo $XDG_SESSION_TYPE"):read("*all")
    current_tty = tonumber(current_tty:gsub("%W", ""))

    for i = 1, num_tty_sessions do
        if i == current_tty then
            tty_widgets[i].bg = beautiful.bg_normal
            tty_widgets[i].shape_border_color = beautiful.fg_normal
        else
            tty_widgets[i].bg = tty_colors[i]
            tty_widgets[i].shape_border_color = beautiful.fg_normal
        end
    end
end

-- Connect the update_tty_widgets function to the startup signal to update the widget on startup
awesome.connect_signal("startup", function()
    update_tty_widgets()
end)

-- Connect the update_tty_widgets function to the tag::history::update signal to update the widget when the current TTY changes
tag.connect_signal("history::update", function()
    update_tty_widgets()
end)

-- Create a wibox to contain the TTY session circles
local tty_wibox = wibox({
    visible = true,
    ontop = true,
    type = "dock",
    width = 30,
    height = 150,
    bg = "#00000000",
})

-- Create a layout to contain the TTY session circles
local layout = wibox.layout.fixed.vertical()
for i = 1, num_tty_sessions do
    if i == 1 then
        layout:add(wibox.widget({
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 2 },
            {
                widget = wibox.container.background,
                shape = gears.shape.circle,
                forced_width = 26,
                forced_height = 26,
                border_width = 1,
                border_color = beautiful.fg_normal,
                tty_widgets[i],
            }
        }))
    elseif i == current_tty then
        layout:add(wibox.widget({
            widget = wibox.container.margin,
            margins = { top = 2, bottom = 5 },
            {
                widget = wibox.container.background,
                shape = gears.shape.circle,
                forced_width = 26,
                forced_height = 26,
                border_width = 3,
                border_color = beautiful.fg_normal,
                tty_widgets[i],
            }
        }))
    else
        layout:add(wibox.widget({
            widget = wibox.container.margin,
            margins = 2,
            {
                widget = wibox.container.background,
                shape = gears.shape.circle,
                forced_width = 26,
                forced_height = 26,
                border_width = 1,
                border_color = beautiful.fg_normal,
                tty_widgets[i],
            }
        }))
    end
end

-- Set the layout of the wibox to the TTY session circles layout
tty_wibox:setup {
    layout = wibox.layout.align.horizontal,
    {
        widget = wibox.container.margin,
        left = 2,
        right = 2,
        layout = wibox.layout.fixed.horizontal,
        layout,
    }
}

return tty_wibox








-- MATH EXAMPLES

local math = require("math")

local colors = {"#FF2E2A", "#2ECC71", "#3498DB", "#9B59B6", "#F1C40F"}

local function random_color()
    return colors[math.random(1, #colors)]
end

-- Create a wibox
local my_wibox = wibox({
    visible = false,
    ontop = true,
    type = "normal",
    width = 50,
    height = 50,
    bg = random_color(),
    shape = gears.shape.rounded_rect,
})

my_wibox:setup {
    layout = wibox.layout.align.horizontal,
    my_text_widget,
}

local function outside_position(screen)
    local x_choices = {-my_wibox.width, screen.geometry.width}
    local y_choices = {-my_wibox.height, screen.geometry.height}

    return x_choices[math.random(1, 2)], y_choices[math.random(1, 2)]
end

local function inside_position(screen)
    return math.random(0, screen.geometry.width - my_wibox.width),
           math.random(0, screen.geometry.height - my_wibox.height)
end

local function move_to_position(x, y)
    my_wibox.x = x
    my_wibox.y = y
end

local function show_wibox()
    my_wibox.visible = true
end

local function hide_wibox()
    my_wibox.visible = false
end

local function update_bg_color()
    my_wibox.bg = random_color()
end

local function move_to_random_outside_position(screen)
    local x, y = outside_position(screen)
    move_to_position(x, y)
end

local function move_to_random_inside_position(screen)
    local x, y = inside_position(screen)
    move_to_position(x, y)
end

local function hide_and_move_outside()
    hide_wibox()
    move_to_random_outside_position(awful.screen.focused())
    update_bg_color()
end

local function show_and_move_inside()
    show_wibox()
    move_to_random_inside_position(awful.screen.focused())
    update_bg_color()
end

my_wibox:connect_signal("mouse::enter", function()
    gears.timer.start_new(0.5, function()
        hide_and_move_outside()
        gears.timer.start_new(0.5, function()
            show_and_move_inside()
        end)
    end)
end)

move_to_random_inside_position(awful.screen.focused())
show_wibox()









-- GROWING BAR

local island_height = 40
local island_y = 0

local island = wibox({
    width = 1920,
    height = 1,
    x = 0,
    y = island_y + island_height - 1,
    ontop = true,
    bg = "#101213",
    visible = true,
})

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 2 then
        island.height = island_height
        island.y = island_y
    else
        island.height = 1
        island.y = island_y + island_height - 1
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()

















--  ISLAND BAR MINIMAL

local island = wibox({
    width = 1920,
    height = 1,
    x = 0,
    y = 39,
    ontop = true,
    bg = "#101213",
    visible = true,
})

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 2 then
        island.height = 40
    else
        island.height = 1
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()








--NOTIFICATION SYSTEM

-- RED BAIT


-- Create a wibox
local my_wibox = wibox({
    visible = false,
    ontop = true,
    type = "normal",
    width = 310,
    height = 500,
    bg = "#FF2E2A",
    shape = gears.shape.rounded_rect,
})

my_wibox:setup {
    layout = wibox.layout.align.horizontal,
    my_text_widget,
}

-- Function to move the wibox to the center of the screen
local function move_to_center(screen)
    my_wibox.x = 960
    my_wibox.y = 1000
end

-- Function to move the wibox outside the screen
local function move_outside(screen)
    my_wibox.x = 960
    my_wibox.y = 2200
end

-- Function to spawn the wibox outside the screen and then move it to the center
local function spawn_and_move_wibox()
    -- Spawn the wibox outside of the screen
    move_outside(awful.screen.focused())

    -- Make the wibox visible
    my_wibox.visible = true

    -- Animate the wibox moving to the center of the screen
    gears.timer.start_new(0.5, function()
        move_to_center(awful.screen.focused())
    end)
end

-- Function to animate the wibox smoothly
local function animate_wibox(target_y)
    local start_y = my_wibox.y
    local duration = 0.5
    local progress = 0

    gears.timer {
        timeout = 0.01,
        autostart = true,
        single_shot = false,
        callback = function(timer)
            progress = progress + 0.01 / duration
            if progress > 1 then
                progress = 1
                timer:stop()
            end

            local new_y = start_y + (target_y - start_y) * progress
            my_wibox.y = new_y
        end
    }
end

-- Detect when the cursor is inside the wibox
my_wibox:connect_signal("mouse::enter", function()
    animate_wibox(1000)
end)

-- Detect when the cursor is outside the wibox
my_wibox:connect_signal("mouse::leave", function()
    animate_wibox(2200)
end)

spawn_and_move_wibox()




-- PACMAN

-- ANIMATED PACMAN
local function draw_pacman(cr, angle)
    local radius = 12
    cr:arc(50, 50, radius, angle, 2 * math.pi - angle)
    cr:line_to(50, 50)
    cr:close_path()
    cr:set_source_rgb(1, 1, 0)
    cr:fill()
end

local pacman_widget = wibox.widget {
    fit = function(_, width, height)
        return width, height
    end,
    draw = function(_, _, cr)
        draw_pacman(cr, 0.2)
    end
}

local pacman_wibox = wibox {
    ontop = true,
    visible = true,
    x = 1400,
    y = -30,
    width = 100,
    height = 100,
    bg = "#00000000",
    widget = pacman_widget
}

local pacman_open = false
local pacman_animation_timer = gears.timer {
    timeout = 0.25,
    call_now = true,
    autostart = true,
    callback = function()
        pacman_open = not pacman_open
        pacman_widget.draw = function(_, _, cr)
            if pacman_open then
                draw_pacman(cr, 0)
            else
                draw_pacman(cr, 0.6) -- HOW MUCH IT HOPEN THE MOUTH
            end
        end
        pacman_widget:emit_signal("widget::redraw_needed")
    end
}









-- SPINNERS
local w = 100 -- larghezza del wibox
local h = 100 -- altezza del wibox

-- Creiamo il wibox con le impostazioni desiderate
local mywibox = wibox({
    visible = true,
    ontop = true,
    type = "dock",
    width = w,
    height = h,
    x = 0,
    y = 0,
    bg = "#33C748"
})

-- Funzione per animare il wibox sulla base di una nuova posizione
local function move_wibox(new_x, new_y)
    -- Tempo totale dell'animazione in secondi
    local animation_time = 0.5
    -- Numero di fotogrammi al secondo
    local fps = 60
    -- Numero di fotogrammi totali per l'animazione
    local total_frames = animation_time * fps
    -- Numero di pixel da spostare ad ogni fotogramma
    local delta_x = (new_x - mywibox.x) / total_frames
    local delta_y = (new_y - mywibox.y) / total_frames

    -- Funzione per aggiornare la posizione del wibox ad ogni fotogramma
    local function update_wibox()
        if total_frames > 0 then
            mywibox.x = mywibox.x + delta_x
            mywibox.y = mywibox.y + delta_y
            total_frames = total_frames - 1
            -- Richiama la funzione per aggiornare la posizione del wibox al prossimo fotogramma
            gears.timer.start_new(1/fps, update_wibox)
        end
    end

    -- Avvia la funzione di aggiornamento
    update_wibox()
end

-- Utilizziamo il bottone del mouse per spostare il wibox ad una nuova posizione
mywibox:buttons(gears.table.join(
    awful.button({}, 1, function()
        -- Genera una nuova posizione casuale all'interno dello schermo
        local new_x = math.random(screen[1].geometry.width - w)
        local new_y = math.random(screen[1].geometry.height - h)
        -- Avvia l'animazione del wibox alla nuova posizione
        move_wibox(new_x, new_y)
    end)
))



-- POSTBOX





local postbox = wibox({
    width = 60,
    height = 60,
    x = 400,
    y = -60,
    ontop = true,
    -- bg = "#00000000",
    bg = "#FC5753",
    visible = true,
})

backbox:connect_signal("mouse::enter", function()
    awful.util.spawn("xdotool key alt+Left")
end)

local function update_wibox_visibility()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag

    if tag and tag.index == 2 then
        portbox.y = 5
    else
        postbox.y = -29
    end
end

awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
update_wibox_visibility()







-- local termbox = wibox({
--     width = 16,
--     height = 16,
--     x = 1600,
--     y = -40,
--     ontop = true,
--     bg = "#FC5753",
--     visible = true,
-- })



-- termbox:buttons(awful.util.table.join(
--     awful.button({ }, 1, function ()
--         awful.util.spawn("xdotool key Super+h Super+h Super+h Super+h Super+h Super+Shift+l")
--    end)
-- ))



-- local function update_wibox_visibility()
--     local screen = awful.screen.focused()
--     local tag = screen.selected_tag

--     if tag and (tag.index == 3 or tag.index == 4 or tag.index == 5 or tag.index == 6) then
--         termbox.y = 5
--     else
--         termbox.y = -29
--     end
-- end

-- awful.tag.attached_connect_signal(nil, "property::selected", update_wibox_visibility)
-- update_wibox_visibility()
