hs.loadSpoon("FnMate")
hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({})

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert.show("Config loaded")

hs.loadSpoon("AClock")

local function showClock()
    spoon.AClock.textFont = "PingFang Ultralight"
    spoon.AClock.format = "%H:%M:%S"
    spoon.AClock.textColor = {hex="#FFFFFF"}
    spoon.AClock.width = 1280
    spoon.AClock.height = 640
    spoon.AClock.textSize = 256
    spoon.AClock.showDuration = 9, -- seconds
    spoon.AClock:toggleShow()
end

hs.hotkey.bind({"alt"}, "T", nil, showClock)

