local tX = 0
local tY = 0
local tZ = 0

local pos = require("/run/turtle/pos")

local function loop()
  local x, y, z = gps.locate()

  if y > tY then
    turtle.digDown()
    turtle.down()
  elseif y < tY then
    turtle.digUp()
    turtle.up()
  elseif x < tX then
    pos.turnTo("east")
    turtle.dig()
    turtle.forward()
  elseif x > tX then
    pos.turnTo("west")
    turtle.dig()
    turtle.forward()
  elseif z < tZ then
    pos.turnTo("south")
    turtle.dig()
    turtle.forward()
  elseif z > tZ then
    pos.turnTo("north")
    turtle.dig()
    turtle.forward()
  else
    lvn.chat("Arrived!")
    return "done"
  end
end

local function setup(args)
  tX = tonumber(args[1])
  tY = tonumber(args[2])
  tZ = tonumber(args[3])

  pos.detectDirection()
end

local function teardown()
end

return {
  loop = loop,
  setup = setup,
  teardown = teardown,
}