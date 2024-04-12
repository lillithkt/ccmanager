local pos = require("/run/turtle/pos")

local branchLength = 30



local function teardown()
end

local function isOre(data)
  return data.tags["forge:ores"] ~= nil
end

local function logOre(ore)
  local x, y, z = gps.locate()
  if isOre(ore) then
    lvn.chat.send("Found " .. ore.name .. " at " .. x .. ", " .. y + 1 .. ", " .. z)
    lvn.chat.waypoint(os.getComputerLabel() .. " Found " .. ore.name, "O", x, y + 1, z)
    return true
  end
end

local function isStone(block)
  return block.tags["forge:cobblestone"] ~= nil
  or block.tags["forge:stone"] ~= nil
  or block.tags["forge:gravel"] ~= nil
  or block.tags["minecraft:base_stone_overworld"] ~= nil
  or block.name == "minecraft:flint"
end

local function dropStone()
  for i = 1, 16 do
    local block = turtle.getItemDetail(i, true)
    if block and isStone(block) then
      turtle.select(i)
      turtle.drop()
    end
  end
end

local function branchLoop()
  local hasOre, ore = turtle.inspectUp()
  if hasOre and logOre(ore) then
    turtle.digUp()
  end
  local hasOre, ore = turtle.inspectDown()
  if hasOre and logOre(ore) then
    turtle.digDown()
  end
  
  for i = 1, 4 do
    local hasOre, ore = turtle.inspect()
    if hasOre and logOre(ore) then
      turtle.dig()
    end

    pos.turnLeft()
  end

  turtle.dig()
  turtle.forward()

  dropStone()
end



local function loop()

  pos.turnRight()

  -- Branch off
  for i = 1, branchLength do
    branchLoop()
  end

  pos.turnRight()
  pos.turnRight()

  -- Return to the main branch

  for i = 1, branchLength + 1 do
    turtle.forward()
  end

  -- Branch the other side

  for i = 1, branchLength do
    branchLoop()
  end

  -- Come back

  pos.turnRight()
  pos.turnRight()

  for i = 1, branchLength do
    turtle.forward()
  end

  pos.turnLeft()

  -- Make new branches

  for i = 1, 3 do
    branchLoop()
  end
end

local function setup(args)
  pos.detectDirection()

  -- Dig a safe way away from the entrypoint
  for i = 1, 5 do
    branchLoop()
  end
end

return {
  loop = loop,
  setup = setup,
  teardown = teardown,
}