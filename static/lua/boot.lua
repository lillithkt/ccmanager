shell.setAlias("boot", "/startup/boot.lua")

local completion = require("cc.shell.completion")

local complete = completion.build({ completion.choice, { "update", "boot"}}, { completion.choice, {"node", "admin"} })

shell.setCompletionFunction(shell.getRunningProgram(), complete)


os.loadAPI("/lvn/core/lvn.lua")
os.loadAPI("/lvn/core/config.lua")
os.loadAPI("/lvn/core/net.lua")
os.loadAPI("/lvn/core/urls.lua")



local tArgs = { ... }

if fs.exists("/run") then
  fs.delete("/run")
end
fs.makeDir("/run")

if tArgs[1] == "update" then

  lvn.net.downloadFile("/lua/update.lua", "/run/update.lua")
  shell.run("/run/update.lua")

  return os.reboot()
end

if tArgs[1] == "boot" and tArgs[2] then
  print("Booting into " .. tArgs[2] .. " mode")
  lvn.config.set("boot.type", tArgs[2])
else
  print("booting...")
end


if fs.exists("/run") then
  fs.delete("/run")
end
fs.makeDir("/run")

if lvn.config.get("boot.customBootUrl") then
  lvn.net.downloadFile(lvn.config.get("boot.customBootUrl"), "/run/boot.lua")
else
  lvn.net.downloadFile("/lua/" .. lvn.config.get("boot.type") .. "/boot.lua", "/run/boot.lua")
end

print("Running boot.lua")

shell.run("/run/boot.lua")

if lvn.config.get("boot.type") == "node" then
  print("Node exited, rebooting...")
  sleep(5)
  os.reboot()
end