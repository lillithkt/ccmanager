local ws = require("/run/sharedWs")

ws.registerPacketHandler("toggle", function(data)
  redstone.setOutput(data, not redstone.getOutput(data))
end)

ws.registerPacketHandler("turnOn", function(data)
  redstone.setOutput(data, true)
end)

ws.registerPacketHandler("turnOff", function(data)
  redstone.setOutput(data, false)
end)

ws.registerPacketHandler("move", function(data)
  if data == "up" then
    turtle.up()
  elseif data == "down" then
    turtle.down()
  elseif data == "left" then
    turtle.turnLeft()
  elseif data == "right" then
    turtle.turnRight()
  elseif data == "forward" then
    turtle.forward()
  elseif data == "backward" then
    turtle.back()
  end
end)

ws.registerPacketHandler("dig", function(data)
  if data == "up" then
    turtle.digUp()
  elseif data == "down" then
    turtle.digDown()
  elseif data == "forward" then
    turtle.dig()
  end
end)

ws.registerPacketHandler("refuel", function()
  turtle.refuel()
end)

ws.registerPacketHandler("turtle", function(data)
  print("Received turtle command: " .. data)
  local func = turtle[data]
  if func then
    func()
  end
  
end)

return ws