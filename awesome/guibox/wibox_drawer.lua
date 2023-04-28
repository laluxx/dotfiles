local lgi = require('lgi')
local Gtk = lgi.require('Gtk', '3.0')
local Gdk = lgi.require('Gdk', '3.0')
local Wibox = require("wibox")

local app = Gtk.Application.new("org.awesomewm.WiboxDesigner", 0)

local function create_main_window()
    local window = Gtk.Window {
        title = "Wibox Designer",
        default_width = 800,
        default_height = 600,
        window_position = Gtk.WindowPosition.CENTER
    }

    local drawing_area = Gtk.DrawingArea {
        expand = true,
        halign = Gtk.Align.FILL,
        valign = Gtk.Align.FILL
    }

    local options_grid = Gtk.Grid {
        column_spacing = 10,
        row_spacing = 10,
        margin_start = 10,
        margin_end = 10,
        margin_top = 10,
        margin_bottom = 10
    }

    -- Add your options, sliders, and checkboxes here
    local roundness_label = Gtk.Label {
        label = "Roundness:"
    }

    local roundness_scale = Gtk.Scale {
        orientation = Gtk.Orientation.HORIZONTAL,
        adjustment = Gtk.Adjustment {
            lower = 0,
            upper = 50,
            step_increment = 1
        }
    }

    options_grid:attach(roundness_label, 0, 0, 1, 1)
    options_grid:attach(roundness_scale, 1, 0, 1, 1)

    local options_frame = Gtk.Frame {
        label = "Options",
        expand = false,
        halign = Gtk.Align.FILL,
        valign = Gtk.Align.FILL,
        child = options_grid
    }

    local main_pane = Gtk.Paned {
        orientation = Gtk.Orientation.HORIZONTAL,
        position = 400
    }

    main_pane:add1(drawing_area)
    main_pane:add2(options_frame)

    window:add(main_pane)

    window.on_destroy = function()
        app:leave()
    end

    return window
end

function app:on_activate()
    local window = create_main_window()
    window:set_application(self)
    window:present()
end

app:run({arg[0]})
