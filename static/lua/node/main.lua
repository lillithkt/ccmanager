if not lvn.config.get("node.password") then
  print("You do not have a password set.")
  io.write("Please enter a password: ")
  local password = io.read("*l")

  lvn.config.set("node.password", password)
end

ws = require("/run/ws")

ws.connect()



ws.loopWs()