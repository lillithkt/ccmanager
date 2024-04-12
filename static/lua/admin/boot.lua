lvn.net.downloadFile('/lua/admin/toggle.lua', '/run/toggle.lua')
shell.setAlias('toggle', '/run/toggle.lua')
shell.run('/run/toggle.lua completion')


lvn.net.downloadFile('/lua/admin/eval.lua', '/run/eval.lua')
shell.setAlias('eval', '/run/eval.lua')
shell.run('/run/eval.lua completion')

lvn.net.downloadFile('/lua/admin/turtle.lua', '/run/turtle.lua')
shell.setAlias('turtle', '/run/turtle.lua')
shell.run('/run/turtle.lua completion')

lvn.net.downloadFile('/lua/admin/debug.lua', '/run/debug.lua')
shell.setAlias('debug', '/run/debug.lua')
shell.run('/run/debug.lua completion')

lvn.net.downloadFile('/lua/admin/packet.lua', '/run/packet.lua')
shell.setAlias('packet', '/run/packet.lua')
shell.run('/run/packet.lua completion')

lvn.net.downloadFile('/lua/admin/reboot.lua', '/run/reboot.lua')
shell.setAlias('reboot', '/run/reboot.lua')
shell.run('/run/reboot.lua completion')

fs.makeDir("/run/win")
lvn.net.downloadFile('/lua/admin/win/main.lua', '/run/win/main.lua')
shell.setAlias('win', '/run/win/main.lua')


lvn.net.downloadFile('/lua/admin/update.lua', '/run/update.lua')
shell.setAlias('update', '/run/update.lua')


lvn.net.downloadFile('/lua/shared/ws.lua', '/run/sharedWs.lua')

lvn.net.downloadFile('/lua/shared/wsLoop.lua', '/run/wsLoop.lua')

lvn.net.downloadFile('/lua/shared/term.lua', '/run/term.lua')

os.loadAPI('/run/sharedWs.lua')

local wsId = multishell.launch({}, "/run/wsLoop.lua")
multishell.setTitle(wsId, "Websocket Runner")

lvn.config.define("admin.password", {
  description = "The password to access the admin interface",
  type = "string",
})


if not lvn.config.get("admin.password") then
  print("You do not have a password set.")
  io.write("Please enter a password: ")
  local password = io.read("*l")

  lvn.config.set("admin.password", password)
end

-- if peripheral.find("monitor") then
--   shell.run("/run/win/main.lua")
-- end