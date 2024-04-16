sharedWs.registerPacketHandler("toggle", function(data)
  redstone.setOutput(data, not redstone.getOutput(data))
end)

sharedWs.registerPacketHandler("turnOn", function(data)
  redstone.setOutput(data, true)
end)

sharedWs.registerPacketHandler("turnOff", function(data)
  redstone.setOutput(data, false)
end)