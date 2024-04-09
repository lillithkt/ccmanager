

if not fs.exists("/lvn/config/node.json") then
  printError("Node configuration file not found!")
  
  io.write("Would you like to create one? (y/n) ")

  while true do
    local response = io.read()
    if response == "y" then
      local config = {
        name = "Unassigned-Name",
        password = ""
      }

      io.write("Enter the name of this node: ")
      config.name = io.read("*l")

      io.write("Enter the password for this node: ")
      config.password = io.read("*l")

      local configFile = fs.open("/lvn/config/node.json", "w")
      configFile.write(textutils.serialiseJSON(config))
      configFile.close()

      print("Configuration file created.")
      break
    elseif response == "n" then
      return os.reboot()
    else
      io.write("Invalid response. Please enter 'y' or 'n': ")
    end
  end

end

local configFile = fs.open("/lvn/config/node.json", "r")
local config = textutils.unserialiseJSON(configFile.readAll())

config.id = os.getComputerID()

return config