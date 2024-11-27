print("Tardis Remote Control Receiver")

local tardis = peripheral.wrap("top")
if not tardis then
  print("No Tardis Interface found")
  return
end

local methods = peripheral.getMethods("top")
if not methods then
  print("No methods found")
  return
end

if not utils.table.contains(methods, "getDestinationDimension") then
  print("Top peripheral does not support Tardis API")
  return
end

local ws = require("/run/sharedWs")