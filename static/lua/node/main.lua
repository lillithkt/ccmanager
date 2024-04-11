if not lvn.config.get("node.password") then
  print("You do not have a password set.")
  io.write("Please enter a password: ")
  local password = io.read("*l")

  lvn.config.set("node.password", password)
end

-- Register node specific packet handlers
require("/run/ws")

sharedWs.connect()



sharedWs.loop()