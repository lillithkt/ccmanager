local tArgs = { ... }

local function help()
  print("Usage: a <node> <direction>")
  print("Toggles the state of a node")
end

if not tArgs[1] then
  help()
  return
end

if tArgs[1] == "completion" then
  local completion = require("cc.shell.completion")

  local complete = completion.build({ completion.choice, possibleNodes}, { completion.choice, possibleDirections })

  shell.setCompletionFunction(shell.getRunningProgram(), complete)

  return
end
