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

local setMode = function() end

sharedWs.registerPacketHandler("turtleMode", function(data)
  setMode(data.mode, data.args)
end)

local function setSetMode(func)
  setMode = func
end

return setSetMode