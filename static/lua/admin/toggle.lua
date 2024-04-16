local completion = require('/lvn/core/completion')

local possibleDirections = {"up", "down", "left", "right", "front", "back"}

completion.setCompletionFunction(function()
  local ccCompletion = require("cc.shell.completion")

  local nodes = textutils.unserializeJSON(lvn.net.get("/api/admin/nodes"))
  
  -- nodes: array of {name: string, id: string}
  -- allow param 1 to be a node name or id
  -- add the node name and id to the possibleNodes list
  local possibleNodes = {}
  
  for i, node in ipairs(nodes) do
    table.insert(possibleNodes, node.name)
    table.insert(possibleNodes, tostring(node.id))
  end

  return ccCompletion.build({ ccCompletion.choice, possibleNodes}, { ccCompletion.choice, possibleDirections})
end)

completion.setHelpText("Usage: toggle <node> [side]")
completion.setHelpText("Toggles redstone output on a node")

completion.setRequiredArgs(1)

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end

if not tArgs[2] then
  tArgs[2] = "front"
end

local node = tArgs[1]
local direction = tArgs[2]

if possibleDirections[direction] ~= nil then
  print("Invalid direction. Must be one of: " .. table.concat(possibleDirections, ", "))
  return
end

local res = lvn.net.post("/api/admin/nodes/" .. node .. "/toggle", direction)

if not res then
  print("Failed to toggle node")
  return
end

print("Toggled node " .. node .. " " .. direction)