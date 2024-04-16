local completion = require('/lvn/core/completion')

completion.setCompletionFunction(function()
  local ccCompletion = require("cc.shell.completion")

  return ccCompletion.build({ ccCompletion.choice, { "reset" }})
end)

completion.setHelpText("Usage: setHome <reset>")
completion.setHelpText("Sets the steps the turtle takes to return home")

local tArgs = { ... }

if not completion.check(tArgs) then
  return
end

local function loadHomeFile()
  if not fs.exists("/lvn/config/turtle/home.json") then
    return {}
  end

  local file = fs.open("/lvn/config/turtle/home.json", "r")
  local data = textutils.unserialize(file.readAll())
  file.close()

  return data
end

local home = loadHomeFile()

local function saveHomeFile()
  local file = fs.open("/lvn/config/turtle/home.json", "w")
  file.write(textutils.serialize(home))
  file.close()
end





if tArgs[1] == "reset" then
  home = {}
  saveHomeFile()
  print("Home reset")
  return
end

local x, y, z = gps.locate()

local number = #home + 1

home[number] = { x, y, z }

saveHomeFile()

print("Home step " .. number .. " set to " .. x .. ", " .. y .. ", " .. z)