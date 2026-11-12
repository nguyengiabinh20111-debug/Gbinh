-- CHILLI X VENYX V10
-- Key system removed: launch the main menu directly.

local success, result = pcall(function()
    local source = game:HttpGet("https://gist.githubusercontent.com/thuyngudot42-svg/b343c9d9fa060b6deb1141b7851301f8/raw/3c92f5a61d76a6d18278160dbb8921e251ffd753/chilli-Venyxhub-ba-khi-909")
    local run = loadstring(source)
    assert(run, "Could not compile the main script")
    run()
end)

if not success then
    warn("Chilli X Venyx V10 failed to load: " .. tostring(result))
end
