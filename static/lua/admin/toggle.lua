local tArgs = { ... }

local possibleDirections = {"up", "down", "left", "right", "front", "back"}

local function help()
  print("Usage: toggle <node> <direction>")
  print("Toggles the state of a node")
end

if not tArgs[1] then
  help()
  return
end

if tArgs[1] == "completion" then
  local nodes = textutils.unserializeJSON(lvn.net.get("/api/admin/nodes"))

  print(nodes)

  -- nodes: array of {name: string, id: string}
  -- allow param 1 to be a node name or id
  -- param 2 is a direction
  
  local completion = require("cc.shell.completion")

  -- add the node name and id to the possibleNodes list
  local possibleNodes = {}
  
  for i, node in ipairs(nodes) do
    print(node.name)
    table.insert(possibleNodes, node.name)
    table.insert(possibleNodes, tostring(node.id))
  end

  print(textutils.serialiseJSON(possibleNodes))

  local complete = completion.build({ completion.choice, possibleNodes}, { completion.choice, possibleDirections })

  shell.setCompletionFunction(shell.getRunningProgram(), complete)

  return
end

if not tArgs[2] then
  help()
  return
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