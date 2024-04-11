lvn.net.downloadFile('/lua/node/main.lua', '/run/main.lua')

lvn.net.downloadFile('/lua/node/ws.lua', '/run/ws.lua')

lvn.net.downloadFile('/lua/shared/ws.lua', '/run/sharedWs.lua')
lvn.net.downloadFile('/lua/shared/wsLoop.lua', '/run/wsLoop.lua')

if turtle ~= nil then
  fs.makeDir("/run/turtle")
  fs.makeDir("/run/turtle/modes")
  lvn.net.downloadFile('/lua/turtle/main.lua', '/run/turtle/main.lua')
  lvn.net.downloadFile('/lua/turtle/ws.lua', '/run/turtle/ws.lua')
  lvn.net.downloadFile('/lua/turtle/pos.lua', '/run/turtle/pos.lua')
  lvn.net.downloadFile('/lua/turtle/modes/idle.lua', '/run/turtle/modes/idle.lua')
  lvn.net.downloadFile('/lua/turtle/modes/spin.lua', '/run/turtle/modes/spin.lua')
  lvn.net.downloadFile('/lua/turtle/modes/goto.lua', '/run/turtle/modes/goto.lua')
  lvn.net.downloadFile('/lua/turtle/modes/mine.lua', '/run/turtle/modes/mine.lua')
end

os.loadAPI('/run/sharedWs.lua')

shell.run('/run/main.lua')