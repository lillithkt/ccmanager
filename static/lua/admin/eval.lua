local tArgs = { ... }


local function help()
  print("Usage: eval <node> <code>")
  print("Runs code on a node and returns it")
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
  
  local completion = require("cc.shell.completion")

  -- add the node name and id to the possibleNodes list
  local possibleNodes = {}
  
  for i, node in ipairs(nodes) do
    print(node.name)
    table.insert(possibleNodes, node.name)
    table.insert(possibleNodes, tostring(node.id))
  end

  print(textutils.serialiseJSON(possibleNodes))

  local complete = completion.build({ completion.choice, possibleNodes})

  shell.setCompletionFunction(shell.getRunningProgram(), complete)

  return
end

if not tArgs[2] then
  help()
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