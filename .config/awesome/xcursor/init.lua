-- Define the wibox
local mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = 50,
    bg = "#000000",
    opacity = 0.8,
    visible = true,
    ontop = true,
})

-- Add text to the wibox
mywibox:setup {
    widget = wibox.widget.textbox("Hover over me!"),
    align = "center",
    valign = "center",
    widget = wibox.container.place
}

-- Add hover effects
mywibox:connect_signal("mouse::enter", function()
    mywibox.opacity = 1.0
    mywibox.y = 0
end)

mywibox:connect_signal("mouse::leave", function()
    mywibox.opacity = 0.8
    mywibox.y = 20
end)
