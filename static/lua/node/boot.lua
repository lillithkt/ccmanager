lvn.net.downloadFile('/lua/node/main.lua', '/run/main.lua')

lvn.net.downloadFile('/lua/node/ws.lua', '/run/ws.lua')

shell.run('/run/main.lua')

print('Exited main.lua, rebooting in 5 seconds...')

sleep(5)

os.reboot()