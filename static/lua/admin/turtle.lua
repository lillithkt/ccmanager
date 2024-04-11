local tArgs = { ... }


local function help()
  print("Usage: turtle <node> <mode | control>")
  print("Remotely control a turtle")
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
    if node.turtle then
      table.insert(possibleNodes, node.name)
      table.insert(possibleNodes, tostring(node.id))
    end
    
  end

  local complete = completion.build({ completion.choice, possibleNodes}, {
    completion.choice, {"mode", "control"}
  
  }, 
{
  completion.choice, {"dig", "idle"}
})

  shell.setCompletionFunction(shell.getRunningProgram(), complete)

  return
end

if not tArgs[2] then
  help()
  return
end

local nodeId = tArgs[1]

local nodesStr = lvn.net.get("/api/admin/nodes")

if not nodesStr then
  print("Connection Error")
  return
end

print(nodesStr)

local nodes = textutils.unserializeJSON(nodesStr)

local node

for i, newNode in ipairs(nodes) do
  if newNode.name == nodeId or newNode.id == nodeId then
    node = newNode
    break
  end
end

if not node then
  print("Node not found")
  return
end


local mode = tArgs[2]

if mode == "mode" then
  if not tArgs[3] then
    print("Usage: turtle <node> mode <mode>")
    return
  end

  local res = lvn.net.post("/api/admin/nodes/" .. node.id .. "/turtle/mode", tArgs[3])

  if not res then
    print("Failed to set mode")
    return
  end

  print("Set mode to " .. tArgs[3])
  return
end

if mode == "control" then
  print("Starting control")
  local ws = require("/run/ws")

  ws.connect()

  local function handleKey()

    while true do
      -- Read key
      local event, key = os.pullEvent("key")

      if key == keys.w then
        ws.send("move", {
          id = node.id,
          direction = "forward"
        })
      elseif key == keys.s then
        ws.send("move", {
          id = node.id,
          direction = "backward"
        })
      elseif key == keys.a then
        ws.send("move", {
          id = node.id,
          direction = "left"
        })
      elseif key == keys.d then
        ws.send("move", {
          id = node.id,
          direction = "right"
        })
      elseif key == keys.space then
        ws.send("move", {
          id = node.id,
          direction = "up"
        })
      elseif key == keys.leftShift then
        ws.send("move", {
          id = node.id,
          direction = "down"
        })
      elseif key == keys.e then
        ws.send("dig", {
          id = node.id,
          direction = "forward"
        })
      elseif key == keys.r then
        ws.send("refuel", node.id)
      end
    end
  end

  parallel.waitForAny(handleKey, ws.loopWs)
end

print(res)