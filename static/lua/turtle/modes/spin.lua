local direction = "left"

local function loop()
  if direction == "left" then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end
end

local function setup(args)
  direction = args[1]
end

local function teardown()
end

return {
  loop = loop,
  setup = setup,
  teardown = teardown
}