sharedWs.connect()

pcall(sharedWs.loop)

lvn.chat("Websocket crashed, rebooting...")

print("Websocket crashed, rebooting...")

sleep(5)

os.reboot()