local tArgs = { ... }

if tArgs[1] == "loop" then
  sharedRednet.open()

  local success, e = pcall(sharedRednet.loop)

  print("Rednet crashed, rebooting...", e)

  sleep(5)

  os.reboot()
end

function open()
  peripheral.find("modem", function(side)
    print("Opening rednet on " .. side)
    rednet.open(side)
  end)
  rednet.host("ccmanager", os.getComputerLabel())
  print("Hosting protocol ccmanager as " .. os.getComputerLabel())
end



function send(target, packetType, data)
  if not data then
    data = packetType
    packetType = target
    target = true
  end

  if type(target) == "string" then
    target = rednet.lookup("ccmanager", target)
  end

  local packet = textutils.serialiseJSON({ type = packetType, data = data, broadcast = type(target) == "boolean"})

  if lvn.config.get("debug") then
    print("Sending rednet: ", packet)
  end

  if type(target) == "boolean" then
    rednet.broadcast(packet, "ccmanager")
  else
    rednet.send(target, packet, "ccmanager")
  end
end

local packetHandlers = {}

function registerPacketHandler(type, func)
  packetHandlers[type] = func
end

function unregisterPacketHandler(type)
  packetHandlers[type] = nil
end

local getDimensionCallbacks = {}
registerPacketHandler("getDimensionResponse", function(_, __, data)
  if getDimensionCallbacks[data.nonce] then
    getDimensionCallbacks[data.nonce](data.dimension)
    getDimensionCallbacks[data.nonce] = nil
  end
end)

function handleMessage()
  local id, packetString, proto = rednet.receive("ccmanager")

  if proto ~= "ccmanager" then
    return
  end
  local packet = textutils.unserialiseJSON(packetString)

  if lvn.config.get("debug") then
    print("Received: ", packetString)
  end

  if packetHandlers[packet.type] then
    pcall(packetHandlers[packet.type], id, packet.broadcast, packet.data)
  else
    printError("Unknown packet type: " .. packet.type)
  end
end

function loop()
  while true do
    handleMessage()
  end
end



commands = {
  getDimension = function()
    local nonce = os.epoch()
    local dimension = nil
    getDimensionCallbacks[nonce] = function(d)
      dimension = d
    end
    send("getDimension", nonce)
    while not dimension do
      sleep(0)
    end
    return dimension
  end
}