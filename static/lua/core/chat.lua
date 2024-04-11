local function tryChatWs(message)
  sharedWs.send("chat", message)
end

lvn.chat = function(message)
  print(message)
  if not pcall(tryChatWs, message) then
    lvn.net.post("/api/node/" .. os.getComputerID() .. "/chat", message)
  end
end