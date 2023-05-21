awful.rules.rules = awful.util.table.join(
    awful.rules.rules,
    {
        { class = "Firefox",
          properties = { tag = awful.screen.focused().tags[1] }
        },
    }
)
