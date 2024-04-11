sharedWs.registerPacketHandler("toggle", function(data)
  redstone.setOutput(data, not redstone.getOutput(data))
end)

sharedWs.registerPacketHandler("turnOn", function(data)
  redstone.setOutput(data, true)
end)

sharedWs.registerPacketHandler("turnOff", function(data)
  redstone.setOutput(data, false)
end)

sharedWs.registerPacketHandler("move", function(data)
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

sharedWs.registerPacketHandler("dig", function(data)
  if data == "up" then
    turtle.digUp()
  elseif data == "down" then
    turtle.digDown()
  elseif data == "forward" then
    turtle.dig()
  end
end)

sharedWs.registerPacketHandler("refuel", function()
  turtle.refuel()
end)

sharedWs.registerPacketHandler("turtle", function(data)
  print("Received turtle command: " .. data)
  local func = turtle[data]
  if func then
    func()
  end
  
end)