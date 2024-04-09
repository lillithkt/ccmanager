urls = require("/lvn/core/urls")
download = require("/lvn/core/download")
bootConfig = require("/lvn/core/bootConfig")

local tArgs = { ... }

if fs.exists("/run") then
  fs.delete("/run")
end
fs.makeDir("/run")

if tArgs[1] == "update" then

  download.downloadFile("/lua/update.lua", "/run/update.lua")
  shell.run("/run/update.lua")

  return os.reboot()
end

if tArgs[1] == "boot" and tArgs[2] then
  print("Booting into " .. tArgs[2] .. " mode")
  bootConfig.type = tArgs[2]
else
  print("booting...")
end


if fs.exists("/run") then
  fs.delete("/run")
end
fs.makeDir("/run")

if bootConfig.customBootUrl then
  download.downloadFile(bootConfig.customBootUrl, "/run/boot.lua")
else
  download.downloadFile("/lua/" .. bootConfig.type .. "/boot.lua", "/run/boot.lua")
end

print("Running boot.lua")

shell.run("/run/boot.lua")