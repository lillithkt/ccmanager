local function tryChatWs(message)
  sharedWs.send("chat", message)
end

lvn.chat = {
  send = function(message)
    print(message)
    if not pcall(tryChatWs, message) then
      lvn.net.post("/api/node/" .. os.getComputerID() .. "/chat", message)
    end
  end,

  waypoint = function(name, initials, x, y, z, dimension)
    if not x or not y or not z then
      x, y, z = gps.locate()
    end
    if not dimension then 
      dimension = sharedRednet.commands.getDimension()
    end
    lvn.chat.send("xaero-waypoint:" .. name:gsub(":", "") .. ":" .. initials .. ":" .. x .. ":" .. y .. ":" .. z .. ":0:false:0:Internal-" .. dimension .. "-waypoints")
  end,
}