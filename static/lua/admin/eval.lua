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

completion.setHelpText("Usage: eval <node> <code>")
completion.setHelpText("Run code on a node")

completion.setRequiredArgs(2)

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end

local node = tArgs[1]

-- Code is everything after the node name
local code = table.concat(tArgs, " ", 2)


local res = lvn.net.post("/api/admin/nodes/" .. node .. "/eval", code)

if not res then
  print("Code Failed")
  return
end

print(res)