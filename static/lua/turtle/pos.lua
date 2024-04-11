local pos = {
  facing = "north"
}

local directions = {
  north = 1,
  east = 2,
  south = 3,
  west = 4
}
local directionsIndexed = {
  "north",
  "east",
  "south",
  "west"
}

pos.detectDirection = function()
  print("Detecting direction")
  local x, y, z = gps.locate()
  if turtle.detect() then
    turtle.dig()
  end
  turtle.forward()
  local newX, newY, newZ = gps.locate()

  if newX > x then
    facing = "east"
  elseif newX < x then
    facing = "west"
  elseif newZ > z then
    facing = "south"
  elseif newZ < z then
    facing = "north"
  end

  pos.facing = facing

  print("Facing " .. facing)

  return facing
end

pos.turnTo = function(direction)
  local current = directions[pos.facing]
  local target = directions[direction]

  while current ~= target do
    if current < target then
      turtle.turnRight()
      current = current + 1
    else
      turtle.turnLeft()
      current = current - 1
    end
  end

  pos.facing = directionsIndexed[target]
end

pos.turnLeft = function()
  local current = directions[pos.facing]
  local target = current - 1

  if target < 1 then
    target = 4
  end

  pos.facing = directionsIndexed[target]
  
  turtle.turnLeft() 
end

pos.turnRight = function()
  local current = directions[pos.facing]
  local target = current + 1

  if target > 4 then
    target = 1
  end

  pos.facing = directionsIndexed[target]

  turtle.turnRight()
end

return pos