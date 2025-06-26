--logik um show_hidden fuer manche dirs zu togglen
--ich gebs fuer heute auf das will nicht klappen
local function updateHiddenVisibility()
    local home_dir = os.getenv("HOME")
    local dotties_path = home_dir .. "/dotties"
    local cwd = cx.active.current.cwd
    if cwd:find(dotties_path, 1, true) == 1 then
        ya.emit("show", { "hidden toggle" })
    else
        ya.emit("show", { "hidden toggle" })
    end
end

-- download folder nach datum sortiert und dotties immer mit hidden files
local function setup()
    ps.sub("cd", function()
        -- download folder nach datum sortiert
        local cwd = cx.active.current.cwd
        if cwd:ends_with("Downloads") then
            ya.emit("sort", { "mtime", reverse = true, dir_first = false })
        else
            ya.emit("sort", { "alphabetical", reverse = false, dir_first = true })
        end
        -- dotties und subdirs zeigen immer hidden files
        --updateHiddenVisibility()
    end)
end

return { setup = setup }
