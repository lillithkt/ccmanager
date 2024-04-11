lvn.net.downloadFile('/lua/node/main.lua', '/run/main.lua')

lvn.net.downloadFile('/lua/node/ws.lua', '/run/ws.lua')

lvn.net.downloadFile('/lua/shared/ws.lua', '/run/sharedWs.lua')

os.loadAPI('/run/sharedWs.lua')

shell.run('/run/main.lua')