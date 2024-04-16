local completion = require('/lvn/core/completion')

completion.setCompletionFunction(function()
  local ccCompletion = require("cc.shell.completion")

  return ccCompletion.build({ ccCompletion.choice, { "abc" }})
end)

completion.setHelpText("Usage: ")

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end