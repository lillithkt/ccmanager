lvn.urls = {
  httpBase = "http" .. (lvn.config.get("boot.ssl") and "s" or "") .. "://" .. lvn.config.get("boot.host") .. ":" .. lvn.config.get("boot.port"),
  ws = "ws" .. (lvn.config.get("boot.ssl") and "s" or "") .. "://" .. lvn.config.get("boot.host") .. ":" .. lvn.config.get("boot.port") .. "/websocket",
}