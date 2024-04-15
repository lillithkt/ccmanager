if not lvn.config.get("constellation.x") then
  print("You do not have an X coordinate set.")
  io.write("Please enter an X coordinate: ")
  local x = tonumber(io.read("*l"))
  lvn.config.set("constellation.x", x)
  return
end

if not lvn.config.get("constellation.y") then
  print("You do not have a Y coordinate set.")
  io.write("Please enter a Y coordinate: ")
  local y = tonumber(io.read("*l"))
  lvn.config.set("constellation.y", y)
  return
end

if not lvn.config.get("constellation.z") then
  print("You do not have a Z coordinate set.")
  io.write("Please enter a Z coordinate: ")
  local z = tonumber(io.read("*l"))
  lvn.config.set("constellation.z", z)
  return
end



local gpsId = multishell.launch(getfenv(), "/rom/programs/gps.lua", "host", lvn.config.get("constellation.x"), lvn.config.get("constellation.y"), lvn.config.get("constellation.z"))
multishell.setTitle(gpsId, "GPS")

-- Load packet handlers
require("/run/constellation/rednet")
require("/run/constellation/ws")

print("Listening...")

while true do
  sleep(1)
end