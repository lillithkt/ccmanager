print("Loading Turtle Library...")

-- Add turtle specific ws packets
local setSetMode = require("/run/turtle/ws")
-- Load turtle modes

local mode = lvn.config.get("turtle.defaultMode", "idle")
local lastMode = mode
local modeArgs = lvn.config.get("turtle.defaultArgs", {})

local modes = {
  spin = require("/run/turtle/modes/spin"),

  idle = require("/run/turtle/modes/idle"),

  goto = require("/run/turtle/modes/goto"),

  mine = require("/run/turtle/modes/mine"),

  mobgrinder = require("/run/turtle/modes/mobgrinder"),
}

local function setMode(newMode, args)
  print("setMode", newMode)
  mode = newMode
  modeArgs = args
end

setSetMode(setMode)

local firstLoop = true

while true do
  if firstLoop then
    firstLoop = false
    modes[mode].setup(modeArgs)
  end
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