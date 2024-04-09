download = require('/lvn/core/download')


download.downloadFile('/lua/node/config.lua', '/run/config.lua')

download.downloadFile('/lua/node/main.lua', '/run/main.lua')

download.downloadFile('/lua/node/ws.lua', '/run/ws.lua')

shell.run('/run/main.lua')