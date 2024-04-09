if not fs.exists("/lvn/config/boot.json") then
  printError("Boot configuration file not found!")
  return os.shutdown()
end 

local bootFile = fs.open("/lvn/config/boot.json", "r")
local bootConfig = textutils.unserialiseJSON(bootFile.readAll())

bootFile.close()

return bootConfig