

bootConfig = require('/lvn/core/bootConfig')

local urls = {
  httpBase = "http" .. (bootConfig.ssl and "s" or "") .. "://" .. bootConfig.host .. ":" .. bootConfig.port,
  ws = "ws" .. (bootConfig.ssl and "s" or "") .. "://" .. bootConfig.host .. ":" .. bootConfig.port .. "/websocket",
}

return urls