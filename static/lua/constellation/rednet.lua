sharedRednet.registerPacketHandler("getDimension", function(id, _, nonce)
  local dimension = lvn.config.get("constellation.dimension")
  if dimension then
    sharedRednet.send(id, "getDimensionResponse", { nonce = nonce, dimension = dimension })
  end
end)