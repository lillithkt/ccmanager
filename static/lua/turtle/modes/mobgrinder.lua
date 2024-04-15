local loopIndex = 1

local function setup(args)
  loopIndex = 1
end

local function teardown()
end

local function dumpItems()
  for i = 1, 16 do
    turtle.select(i)
    local item = turtle.getItemDetail()
    if item then
      if item.name == "minecraft:rotten_flesh" then
        turtle.dropDown()
      else
        turtle.drop()
      end
    end
  end
end

local function loop()
  turtle.attackUp()

  if loopIndex == 16 then
    dumpItems()
    loopIndex = 1
  else
    loopIndex = loopIndex + 1
  end
end

return {
  loop = loop,
  setup = setup,
  teardown = teardown,
}