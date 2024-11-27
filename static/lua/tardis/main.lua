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

if not lvn.utils.list.contains(methods, "getDestinationDimension") then
  print("Top peripheral does not support Tardis API")
  return
end

sharedWs.registerPacketHandler("getTardisMethods", function()
  sharedWs.send("getTardisMethods", methods) 
end)

sharedWs.registerPacketHandler("executeTardisMethod", function(data)
  local method = data.method
  local args = data.args
  local result = {pcall(tardis[method], table.unpack(args))}
  print("Result: " .. textutils.serializeJSON(result))
  sharedWs.send("executeTardisMethod",
    {
      nonce = data.nonce,
      success = result[1],
      output = {table.unpack(result, 2)}
    }
  )
end)

while true do
  os.sleep(0.1)
end