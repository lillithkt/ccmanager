urls = require("/lvn/core/urls")
config = require("/run/config")


local socket, err = http.websocket(urls.ws)
if not socket then
  printError("Connection Error: ", err)
  os.reboot()
else
  print('Connection established')
  socket.send(textutils.serialiseJSON({ type = "REGISTER", data = config }))
end

return socket