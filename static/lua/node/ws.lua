local ws = {}

function ws.sendRaw(string)
  if lvn.config.get("debug.ws") then
    print("Sending: ", string)
  end
  ws.ws.send(string)
end

function ws.send(type, data)
  ws.sendRaw(textutils.serialiseJSON({ type = type, data = data }))
end

local packetHandlers = {
  register = function(data)
    if data.success then
      print("Registered successfully")
    else
      printError("Registration failed: ", data.message)
      sleep(5)
      os.reboot()
    end
  end,
  heartbeat = function(data)
    ws.send("heartbeat", data)
  end,

  eval = function(data)
    local func, err = loadstring(data.code)
    if not func then
      ws.send("eval", {
        nonce = data.nonce,
        success = false,
        output = err
      })
    else
      local result = { pcall(func) }
      if not result[1] then
        ws.send("eval", {
          nonce = data.nonce,
          success = false,
          output = result[2]
        })
      else
        table.remove(result, 1)
        ws.send("eval", {
          nonce = data.nonce,
          success = true,
          output = result[1]
        })
      end
    end
  end,
}




function ws.handleMessage()
  local event, connUrl, packetString = os.pullEvent("websocket_message")

  if connUrl == lvn.urls.ws then
    if lvn.config.get("debug.ws") then
      print("Received: ", packetString)
    end
    local packet = textutils.unserialiseJSON(packetString)

    if packetHandlers[packet.type] then
      packetHandlers[packet.type](packet.data)
    else
      printError("Unknown packet type: " .. packet.type)
    end
  end
end

function ws.handleClose()
  local event, connUrl, reason, code = os.pullEvent("websocket_closed")

  if connUrl == lvn.urls.ws then
    print("Connection closed: ", code, reason)
    local speaker = peripheral.find("speaker")
    if speaker then
      speaker.playSound("minecraft:block.bell.use")
    end
    sleep(5)
    os.reboot()
  end
end

function ws.handleError()
  local event, connUrl, reason, code = os.pullEvent("websocket_error")

  if connUrl == lvn.urls.ws then
    printError("Connection error: ", code, reason)
    sleep(5)
    os.reboot()
  end
end





function ws.connect() 
  local socket, err = http.websocket(lvn.urls.ws)
  if not socket then
    printError("Connection Error: ", err)
    sleep(5)
    os.reboot()
  else
    ws.ws = socket
    print('Connection established')
    ws.send("register", {
      type = lvn.config.get("boot.type"),
      id = os.getComputerID(),
      name = os.getComputerLabel(),
      password = lvn.config.get("node.password"),
      debug = lvn.config.get("debug.ws")
    })
    return true
  end
end

function ws.disconnect()
  ws.ws.close()
end

function ws.loopWs()
  -- while true do 
  --   parallel.waitForAny(ws.handleMessage, ws.handleClose, ws.handleError)
  -- end
end

return ws