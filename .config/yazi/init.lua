--  Git Plugin  --
require("git"):setup()

--  full Border Plugin  --
require("full-border"):setup {
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
}

--  relative motions plugin --
require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true, enter_mode = "cache_or_first", only_motions = false })
