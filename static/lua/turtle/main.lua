print("Loading Turtle Library...")

local lastMode = "idle"

-- Add turtle specific ws packets
local setSetMode = require("/run/turtle/ws")
-- Load turtle modes

local mode = "idle"
local modeArgs = {}

local modes = {
  spin = require("/run/turtle/modes/spin"),

  idle = require("/run/turtle/modes/idle"),

  goto = require("/run/turtle/modes/goto"),

  mine = require("/run/turtle/modes/mine")
}

local function setMode(newMode, args)
  print("setMode", newMode)
  mode = newMode
  modeArgs = args
end

setSetMode(setMode)



function turtleLoop()
  local modeFunc = modes[mode]
  if lastMode ~= mode then
    print("Switched mode to " .. mode)
    modes[lastMode].teardown()

    lastMode = mode
    
    modeFunc.setup(modeArgs)
  end
  

  local out = modeFunc.loop()

  if out == "done" then
    setMode("idle", {})
  end

  sleep(0.5)
end

return turtleLoop