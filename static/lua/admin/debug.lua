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

completion.setHelpText("Usage: debug <node>")
completion.setHelpText("Log a node's packets")

completion.setRequiredArgs(1)

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end

local node = lvn.net.get("/api/admin/nodes/" .. tArgs[1])

if not node then
  print("Node not found")
  return
end

local term = require("/run/term")

local origDebug = node.debug

if not origDebug then
  lvn.net.post("/api/admin/nodes/" .. tArgs[1] .. "/debug", "true")
end

sharedWs.registerPacketHandler("adminNodePacket", function(packet)
  if packet.node.id == tArgs[1] or packet.node.name == tArgs[1] then
    if packet.packet.type == "heartbeat" then
      return
    end
    local str = (packet.toServer and "Client: " or "Server: ") .. textutils.serializeJSON(packet.packet)
    term.write(str)

    local monitor = peripheral.find("monitor")
    if monitor then
      monitor.write(str)
      monitor.setCursorPos(1, monitor.getCursorPos() + 1)
    end
  end
end)

print("Listening for packets on node " .. tArgs[1])

local function onTerminate()
  os.pullEventRaw("terminate")
  sharedWs.unregisterPacketHandler("adminNodePacket")
  if not origDebug then
    lvn.net.post("/api/admin/nodes/" .. tArgs[1] .. "/debug", "false")
  end
end

parallel.waitForAny(onTerminate)