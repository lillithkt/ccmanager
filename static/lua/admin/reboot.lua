local completion = require('/lvn/core/completion')

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

  return ccCompletion.build({ ccCompletion.choice, possibleNodes})
end)

completion.setHelpText("Usage: reboot <node>")
completion.setHelpText("Reboot a node")

completion.setRequiredArgs(1)

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end


local res = lvn.net.post("/api/admin/nodes/" .. tArgs[1] .. "/reboot", "")

if not res then
  print("Reboot Failed")
  return
end

print("Rebooted!")