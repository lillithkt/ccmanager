local tArgs = { ... }

local function help()
  print("Usage: reboot <node>")
  print("Reboot a node")
end

if not tArgs[1] then
  help()
  return
end

if tArgs[1] == "completion" then
  local nodes = textutils.unserializeJSON(lvn.net.get("/api/admin/nodes"))
  
  -- nodes: array of {name: string, id: string}
  -- allow param 1 to be a node name or id
  
  local completion = require("cc.shell.completion")

  -- add the node name and id to the possibleNodes list
  local possibleNodes = {}
  
  for i, node in ipairs(nodes) do
    table.insert(possibleNodes, node.name)
    table.insert(possibleNodes, tostring(node.id))
  end

  local complete = completion.build({ completion.choice, possibleNodes})

  shell.setCompletionFunction(shell.getRunningProgram(), complete)

  return
end


local res = lvn.net.post("/api/admin/nodes/" .. tArgs[1] .. "/reboot", "")

if not res then
  print("Reboot Failed")
  return
end

print("Rebooted!")