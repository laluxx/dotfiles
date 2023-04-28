local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")
local helpers = require("helpers")









-- random rules, ai generated
-- local awful = require("awful")
-- local beautiful = require("beautiful")
-- local ruled = require("ruled")
-- local helpers = require("helpers")

-- --- Get screen geometry
-- local screen_width = awful.screen.focused().geometry.width
-- local screen_height = awful.screen.focused().geometry.height

-- ruled.client.connect_signal("request::rules", function()
--     --- Global
--     ruled.client.append_rule({
--         id = "global",
--         rule = {},
--         properties = {
--             raise = true,
--             size_hints_honor = false,
--             honor_workarea = true,
--             honor_padding = true,
--             -- screen = awful.screen.preferred,
--             screen = awful.screen.focused,
--             focus = awful.client.focus.filter,
--             titlebars_enabled = beautiful.titlebar_enabled,
--             placement = awful.placement.no_overlap + awful.placement.no_offscreen,
--         },
--     })

--     --- Tasklist order
--     ruled.client.append_rule({
--         id = "tasklist_order",
--         rule = {},
--         properties = {},
--         callback = awful.client.setslave,
--     })

--     --- Titlebar rules
--     ruled.client.append_rule({
--         id = "titlebars",
--         rule_any = {
--             class = {
--                 "Spotify",
--                 "Org.gnome.Nautilus",
--                 "Peek",
--             },
--         },
--         properties = {
--             titlebars_enabled = false,
--         },
--     })

--     --- Float
--     ruled.client.append_rule({
--         id = "floating",
--         rule_any = {
--             instance = {
--                 "Devtools", --- Firefox devtools
--             },
--             class = {
--                 "Lxappearance",
--                 "Nm-connection-editor",
--             },
--             name = {
--                 "Event Tester", -- xev
--             },
--             role = {
--                 "AlarmWindow",
--                 "pop-up",
--                 "GtkFileChooserDialog",
--                 "conversation",
--             },
--             type = {
--                 "dialog",
--             },
--         },
--         properties = { floating = true, placement = helpers.client.centered_client_placement },
--     })

--     --- Centered
--     ruled.client.append_rule({
--         id = "centered",
--         rule_any = {
--             type = {
--                 "dialog",
--             },
--             class = {
--                 --- "discord",
--             },
--             role = {
--                 "GtkFileChooserDialog",
--                 "conversation",
--             },
--         },
--         properties = { placement = helpers.client.centered_client_placement },
--     })

--     --- Music clients (usually a terminal running ncmpcpp)
--     ruled.client.append_rule({
--         rule_any = {
--             class = {
--                 "music",
--             },
--             instance = {
--                 "music",
--             },
--         },
--         properties = {
--             floating = true,
--             width = screen_width * 0.40,
--             height = screen_height * 0.42,
--             placement = helpers.client.centered_client_placement,
--         },
--     })

--     --- Image viewers
--     ruled.client.append_rule({
--         rule_any = {
--             class = {
--                 "feh",
--                 "imv",
--             },
--         },
--         properties = {
--             floating = true,
--             width = screen_width * 0.7,
--             height = screen_height * 0.75,
--         },
--         callback = function(c)
--             awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
--         end,
--     })
-- end) -- Add this line to close the function

--- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

ruled.client.connect_signal("request::rules", function()
	--- Global
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			raise = true,
			size_hints_honor = false,
			honor_workarea = true,
			honor_padding = true,
			-- screen = awful.screen.preferred,
			screen = awful.screen.focused,
			focus = awful.client.focus.filter,
			titlebars_enabled = beautiful.titlebar_enabled,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})

	--- Tasklist order
	ruled.client.append_rule({
		id = "tasklist_order",
		rule = {},
		properties = {},
		callback = awful.client.setslave,
	})

	--- Titlebar rules
	ruled.client.append_rule({
		id = "titlebars",
		rule_any = {
			class = {
				"Spotify",
				"Org.gnome.Nautilus",
				"Peek",
			},
		},
		properties = {
			titlebars_enabled = false,
		},
	})

	--- Float
	ruled.client.append_rule({
		id = "floating",
		rule_any = {
			instance = {
				"Devtools", --- Firefox devtools
			},
			class = {
				"Lxappearance",
				"Nm-connection-editor",
			},
			name = {
				"Event Tester", -- xev
			},
			role = {
				"AlarmWindow",
				"pop-up",
				"GtkFileChooserDialog",
				"conversation",
			},
			type = {
				"dialog",
			},
		},
		properties = { floating = true, placement = helpers.client.centered_client_placement },
	})

	--- Centered
	ruled.client.append_rule({
		id = "centered",
		rule_any = {
			type = {
				"dialog",
			},
			class = {
				--- "discord",
			},
			role = {
				"GtkFileChooserDialog",
				"conversation",
			},
		},
		properties = { placement = helpers.client.centered_client_placement },
	})







	--- Music clients (usually a terminal running ncmpcpp)
	ruled.client.append_rule({
		rule_any = {
			class = {
				"music",
			},
			instance = {
				"music",
			},
		},
		properties = {
			floating = true,
			width = screen_width * 0.40,
			height = screen_height * 0.42,
			placement = helpers.client.centered_client_placement,
		},
})

	--- Image viewers
	ruled.client.append_rule({
		rule_any = {
			class = {
				"feh",
				"imv",
			},
		},
		properties = {
			floating = true,
			width = screen_width * 0.7,
			height = screen_height * 0.75,
		},
		callback = function(c)
			awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
		end,
	})






-- XOS

-- TITLE-BAR

    -- Remove titlebar from Emacs
    ruled.client.append_rule {
        id = "doom_no_titlebar",
        rule = { class = "Emacs" },
        properties = {
            titlebars_enabled = false
        }
    }


    -- Remove titlebar from firefox
    ruled.client.append_rule {
        id = "firefox_no_titlebar",
        rule = { class = "firefox" },
        properties = {
            titlebars_enabled = false
        }
    }



    -- Remove titlebar from discord
    ruled.client.append_rule {
        id = "firefox_no_titlebar",
        rule = { class = "discord" },
        properties = {
            titlebars_enabled = false
        }
    }

    -- Remove titlebar from XPLORER
    ruled.client.append_rule {
        id = "doom_no_titlebar",
        rule = { class = "Xplorer" },
        properties = {
            titlebars_enabled = false
        }
    }


-- FIREFOX-ISLAND-MODE
-- ruled.client.append_rule({
--     id = "firefox_urgent_floating",
--     rule = { class = "firefox" },
--     properties = {
--         floating = true,
--         placement = awful.placement.centered,
--         x = -2,
--         y = 75,
--         width = 1922,
--         height = 1005,
--         urgent = true,
--     },
-- })


-- ANDROID-STUDIO-ISLAND-MODE
ruled.client.append_rule({
    id = "firefox_urgent_floating",
    rule = { class = "" },
    properties = {
        floating = true,
        placement = awful.placement.centered,
        x = -2,
        y = 75,
        width = 1922,
        height = 1005,
        urgent = true,
    },
})


-- DISCORD-ISLAND-MODE
-- ruled.client.append_rule({
--     id = "discord_urgent_floating",
--     rule = { class = "discord" },
--     properties = {
--         floating = true,
--         placement = awful.placement.centered,
--         x = -2,
--         y = 75,
--         width = 1922,
--         height = 1005,
--         urgent = true,
--     },
-- })














    -- Remove titlebar from kitty
    ruled.client.append_rule {
        id = "kitty_no_titlebar",
        rule = { class = "kitty" },
        properties = {
            titlebars_enabled = false
        }
    }



    -- Remove titlebar from st
    ruled.client.append_rule {
        id = "st_no_titlebar",
        rule = { class = "st" },
        properties = {
            titlebars_enabled = false
        }
    }


-- MAXIMIZED

-- --- Maximized firefox
-- ruled.client.append_rule({
--     id = "firefox_maximized",
--     rule = { class = "firefox" },
--     properties = { maximized = true }
-- })

--- Maximized Emacs
ruled.client.append_rule({
    id = "emacs_maximized",
    rule = { class = "Emacs" },
    properties = { maximized = true }
})



--FLOATING

--- Floating PCManFM
ruled.client.append_rule({
    id = "nemo_floating",
    rule = { class = "Nemo" },
    properties = {
        floating = true,
        width = 850,
        height = 671,
        placement = helpers.client.centered_client_placement,
    },
})



-- XOS-TERM
--- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

function resize_floating_kitty_xonsh()
    local tag_name = awful.screen.focused().selected_tag.name
    local client_list = client.get()

    for _, c in ipairs(client_list) do
        if c.class == "floating-kitty-xonsh" and c.sticky and c.screen == awful.screen.focused() then
            if tag_name == "1" then
                c:geometry({ x = 1120, y = 1080, width = 800, height = 600 })
            elseif tag_name == "2" then
                c:geometry({ x = 501, y = 1100, width = 848, height = 626 })
            elseif tag_name == "3" then
                c:geometry({ x = -881, y = 35, width = 605, height = 1045 })
                -- c:geometry({ x = -681, y = 42, width = 508, height = 1038 })
            elseif tag_name == "4" then
                c:geometry({ x = -4, y = 2000, width = 508, height = 1038 })
            -- Add more cases for different tags here
            end
        end
    end
end




-- Connect the signal to each screen
awful.screen.connect_for_each_screen(function(s)
    s:connect_signal("tag::history::update", resize_floating_kitty_xonsh)
end)

ruled.client.connect_signal("request::rules", function()
end)

---------------------------------------------------------------------------------------------------------------------------------------------------


-- SINGLE APPLICATION CONFIGUARTION

awful.rules.rules = {
    -- ...
    {
        rule = { class = "Nitrogen" },
        properties = {
            titlebars_enabled = false,
            floating = true,
            width = 504,
            height = 558,
            x = 1449,
            y = 574,
        }
    },
    -- ...
}




awful.rules.rules = {
    -- ...
    {
        rule = { class = "Pavucontrol" },
        properties = {
            titlebars_enabled = false,
            floating = true,
            width = 549,
            height = 459,
            x = 1362,
            y = 59,
        }
    },
    -- ...
}





-- Add borders to clients on tag 2 and all tags that come after tag 2
awful.rules.rules[#awful.rules.rules + 1] = {
    id = "borders_tag2_and_after",
    rule_any = {
        tag = {
            [2] = true, -- Add border to clients on tag 2
            [">2"] = true, -- Add border to clients on all tags that come after tag 2
        }
    },
    properties = {
        border_width = beautiful.border_width,
    }
}





















-- ruled.client.append_rule({
--     id = "kitty_sound_transparent_invisible",
--     rule = { class = "kitty_sound" },
--     properties = {},
--     callback = function(c)
--         c.opacity = 0
--         c.hidden = true
--     end,
-- })

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TERM SWALLOW TODO


awful.rules.rules = {
    {
        rule_any = {
            class = {
                "Firefox",
            },
        },
        properties = {
            border_color = "#f44336",
        },
    },
    {
        rule_any = {
            class = {
                "URxvt",
            },
        },
        properties = {
            border_color = "#2196f3",
        },
    },
    {
        rule_any = {
            class = {
                "Steam",
                "Spotify",
            },
        },
        properties = {
            border_color = "#4caf50",
        },
    },
    {
        rule_any = {
            class = {
                "Thunar",
                "discord",
            },
        },
        properties = {
            border_color = "#9c27b0",
        },
    },
}












-- DOCUMENTATION
-- XOS RULES EXAMPLES

-- EXAMPLE HOW TO SET THE POSITION AND SIZE OF A WINDOW BASED ON THE TAG
-- tag.connect_signal("property::selected", function(t)
--     local clients = t:clients()
--     for _, c in ipairs(clients) do
--         if c.class == "floating-kitty-xonsh" then
--             if t.index == 2 then
--                 -- Set the desired size and position for the second tag
--                 c:geometry({
--                     x = 100, -- Replace with desired x position
--                     y = 100, -- Replace with desired y position
--                     width = 800, -- Replace with desired width
--                     height = 600, -- Replace with desired height
--                 })
--             else
--                 -- Set the default size and position for other tags
--                 c:geometry({
--                     x = 50, -- Replace with default x position
--                     y = 50, -- Replace with default y position
--                     width = 500, -- Replace with default width
--                     height = 400, -- Replace with default height
--                 })
--             end
--         end
--     end
-- end)








end)
