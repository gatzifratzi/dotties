--  Git Plugin  --
require("git"):setup()

--  full Border Plugin  --
require("full-border"):setup {
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
}

--  relative motions plugin --
require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true, enter_mode = "cache_or_first", only_motions = false })

--folder specific rules
require("folder-rules"):setup()

--show symlink status in statusbar
Status:children_add(function(self)
    local h = self._current.hovered
    if h and h.link_to then
        return " -> " .. tostring(h.link_to)
    else
        return ""
    end
end, 3300, Status.LEFT)

--show user groups
--Status:children_add(function()
--    local h = cx.active.current.hovered
--    if not h or ya.target_family() ~= "unix" then
--        return ""
--    end
--
--    return ui.Line {
--        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
--        ":",
--        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
--        " ",
--    }
--end, 500, Status.RIGHT)
