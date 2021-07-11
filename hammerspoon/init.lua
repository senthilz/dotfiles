hs.logger.defaultLogLevel="info"

hyper       = {"cmd","alt","ctrl"}
ctrl_cmd    = {"cmd","ctrl"}
hs.hotkey.bindSpec({ hyper, "y"}, hs.toggleConsole)

hs.loadSpoon("SpoonInstall")

-- spoon.SpoonInstall.repos.ShiftIt = {
--    url = "https://github.com/peterklijn/hammerspoon-shiftit",
--    desc = "ShiftIt spoon repository",
--    branch = "master",
-- }


spoon.SpoonInstall:andUse("CircleClock")
spoon.SpoonInstall:andUse("ShiftIt")
spoon.SpoonInstall:andUse("ReloadConfiguration")

spoon.ShiftIt:bindHotkeys({
   right = {hyper, 'l' },
   left = {hyper, 'h' },
   up = {hyper, 'k' },
   down = {hyper, 'j' },
 })
